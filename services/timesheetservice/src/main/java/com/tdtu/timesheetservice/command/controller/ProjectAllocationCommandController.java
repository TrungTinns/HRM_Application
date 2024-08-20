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

import com.tdtu.timesheetservice.command.command.projectAllocation.CreateProjectAllocationCommand;
import com.tdtu.timesheetservice.command.command.projectAllocation.DeleteProjectAllocationCommand;
import com.tdtu.timesheetservice.command.command.projectAllocation.UpdateProjectAllocationCommand;
import com.tdtu.timesheetservice.command.model.ProjectAllocationRequestModel;

@RestController
@RequestMapping("/api/v1/timesheet/projectAllocation")
public class ProjectAllocationCommandController {
	@Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addProjectAllocation(@RequestBody ProjectAllocationRequestModel model) {
        CreateProjectAllocationCommand command = new CreateProjectAllocationCommand(
                UUID.randomUUID().toString(),
                model.getEmpId(),
                model.getProjectId(),
                model.getTaskId(),
                model.getTimeSpent()
        );
        commandGateway.sendAndWait(command);
        return command.getId();
    }

    @PutMapping
    public String updateProjectAllocation(@RequestBody ProjectAllocationRequestModel model) {
        UpdateProjectAllocationCommand command = new UpdateProjectAllocationCommand(
                model.getId(),
                model.getEmpId(),
                model.getProjectId(),
                model.getTaskId(),
                model.getTimeSpent()

        );
        commandGateway.sendAndWait(command);
        return model.getId();
    }

    @DeleteMapping("/{id}")
    public String deleteProjectAllocation(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteProjectAllocationCommand(id));
        return "Deleted a ProjectAllocation with ID: " + id;
    }
}
