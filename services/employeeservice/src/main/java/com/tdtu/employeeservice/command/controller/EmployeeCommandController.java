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

import com.tdtu.employeeservice.command.command.CreateEmployeeCommand;
import com.tdtu.employeeservice.command.command.DeleteEmployeeCommand;
import com.tdtu.employeeservice.command.command.UpdateEmployeeCommand;
import com.tdtu.employeeservice.command.data.Employee;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;

@RestController
@RequestMapping("/api/v1/employee")
public class EmployeeCommandController {

    @Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addEmployee(@RequestBody EmployeeRequestModel model) {
        CreateEmployeeCommand command = new CreateEmployeeCommand(
        	UUID.randomUUID().toString(),
            model.getFirstName(),
            model.getLastName(),
            model.getEmail(),
            model.getDateOfBirth(),
            model.getPosition(),
            model.getSalary(),
            model.getDepartment(),
            model.getPhone(),
            model.getImg()
        );
        commandGateway.sendAndWait(command);
        return "Added an Employee with ID: " + command.getId();
    }
    
    @PutMapping
    public String updateEmployee(@RequestBody EmployeeRequestModel model) {
        UpdateEmployeeCommand command = new UpdateEmployeeCommand(
            model.getId(),
            model.getFirstName(),
            model.getLastName(),
            model.getEmail(),
            model.getDateOfBirth(),
            model.getPosition(),
            model.getSalary(),
            model.getDepartment(),
            model.getPhone(),
            model.getImg()
        );
        commandGateway.sendAndWait(command);
        return "Updated an Employee with ID: " + model.getId().toString();
    }
    
    @DeleteMapping("/{id}")
    public String deleteEmployee(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteEmployeeCommand(id));
        return "Deleted an Employee with ID: " + id;
    }
}
