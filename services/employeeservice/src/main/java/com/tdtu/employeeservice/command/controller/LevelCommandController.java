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

import com.tdtu.employeeservice.command.command.level.CreateLevelCommand;
import com.tdtu.employeeservice.command.command.level.DeleteLevelCommand;
import com.tdtu.employeeservice.command.command.level.UpdateLevelCommand;
import com.tdtu.employeeservice.command.model.LevelRequestModel;

@RestController
@RequestMapping("/api/v1/level")
public class LevelCommandController {
	@Autowired
	private CommandGateway commandGateway;

	@PostMapping
	public String addLevel(@RequestBody LevelRequestModel model) {
		CreateLevelCommand command = new CreateLevelCommand(
				UUID.randomUUID().toString(),
				model.getSkillType(),
				model.getLevels()
		);
		commandGateway.sendAndWait(command);
		return command.getId();
	}

	@PutMapping
	public String updateLevel(@RequestBody LevelRequestModel model) {
		UpdateLevelCommand command = new UpdateLevelCommand(
				model.getId(),
				model.getSkillType(),
				model.getLevels()
		);
		commandGateway.sendAndWait(command);
		return model.getId();
	}

	@DeleteMapping("/{id}")
	public String deleteLevel(@PathVariable String id) {
		DeleteLevelCommand command = new DeleteLevelCommand(id);
		commandGateway.sendAndWait(command);
		return id;
	}
}
