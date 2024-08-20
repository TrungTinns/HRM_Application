package com.tdtu.employeeservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.employeeservice.command.command.contract.CreateContractCommand;
import com.tdtu.employeeservice.command.command.contract.DeleteContractCommand;
import com.tdtu.employeeservice.command.command.contract.UpdateContractCommand;
import com.tdtu.employeeservice.command.event.contract.ContractCreatedEvent;
import com.tdtu.employeeservice.command.event.contract.ContractDeletedEvent;
import com.tdtu.employeeservice.command.event.contract.ContractUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class ContractAggregate {
	@AggregateIdentifier
	private String id;
	private String referenceName;
	private String department;
	private String empName;
	private String position;
	private String status;
	private String schedule;
	private String schedulePay;
	private String salaryStructure;
	private String contractType;
	private Double cost;
	private String note;
	private String wageType;
	private Date startDate;
	private Date endDate;
	
	// CREATE EVENT
	@CommandHandler
	public ContractAggregate(CreateContractCommand createContractCommand) {
		ContractCreatedEvent ContractCreatedEvent = new ContractCreatedEvent();
		BeanUtils.copyProperties(createContractCommand, ContractCreatedEvent);
		AggregateLifecycle.apply(ContractCreatedEvent);
	}

	@EventSourcingHandler
	public void on(ContractCreatedEvent event) {
		this.id = event.getId();
        this.referenceName = event.getReferenceName();
        this.department = event.getDepartment();
        this.empName = event.getEmpName();
        this.position = event.getPosition();
        this.status = event.getStatus();
        this.schedule = event.getSchedule();
        this.schedulePay = event.getSchedulePay();
        this.salaryStructure = event.getSalaryStructure();
        this.contractType = event.getContractType();
        this.cost = event.getCost();
        this.note = event.getNote();
        this.wageType = event.getWageType();
        this.startDate = event.getStartDate();
        this.endDate = event.getEndDate();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateContractCommand updateContractCommand) {
		ContractUpdatedEvent ContractUpdatedEvent = new ContractUpdatedEvent();
		BeanUtils.copyProperties(updateContractCommand, ContractUpdatedEvent);
		AggregateLifecycle.apply(ContractUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(ContractUpdatedEvent event) {
		this.id = event.getId();
        this.referenceName = event.getReferenceName();
        this.department = event.getDepartment();
        this.empName = event.getEmpName();
        this.position = event.getPosition();
        this.status = event.getStatus();
        this.schedule = event.getSchedule();
        this.schedulePay = event.getSchedulePay();
        this.salaryStructure = event.getSalaryStructure();
        this.contractType = event.getContractType();
        this.cost = event.getCost();
        this.note = event.getNote();
        this.wageType = event.getWageType();
        this.startDate = event.getStartDate();
        this.endDate = event.getEndDate();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteContractCommand deleteContractCommand) {
		ContractDeletedEvent ContractDeletedEvent = new ContractDeletedEvent();
		BeanUtils.copyProperties(deleteContractCommand, ContractDeletedEvent);
		AggregateLifecycle.apply(ContractDeletedEvent);
	}

	@EventSourcingHandler
	public void on(ContractDeletedEvent event) {
		this.id = event.getId();
	}
}
