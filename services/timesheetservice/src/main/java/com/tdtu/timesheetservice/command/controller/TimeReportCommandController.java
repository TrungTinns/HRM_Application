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

import com.tdtu.timesheetservice.command.command.timeReport.CreateTimeReportCommand;
import com.tdtu.timesheetservice.command.command.timeReport.DeleteTimeReportCommand;
import com.tdtu.timesheetservice.command.command.timeReport.UpdateTimeReportCommand;
import com.tdtu.timesheetservice.command.model.TimeReportRequestModel;

@RestController
@RequestMapping("/api/v1/timesheet/timeReport")
public class TimeReportCommandController {
	@Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addTimeReport(@RequestBody TimeReportRequestModel model) {
        CreateTimeReportCommand command = new CreateTimeReportCommand(
                UUID.randomUUID().toString(),
                model.getEmpId(),
                model.getReportType(),
                model.getStartDate(),
                model.getEndDate(),
                model.getTotalHours(),
                model.getOverTimeHours(),
                model.getLeaveDays()
        );
        commandGateway.sendAndWait(command);
        return command.getId();
    }

    @PutMapping
    public String updateTimeReport(@RequestBody TimeReportRequestModel model) {
        UpdateTimeReportCommand command = new UpdateTimeReportCommand(
        		model.getId(),
        		model.getEmpId(),
                model.getReportType(),
                model.getStartDate(),
                model.getEndDate(),
                model.getTotalHours(),
                model.getOverTimeHours(),
                model.getLeaveDays()
        );
        commandGateway.sendAndWait(command);
        return model.getId();
    }

    @DeleteMapping("/{id}")
    public String deleteTimeReport(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteTimeReportCommand(id));
        return "Deleted a TimeReport with ID: " + id;
    }
}
