package com.tdtu.timesheetservice.command.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.UUID;

import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import com.tdtu.timesheetservice.command.command.entrie.CreateEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.DeleteEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.UpdateEntryCommand;
import com.tdtu.timesheetservice.command.model.EntryRequestModel;
import com.tdtu.timesheetservice.query.controller.EntryQueryController;
import com.tdtu.timesheetservice.query.model.EntryResponseModel;
import com.tdtu.timesheetservice.query.model.ErrorResponseModel;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/v1/timesheet")
@Slf4j
public class EntryCommandController {
    @Autowired
    private CommandGateway commandGateway;
    
    @Autowired
    private EntryQueryController entryQueryController;
    
    @PostMapping("/clock-in")
    public ResponseEntity<ErrorResponseModel> addEntry(@RequestBody EntryRequestModel model) throws ParseException {
    	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
    	String formattedClockInDate = outputFormat.format(model.getClockIn());

        EntryResponseModel queryModel = entryQueryController.getEntryByEmpIdAndClockInDate(model.getEmpId(), formattedClockInDate);
        if (queryModel != null && queryModel.getEmpId() != null) {
        	ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.BAD_REQUEST.value(), "Employee has already clocked in on " + formattedClockInDate);
            return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        
        if ( model.getClockOut() != null && model.getClockIn().after(model.getClockOut())) {
        	ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.BAD_REQUEST.value(), "ClockIn date cannot be after the ClockOut date");
        	return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    	}
        
        CreateEntryCommand command = new CreateEntryCommand(
                UUID.randomUUID().toString(),
                model.getEmpId(),
                model.getClockIn(),
                model.getClockOut(),
                model.getBreakStart(),
                model.getBreakEnd(),
                model.getOverTimeHours()
        );
        commandGateway.sendAndWait(command);
        ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.OK.value(), command.getEmpId());
        return new ResponseEntity<>(errorResponse, HttpStatus.OK);
    }

    @PutMapping("/entry")
    public ResponseEntity<ErrorResponseModel> updateEntry(@RequestBody EntryRequestModel model) {
    	if ( model.getClockOut() != null && model.getClockIn().after(model.getClockOut())) {
        	ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.BAD_REQUEST.value(), "ClockIn date cannot be after the ClockOut date");
        	return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    	}
    	
        UpdateEntryCommand command = new UpdateEntryCommand(
                model.getId(),
                model.getEmpId(),
                model.getClockIn(),
                model.getClockOut(),
                model.getBreakStart(),
                model.getBreakEnd(),
                model.getOverTimeHours()
        );
        commandGateway.sendAndWait(command);
        ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.OK.value(), command.getEmpId());
        return new ResponseEntity<>(errorResponse, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public String deleteEntry(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteEntryCommand(id));
        return "Deleted a Entry with ID: " + id;
    }
    
    @ExceptionHandler(InvalidFormatException.class)
    public ResponseEntity<String> handleInvalidFormat(InvalidFormatException e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("invalid date format");
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponseModel> handleException(Exception e) {
    	ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage());
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
