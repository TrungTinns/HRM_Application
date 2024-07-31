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

import com.tdtu.timesheetservice.command.command.entrie.CreateEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.DeleteEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.UpdateEntryCommand;
import com.tdtu.timesheetservice.command.model.EntryRequestModel;

@RestController
@RequestMapping("/api/v1/timesheet/entry")
public class EntryCommandController {
    @Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addEntry(@RequestBody EntryRequestModel model) {
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
        return command.getId();
    }

    @PutMapping
    public String updateEntry(@RequestBody EntryRequestModel model) {
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
        return model.getId();
    }

    @DeleteMapping("/{id}")
    public String deleteEntry(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteEntryCommand(id));
        return "Deleted a Entry with ID: " + id;
    }
}
