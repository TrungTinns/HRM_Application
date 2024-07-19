package com.tdtu.employeeservice.command.aggregate;

import java.util.Date;
import java.util.List;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.employeeservice.command.command.employee.CreateEmployeeCommand;
import com.tdtu.employeeservice.command.command.employee.DeleteEmployeeCommand;
import com.tdtu.employeeservice.command.command.employee.UpdateEmployeeCommand;
import com.tdtu.employeeservice.command.event.employee.EmployeeCreatedEvent;
import com.tdtu.employeeservice.command.event.employee.EmployeeDeletedEvent;
import com.tdtu.employeeservice.command.event.employee.EmployeeUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeAggregate {

	@AggregateIdentifier
	private String id;
	private String firstName;
	private String lastName;
	private String email;
	private Date dateOfBirth;
	private String position;
	private Double salary;
	private String department;
	private String phone;
	private String img;
	private List<String> tags;
	private String managerId;
	private String coachId;
	private DocumentReference resume;

	// CREATE EVENT
	@CommandHandler
	public EmployeeAggregate(CreateEmployeeCommand createEmployeeCommand) {
		EmployeeCreatedEvent employeeCreatedEvent = new EmployeeCreatedEvent();
		BeanUtils.copyProperties(createEmployeeCommand, employeeCreatedEvent);
		AggregateLifecycle.apply(employeeCreatedEvent);
	}

	@EventSourcingHandler
	public void on(EmployeeCreatedEvent event) {
		this.id = event.getId();
		this.firstName = event.getFirstName();
		this.lastName = event.getLastName();
		this.email = event.getEmail();
		this.dateOfBirth = event.getDateOfBirth();
		this.position = event.getPosition();
		this.salary = event.getSalary();
		this.department = event.getDepartment();
		this.phone = event.getPhone();
		this.img = event.getImg();
		this.tags = event.getTags();
		this.managerId = event.getManagerId();
		this.coachId = event.getCoachId();
		this.resume = event.getResume();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateEmployeeCommand updateEmployeeCommand) {
		EmployeeUpdatedEvent employeeUpdatedEvent = new EmployeeUpdatedEvent();
		BeanUtils.copyProperties(updateEmployeeCommand, employeeUpdatedEvent);
		AggregateLifecycle.apply(employeeUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(EmployeeUpdatedEvent event) {
		this.id = event.getId();
		this.firstName = event.getFirstName();
		this.lastName = event.getLastName();
		this.email = event.getEmail();
		this.dateOfBirth = event.getDateOfBirth();
		this.position = event.getPosition();
		this.salary = event.getSalary();
		this.department = event.getDepartment();
		this.phone = event.getPhone();
		this.img = event.getImg();
		this.tags = event.getTags();
		this.managerId = event.getManagerId();
		this.coachId = event.getCoachId();
		this.resume = event.getResume();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteEmployeeCommand deleteEmployeeCommand) {
		EmployeeDeletedEvent employeeDeletedEvent = new EmployeeDeletedEvent();
		BeanUtils.copyProperties(deleteEmployeeCommand, employeeDeletedEvent);
		AggregateLifecycle.apply(employeeDeletedEvent);
	}

	@EventSourcingHandler
	public void on(EmployeeDeletedEvent event) {
		this.id = event.getId();
	}
}
