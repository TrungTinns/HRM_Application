package com.tdtu.timesheetservice.command.controller;

import java.text.ParseException;
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

import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import com.tdtu.timesheetservice.command.command.entrie.CreateEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.DeleteEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.UpdateEntryCommand;
import com.tdtu.timesheetservice.command.model.EntryRequestModel;
import com.tdtu.timesheetservice.query.controller.EntryQueryController;
import com.tdtu.timesheetservice.query.model.EntryResponseModel;

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
    public ResponseEntity<String> addEntry(@RequestBody EntryRequestModel model) throws ParseException {
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
        return ResponseEntity.ok(command.getId());
    }

    @PutMapping("/clock-out")
    public ResponseEntity<String> updateEntry(@RequestBody EntryRequestModel model) {
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
        return ResponseEntity.ok(model.getId());
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
    public ResponseEntity<String> handleException(Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Invalid Format please convert it into 'yyyy-MM-dd'T'HH:mm:ss'");
    }
}
