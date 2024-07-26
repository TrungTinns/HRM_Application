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

import com.tdtu.employeeservice.command.command.contract.CreateContractCommand;
import com.tdtu.employeeservice.command.command.contract.DeleteContractCommand;
import com.tdtu.employeeservice.command.command.contract.UpdateContractCommand;
import com.tdtu.employeeservice.command.model.ContractRequestModel;

@RestController
@RequestMapping("/api/v1/employee/contract")
public class ContractCommandController {
	@Autowired
	private CommandGateway commandGateway;
	
	 @PostMapping
	    public String addContract(@RequestBody ContractRequestModel model) {
			 CreateContractCommand command = new CreateContractCommand(
					 UUID.randomUUID().toString(),
					 model.getReferenceName(),
			         model.getDepartment(),
			         model.getEmpName(),
			         model.getPosition(),
			         model.getStatus(),
			         model.getSchedule(),
			         model.getSchedulePay(),
			         model.getSalaryStructure(),
			         model.getContractType(),
			         model.getCost(),
			         model.getNote(),
			         model.getWageType(),
			         model.getStartDate(),
			         model.getEndDate()
			);
	         commandGateway.sendAndWait(command);
	         return command.getId();
	    }


		@PutMapping
		public String updateContract(@RequestBody ContractRequestModel model) {
			UpdateContractCommand command = new UpdateContractCommand(
					model.getId(),
					model.getReferenceName(),
			        model.getDepartment(),
			        model.getEmpName(),
			        model.getPosition(),
			        model.getStatus(),
			        model.getSchedule(),
			        model.getSchedulePay(),
			        model.getSalaryStructure(),
			        model.getContractType(),
			        model.getCost(),
			        model.getNote(),
			        model.getWageType(),
			        model.getStartDate(),
			        model.getEndDate()
			);
			commandGateway.sendAndWait(command);
			return model.getId().toString();
		}

		@DeleteMapping("/{id}")
		public String deleteContract(@PathVariable String id) {
			commandGateway.sendAndWait(new DeleteContractCommand(id));
			return "Deleted an Contract with ID: " + id;
		}
}
