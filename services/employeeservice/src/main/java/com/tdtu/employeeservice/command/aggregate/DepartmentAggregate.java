package com.tdtu.employeeservice.command.aggregate;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.employeeservice.command.command.department.CreateDepartmentCommand;
import com.tdtu.employeeservice.command.command.department.DeleteDepartmentCommand;
import com.tdtu.employeeservice.command.command.department.UpdateDepartmentCommand;
import com.tdtu.employeeservice.command.event.department.DepartmentCreatedEvent;
import com.tdtu.employeeservice.command.event.department.DepartmentDeletedEvent;
import com.tdtu.employeeservice.command.event.department.DepartmentUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class DepartmentAggregate {
	@AggregateIdentifier
	private String id;
	private String name;
	private String managerId;
	private String parentDepartmentId;
	
	// CREATE EVENT
	@CommandHandler
	public DepartmentAggregate(CreateDepartmentCommand createDepartmentCommand) {
		DepartmentCreatedEvent DepartmentCreatedEvent = new DepartmentCreatedEvent();
		BeanUtils.copyProperties(createDepartmentCommand, DepartmentCreatedEvent);
		AggregateLifecycle.apply(DepartmentCreatedEvent);
	}

	@EventSourcingHandler
	public void on(DepartmentCreatedEvent event) {
		this.id = event.getId();
		this.name = event.getManagerId();
		this.managerId = event.getManagerId();
		this.parentDepartmentId = event.getParentDepartmentId();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateDepartmentCommand updateDepartmentCommand) {
		DepartmentUpdatedEvent DepartmentUpdatedEvent = new DepartmentUpdatedEvent();
		BeanUtils.copyProperties(updateDepartmentCommand, DepartmentUpdatedEvent);
		AggregateLifecycle.apply(DepartmentUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(DepartmentUpdatedEvent event) {
		this.id = event.getId();
		this.name = event.getManagerId();
		this.managerId = event.getManagerId();
		this.parentDepartmentId = event.getParentDepartmentId();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteDepartmentCommand deleteDepartmentCommand) {
		DepartmentDeletedEvent DepartmentDeletedEvent = new DepartmentDeletedEvent();
		BeanUtils.copyProperties(deleteDepartmentCommand, DepartmentDeletedEvent);
		AggregateLifecycle.apply(DepartmentDeletedEvent);
	}

	@EventSourcingHandler
	public void on(DepartmentDeletedEvent event) {
		this.id = event.getId();
	}
}
