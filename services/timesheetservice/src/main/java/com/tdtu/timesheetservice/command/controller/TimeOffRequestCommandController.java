package com.tdtu.timesheetservice.command.controller;

import java.util.UUID;

import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.timesheetservice.command.command.timeOffRequest.CreateTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.command.timeOffRequest.DeleteTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.command.timeOffRequest.UpdateTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.model.TimeOffRequestRequestModel;

@RestController
@RequestMapping("/api/v1/timesheet/timeOffRequest")
public class TimeOffRequestCommandController {
	@Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addTimeOffRequest(@RequestBody TimeOffRequestRequestModel model) {
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
}
