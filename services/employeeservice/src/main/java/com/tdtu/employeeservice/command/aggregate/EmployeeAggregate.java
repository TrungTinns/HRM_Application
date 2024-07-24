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
	private String name;
	private String mail;
	private String mobile;
	private String department;
	private String managerId;
	private boolean isManager;
	private String workLocation;
	private String schedule;
	private String salaryStructure;
	private String contractType;
	private Double cost;
	private String personalAddress;
	private String personalMail;
	private String personalMobile;
	private String certification;
	private String school;
	private String maritalStatus;
	private int child;
	private String nationality;
	private String idNum;
	private String ssNum;
	private String passport;
	private String sex;
	private Date birthDate;
	private String birthPlace;

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
		this.name = event.getFirstName();
		this.mail = event.getLastName();
		this.mobile = event.getEmail();
		this.department = event.getDateOfBirth();
		this.managerId = event.getPosition();
		this.isManager = event.getSalary();
		this.workLocation = event.getDepartment();
		this.schedule = event.getPhone();
		this.salaryStructure = event.getImg();
		this.contractType = event.getTags();
		this.cost = event.getManagerId();
		this.personalAddress = event.getCoachId();
		this.personalMail = event.getResume();
		this.personalMobile = event.getId();
		this.certification = event.getFirstName();
		this.school = event.getLastName();
		this.maritalStatus = event.getEmail();
		this.child = event.getDateOfBirth();
		this.nationality = event.getPosition();
		this.idNum = event.getSalary();
		this.ssNum = event.getDepartment();
		this.passport = event.getPhone();
		this.sex = event.getImg();
		this.birthDate = event.getTags();
		this.managerId = event.getManagerId();
		this.birthPlace = event.getCoachId();
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
		this.name = event.getFirstName();
		this.mail = event.getLastName();
		this.mobile = event.getEmail();
		this.department = event.getDateOfBirth();
		this.managerId = event.getPosition();
		this.isManager = event.getSalary();
		this.workLocation = event.getDepartment();
		this.schedule = event.getPhone();
		this.salaryStructure = event.getImg();
		this.contractType = event.getTags();
		this.cost = event.getManagerId();
		this.personalAddress = event.getCoachId();
		this.personalMail = event.getResume();
		this.personalMobile = event.getId();
		this.certification = event.getFirstName();
		this.school = event.getLastName();
		this.maritalStatus = event.getEmail();
		this.child = event.getDateOfBirth();
		this.nationality = event.getPosition();
		this.idNum = event.getSalary();
		this.ssNum = event.getDepartment();
		this.passport = event.getPhone();
		this.sex = event.getImg();
		this.birthDate = event.getTags();
		this.managerId = event.getManagerId();
		this.birthPlace = event.getCoachId();
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
