package com.tdtu.employeeservice.command.event;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.Employee;
import com.tdtu.employeeservice.command.data.EmployeeService;


@Component
public class EmployeeEventsHandler {

	@Autowired
	private EmployeeService empService;
	
	@EventHandler
	public void on(EmployeeCreatedEvent event) throws InterruptedException, ExecutionException {
		Employee emp = new Employee();
		BeanUtils.copyProperties(event, emp);
		empService.save(emp);
	}
	
	@EventHandler
	public void on(EmployeeUpdatedEvent event) throws InterruptedException, ExecutionException {
		Optional<Employee> empOptional = Optional.ofNullable(empService.findById(event.getId()));
		if (empOptional.isPresent()) {
			Employee emp = empOptional.get();
			emp.setFirstName(event.getFirstName());
			emp.setLastName(event.getLastName());
			emp.setDateOfBirth(event.getDateOfBirth());
			emp.setDepartment(event.getDepartment());
			emp.setImg(event.getImg());
			emp.setPhone(event.getPhone());
			emp.setPosition(event.getPosition());
			emp.setSalary(event.getSalary());
			emp.setEmail(event.getEmail());
			empService.save(emp);
		}
		else {
		}
	}
	
	@EventHandler
	public void on(EmployeeDeletedEvent event) {
		empService.deleteById(event.getId());
	}
}
