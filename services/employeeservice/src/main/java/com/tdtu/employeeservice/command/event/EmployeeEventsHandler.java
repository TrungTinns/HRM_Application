package com.tdtu.employeeservice.command.event;

import java.util.Optional;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.Employee;
import com.tdtu.employeeservice.command.data.EmployeeRepository;


@Component
public class EmployeeEventsHandler {

	@Autowired
	private EmployeeRepository empRepository;

	@EventHandler
	public void on(EmployeeCreatedEvent event) {
		Employee emp = new Employee();
		BeanUtils.copyProperties(event, emp);
		empRepository.save(emp);
	}
	
	@EventHandler
	public void on(EmployeeUpdatedEvent event) {
		Optional<Employee> empOptional = empRepository.findById(event.getId());
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
			empRepository.save(emp);
		}
		else {
		}
	}
	
	@EventHandler
	public void on(EmployeeDeletedEvent event) {
		empRepository.deleteById(event.getId());
	}
}
