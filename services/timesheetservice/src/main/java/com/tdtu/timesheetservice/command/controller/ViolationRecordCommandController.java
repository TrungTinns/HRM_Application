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

import com.tdtu.timesheetservice.command.command.violationRecord.CreateViolationRecordCommand;
import com.tdtu.timesheetservice.command.command.violationRecord.DeleteViolationRecordCommand;
import com.tdtu.timesheetservice.command.command.violationRecord.UpdateViolationRecordCommand;
import com.tdtu.timesheetservice.command.model.ViolationRecordRequestModel;

@RestController
@RequestMapping("/api/v1/timesheet/violationRecord")
public class ViolationRecordCommandController {
	@Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addViolationRecord(@RequestBody ViolationRecordRequestModel model) {
        CreateViolationRecordCommand command = new CreateViolationRecordCommand(
                UUID.randomUUID().toString(),
                model.getEmpId(),
                model.getRuleId(),
                model.getViolationDate(),
                model.getPenaltyApplied(),
                model.getComment()
        );
        commandGateway.sendAndWait(command);
        return command.getId();
    }

    @PutMapping
    public String updateViolationRecord(@RequestBody ViolationRecordRequestModel model) {
        UpdateViolationRecordCommand command = new UpdateViolationRecordCommand(
        		model.getId(),
        		model.getEmpId(),
                model.getRuleId(),
                model.getViolationDate(),
                model.getPenaltyApplied(),
                model.getComment()
        );
        commandGateway.sendAndWait(command);
        return model.getId();
    }

    @DeleteMapping("/{id}")
    public String deleteViolationRecord(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteViolationRecordCommand(id));
        return "Deleted a ViolationRecord with ID: " + id;
    }
}
