package com.tdtu.employeeservice.command.event.employee;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.firebase.cloud.FirestoreClient;
import com.tdtu.employeeservice.command.data.employee.Employee;
import com.tdtu.employeeservice.command.data.employee.EmployeeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class EmployeeEventsHandler {

	@Autowired
	private EmployeeService empService;

	@EventHandler
	public void on(EmployeeCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling EmployeeCreatedEvent for: " + event.getId());
		Employee emp = new Employee();
		BeanUtils.copyProperties(event, emp);
		empService.save(emp);
		log.info("Employee created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(EmployeeUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling EmployeeUpdatedEvent for: " + event.getId());
		Optional<Employee> empOptional = Optional.ofNullable(empService.findById(event.getId()));
		if (empOptional.isPresent()) {
			Employee emp = empOptional.get();
			BeanUtils.copyProperties(event, emp);
			empService.update(emp);
			log.info("Employee updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("Employee not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(EmployeeDeletedEvent event) {
		log.info("Handling EmployeeDeletedEvent for: " + event.getId());
		empService.deleteById(event.getId());
		log.info("Employee deleted from Firestore: " + event.getId());
	}
}
