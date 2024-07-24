package com.tdtu.employeeservice.command.controller;

import java.util.UUID;
import java.util.concurrent.ExecutionException;

import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.command.command.employee.CreateEmployeeCommand;
import com.tdtu.employeeservice.command.command.employee.DeleteEmployeeCommand;
import com.tdtu.employeeservice.command.command.employee.UpdateEmployeeCommand;
import com.tdtu.employeeservice.command.data.employee.EmployeeService;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;

@RestController
@RequestMapping("/api/v1/employee")
public class EmployeeCommandController {

	@Autowired
	private CommandGateway commandGateway;
	
    @Autowired
    private EmployeeService empService;

    @PostMapping
    public String addEmployee(@RequestBody EmployeeRequestModel model) throws InterruptedException, ExecutionException {
    	CreateEmployeeCommand command = new CreateEmployeeCommand(UUID.randomUUID().toString(), model.getName(),
                model.getRole(), model.getMail(), model.getMobile(), model.getDepartment(), model.getManagerId(),
                model.isManager(), model.getWorkLocation(), model.getSchedule(), model.getSalaryStructure(), model.getContractType(),
                model.getCost(), model.getPersonalAddress(), model.getPersonalMail(), model.getPersonalMobile(), model.getRelativeName(), model.getRelativeMobile(), 
                model.getCertification(), model.getSchool(), model.getMaritalStatus(), model.getChild(), model.getNationality(), model.getIdNum(), model.getSsNum(), 
                model.getPassport(), model.getSex(), model.getBirthDate(), model.getBirthPlace());
        commandGateway.sendAndWait(command);
        return "Added an Employee with ID: " + command.getId();
    }


	@PutMapping
	public String updateEmployee(@RequestBody EmployeeRequestModel model) throws InterruptedException, ExecutionException {
		UpdateEmployeeCommand command = new UpdateEmployeeCommand(model.getId(), model.getName(),
				model.getRole(), model.getMail(), model.getMobile(), model.getDepartment(), model.getManagerId(),
                model.isManager(), model.getWorkLocation(), model.getSchedule(), model.getSalaryStructure(), model.getContractType(),
                model.getCost(), model.getPersonalAddress(), model.getPersonalMail(), model.getPersonalMobile(), model.getRelativeName(), model.getRelativeMobile(), 
                model.getCertification(), model.getSchool(), model.getMaritalStatus(), model.getChild(), model.getNationality(), model.getIdNum(), model.getSsNum(), 
                model.getPassport(), model.getSex(), model.getBirthDate(), model.getBirthPlace());
		commandGateway.sendAndWait(command);
		return "Updated an Employee with ID: " + model.getId().toString();
	}

	@DeleteMapping("/{id}")
	public String deleteEmployee(@PathVariable String id) {
		commandGateway.sendAndWait(new DeleteEmployeeCommand(id));
		return "Deleted an Employee with ID: " + id;
	}
}
