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
		this.name = event.getName();
		this.mail = event.getMail();
		this.mobile = event.getMobile();
		this.department = event.getDepartment();
		this.managerId = event.getManagerId();
		this.isManager = event.isManager();
		this.workLocation = event.getWorkLocation();
		this.schedule = event.getSchedule();
		this.salaryStructure = event.getSalaryStructure();
		this.contractType = event.getContractType();
		this.cost = event.getCost();
		this.personalAddress = event.getPersonalAddress();
		this.personalMail = event.getPersonalMail();
		this.personalMobile = event.getPersonalMobile();
		this.certification = event.getCertification();
		this.school = event.getSchool();
		this.maritalStatus = event.getMaritalStatus();
		this.child = event.getChild();
		this.nationality = event.getNationality();
		this.idNum = event.getIdNum();
		this.ssNum = event.getSsNum();
		this.passport = event.getPassport();
		this.sex = event.getSex();
		this.birthDate = event.getBirthDate();
		this.birthPlace = event.getBirthPlace();
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
		this.name = event.getName();
		this.mail = event.getMail();
		this.mobile = event.getMobile();
		this.department = event.getDepartment();
		this.managerId = event.getManagerId();
		this.isManager = event.isManager();
		this.workLocation = event.getWorkLocation();
		this.schedule = event.getSchedule();
		this.salaryStructure = event.getSalaryStructure();
		this.contractType = event.getContractType();
		this.cost = event.getCost();
		this.personalAddress = event.getPersonalAddress();
		this.personalMail = event.getPersonalMail();
		this.personalMobile = event.getPersonalMobile();
		this.certification = event.getCertification();
		this.school = event.getSchool();
		this.maritalStatus = event.getMaritalStatus();
		this.child = event.getChild();
		this.nationality = event.getNationality();
		this.idNum = event.getIdNum();
		this.ssNum = event.getSsNum();
		this.passport = event.getPassport();
		this.sex = event.getSex();
		this.birthDate = event.getBirthDate();
		this.birthPlace = event.getBirthPlace();
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
