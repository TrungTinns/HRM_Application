package com.tdtu.recruitmentservice.command.controller;

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

import com.tdtu.recruitmentservice.command.command.jobPosition.CreateJobPositionCommand;
import com.tdtu.recruitmentservice.command.command.jobPosition.DeleteJobPositionCommand;
import com.tdtu.recruitmentservice.command.command.jobPosition.UpdateJobPositionCommand;
import com.tdtu.recruitmentservice.command.model.JobPositionRequestModel;

@RestController
@RequestMapping("/api/v1/recruitment/jobPosition")
public class JobPostionCommandController {
	@Autowired
	private CommandGateway commandGateway;
	
	 @PostMapping
	    public String addJobPosition(@RequestBody JobPositionRequestModel model) {
			CreateJobPositionCommand command = new CreateJobPositionCommand(
					UUID.randomUUID().toString(),
		            model.getName(),
		            model.getDepartment(),
		            model.getJobLocation(),
		            model.getMailAlias(),
		            model.getEmpType(),
		            model.getTarget(),
		            model.getRecruiterId(),
		            model.getInterviewers(),
		            model.getDescription()
			);
	         commandGateway.sendAndWait(command);
	         return command.getId();
	    }


		@PutMapping
		public String updateJobPosition(@RequestBody JobPositionRequestModel model) {
			UpdateJobPositionCommand command = new UpdateJobPositionCommand(
					model.getId(),
					model.getName(),
		            model.getDepartment(),
		            model.getJobLocation(),
		            model.getMailAlias(),
		            model.getEmpType(),
		            model.getTarget(),
		            model.getRecruiterId(),
		            model.getInterviewers(),
		            model.getDescription()
			);
			commandGateway.sendAndWait(command);
			return model.getId().toString();
		}

		@DeleteMapping("/{id}")
		public String deleteJobPosition(@PathVariable String id) {
			commandGateway.sendAndWait(new DeleteJobPositionCommand(id));
			return "Deleted an JobPosition with ID: " + id;
		}
}
