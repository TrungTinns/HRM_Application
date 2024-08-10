package com.tdtu.timesheetservice.command.controller;

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

import com.tdtu.timesheetservice.command.command.timeOffRequest.CreateTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.command.timeOffRequest.DeleteTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.command.timeOffRequest.UpdateTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.model.TimeOffRequestRequestModel;
import com.tdtu.timesheetservice.query.model.ErrorResponseModel;

@RestController
@RequestMapping("/api/v1/timesheet/timeOffRequest")
public class TimeOffRequestCommandController {
	@Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addTimeOffRequest(@RequestBody TimeOffRequestRequestModel model) {
    	if (model.getStartDate().after(model.getEndDate())) {
    		throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Start date cannot be after the end date");
    	}
    	
        CreateTimeOffRequestCommand command = new CreateTimeOffRequestCommand(
                UUID.randomUUID().toString(),
                model.getEmpId(),
                model.getLeaveType(),
                model.getApplicationDate(),
                model.getStartDate(),
                model.getEndDate(),
                model.getStatus()
        );
        commandGateway.sendAndWait(command);
        return command.getId();
    }

    @PutMapping
    public String updateTimeOffRequest(@RequestBody TimeOffRequestRequestModel model) {
    	if (model.getStartDate().after(model.getEndDate())) {
    		throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Start date cannot be after the end date");
    	}
    	
        UpdateTimeOffRequestCommand command = new UpdateTimeOffRequestCommand(
                model.getId(),
                model.getEmpId(),
                model.getLeaveType(),
                model.getApplicationDate(),
                model.getStartDate(),
                model.getEndDate(),
                model.getStatus()

        );
        commandGateway.sendAndWait(command);
        return model.getId();
    }

    @DeleteMapping("/{id}")
    public String deleteTimeOffRequest(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteTimeOffRequestCommand(id));
        return "Deleted a TimeOffRequest with ID: " + id;
    }
    
    @ExceptionHandler(ResponseStatusException.class)
    public ResponseEntity<ErrorResponseModel> handleResponseStatusException(ResponseStatusException e) {
        String message = e.getReason() != null ? e.getReason() : "An unexpected error occurred";
        ErrorResponseModel errorResponse = new ErrorResponseModel(e.getStatusCode().value(), message);
        return new ResponseEntity<>(errorResponse, e.getStatusCode());
    }
		
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponseModel> handleException(Exception e) {
    	ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage());
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
