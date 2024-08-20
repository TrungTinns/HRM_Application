package com.tdtu.timesheetservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.timesheetservice.command.command.violationRecord.CreateViolationRecordCommand;
import com.tdtu.timesheetservice.command.command.violationRecord.DeleteViolationRecordCommand;
import com.tdtu.timesheetservice.command.command.violationRecord.UpdateViolationRecordCommand;
import com.tdtu.timesheetservice.command.event.vilationRecord.ViolationRecordCreatedEvent;
import com.tdtu.timesheetservice.command.event.vilationRecord.ViolationRecordDeletedEvent;
import com.tdtu.timesheetservice.command.event.vilationRecord.ViolationRecordUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class ViolationRecordAggregate {
	@AggregateIdentifier
	private String id;
	private String empId;
	private String ruleId;
	private Date violationDate;
	private boolean penaltyApplied;
	private String comment;

	
	// CREATE EVENT
	@CommandHandler
	public ViolationRecordAggregate(CreateViolationRecordCommand createViolationRecordCommand) {
		ViolationRecordCreatedEvent ViolationRecordCreatedEvent = new ViolationRecordCreatedEvent();
		BeanUtils.copyProperties(createViolationRecordCommand, ViolationRecordCreatedEvent);
		AggregateLifecycle.apply(ViolationRecordCreatedEvent);
	}

	@EventSourcingHandler
	public void on(ViolationRecordCreatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.ruleId = event.getRuleId();
        this.violationDate = event.getViolationDate();
        this.penaltyApplied = event.getPenaltyApplied();
        this.comment = event.getComment();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateViolationRecordCommand updateViolationRecordCommand) {
		ViolationRecordUpdatedEvent ViolationRecordUpdatedEvent = new ViolationRecordUpdatedEvent();
		BeanUtils.copyProperties(updateViolationRecordCommand, ViolationRecordUpdatedEvent);
		AggregateLifecycle.apply(ViolationRecordUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(ViolationRecordUpdatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.ruleId = event.getRuleId();
        this.violationDate = event.getViolationDate();
        this.penaltyApplied = event.getPenaltyApplied();
        this.comment = event.getComment();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteViolationRecordCommand deleteViolationRecordCommand) {
		ViolationRecordDeletedEvent ViolationRecordDeletedEvent = new ViolationRecordDeletedEvent();
		BeanUtils.copyProperties(deleteViolationRecordCommand, ViolationRecordDeletedEvent);
		AggregateLifecycle.apply(ViolationRecordDeletedEvent);
	}

	@EventSourcingHandler
	public void on(ViolationRecordDeletedEvent event) {
		this.id = event.getId();
	}
}
