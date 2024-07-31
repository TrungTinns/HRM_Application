package com.tdtu.timesheetservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.timesheetservice.command.command.timeOffRequest.CreateTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.command.timeOffRequest.DeleteTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.command.timeOffRequest.UpdateTimeOffRequestCommand;
import com.tdtu.timesheetservice.command.event.timeOffRequest.TimeOffRequestCreatedEvent;
import com.tdtu.timesheetservice.command.event.timeOffRequest.TimeOffRequestDeletedEvent;
import com.tdtu.timesheetservice.command.event.timeOffRequest.TimeOffRequestUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class TimeOffRequestAggregate {
	@AggregateIdentifier
	private String id;
	private String empId;
	private String leaveType;
	private Date applicationDate;
	private Date startDate;
	private Date endDate;
	private String status;

	
	// CREATE EVENT
	@CommandHandler
	public TimeOffRequestAggregate(CreateTimeOffRequestCommand createTimeOffRequestCommand) {
		TimeOffRequestCreatedEvent TimeOffRequestCreatedEvent = new TimeOffRequestCreatedEvent();
		BeanUtils.copyProperties(createTimeOffRequestCommand, TimeOffRequestCreatedEvent);
		AggregateLifecycle.apply(TimeOffRequestCreatedEvent);
	}

	@EventSourcingHandler
	public void on(TimeOffRequestCreatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.leaveType = event.getLeaveType();
        this.applicationDate = event.getApplicationDate();
        this.startDate = event.getStartDate();
        this.endDate = event.getEndDate();
        this.status = event.getStatus();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateTimeOffRequestCommand updateTimeOffRequestCommand) {
		TimeOffRequestUpdatedEvent TimeOffRequestUpdatedEvent = new TimeOffRequestUpdatedEvent();
		BeanUtils.copyProperties(updateTimeOffRequestCommand, TimeOffRequestUpdatedEvent);
		AggregateLifecycle.apply(TimeOffRequestUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(TimeOffRequestUpdatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.leaveType = event.getLeaveType();
        this.applicationDate = event.getApplicationDate();
        this.startDate = event.getStartDate();
        this.endDate = event.getEndDate();
        this.status = event.getStatus();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteTimeOffRequestCommand deleteTimeOffRequestCommand) {
		TimeOffRequestDeletedEvent TimeOffRequestDeletedEvent = new TimeOffRequestDeletedEvent();
		BeanUtils.copyProperties(deleteTimeOffRequestCommand, TimeOffRequestDeletedEvent);
		AggregateLifecycle.apply(TimeOffRequestDeletedEvent);
	}

	@EventSourcingHandler
	public void on(TimeOffRequestDeletedEvent event) {
		this.id = event.getId();
	}
}
