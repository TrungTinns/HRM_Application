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

import com.tdtu.employeeservice.command.command.department.CreateDepartmentCommand;
import com.tdtu.employeeservice.command.command.department.DeleteDepartmentCommand;
import com.tdtu.employeeservice.command.command.department.UpdateDepartmentCommand;
import com.tdtu.employeeservice.command.model.DepartmentRequestModel;

@RestController
@RequestMapping("/api/v1/employee/department")
public class DepartmentCommandController {
	@Autowired
	private CommandGateway commandGateway;
	
	 @PostMapping
	    public String addDepartment(@RequestBody DepartmentRequestModel model) {
			 CreateDepartmentCommand command = new CreateDepartmentCommand(
					 UUID.randomUUID().toString(),
					 model.getName(),
					 model.getManagerId(),
					 model.getParentDepartmentId()
			);
	         commandGateway.sendAndWait(command);
	         return "Added an Department with ID: " + command.getId();
	    }


		@PutMapping
		public String updateDepartment(@RequestBody DepartmentRequestModel model) {
			UpdateDepartmentCommand command = new UpdateDepartmentCommand(
					model.getId(),
					model.getName(),
					 model.getManagerId(),
					 model.getParentDepartmentId()
			);
			commandGateway.sendAndWait(command);
			return "Updated an Department with ID: " + model.getId().toString();
		}

		@DeleteMapping("/{id}")
		public String deleteDepartment(@PathVariable String id) {
			commandGateway.sendAndWait(new DeleteDepartmentCommand(id));
			return "Deleted an Department with ID: " + id;
		}
}
