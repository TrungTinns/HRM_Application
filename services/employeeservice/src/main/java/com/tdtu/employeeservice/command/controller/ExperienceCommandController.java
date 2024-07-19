package com.tdtu.employeeservice.command.controller;

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

import com.tdtu.employeeservice.command.command.experience.CreateExperienceCommand;
import com.tdtu.employeeservice.command.command.experience.DeleteExperienceCommand;
import com.tdtu.employeeservice.command.command.experience.UpdateExperienceCommand;
import com.tdtu.employeeservice.command.model.ExperienceRequestModel;

@RestController
@RequestMapping("/api/v1/experience")
public class ExperienceCommandController {

	@Autowired
	private CommandGateway commandGateway;

	@PostMapping
	public String addExperience(@RequestBody ExperienceRequestModel model) {
		CreateExperienceCommand command = new CreateExperienceCommand(
				UUID.randomUUID().toString(), 
				model.getExperiences()
		);
		commandGateway.sendAndWait(command);
		return command.getId();
	}

	@PutMapping
	public String updateExperience(@RequestBody ExperienceRequestModel model) {
		UpdateExperienceCommand command = new UpdateExperienceCommand(
				model.getId(), 
				model.getExperiences()
		);
		commandGateway.sendAndWait(command);
		return model.getId();
	}

	@DeleteMapping("/{id}")
	public String deleteExperience(@PathVariable String id) {
		DeleteExperienceCommand conmmand = new DeleteExperienceCommand(id);
		commandGateway.sendAndWait(conmmand);
		return id; 
	}
}
