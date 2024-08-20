package com.tdtu.timesheetservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.timesheetservice.command.command.entrie.CreateEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.DeleteEntryCommand;
import com.tdtu.timesheetservice.command.command.entrie.UpdateEntryCommand;
import com.tdtu.timesheetservice.command.event.entrie.EntryCreatedEvent;
import com.tdtu.timesheetservice.command.event.entrie.EntryDeletedEvent;
import com.tdtu.timesheetservice.command.event.entrie.EntryUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class EntryAggregate {
	@AggregateIdentifier
	private String id;
	private String empId;
	private Date clockIn;
	private Date clockOut;
	private Date breakStart;
	private Date breakEnd;
	private Double overTimeHours;
	
	// CREATE EVENT
	@CommandHandler
	public EntryAggregate(CreateEntryCommand createCandidateCommand) {
		EntryCreatedEvent CandidateCreatedEvent = new EntryCreatedEvent();
		BeanUtils.copyProperties(createCandidateCommand, CandidateCreatedEvent);
		AggregateLifecycle.apply(CandidateCreatedEvent);
	}

	@EventSourcingHandler
	public void on(EntryCreatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.clockIn = event.getClockIn();
        this.clockOut = event.getClockOut();
        this.breakStart = event.getBreakStart();
        this.breakEnd = event.getBreakEnd();
        this.overTimeHours = event.getOverTimeHours();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateEntryCommand updateCandidateCommand) {
		EntryUpdatedEvent CandidateUpdatedEvent = new EntryUpdatedEvent();
		BeanUtils.copyProperties(updateCandidateCommand, CandidateUpdatedEvent);
		AggregateLifecycle.apply(CandidateUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(EntryUpdatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.clockIn = event.getClockIn();
        this.clockOut = event.getClockOut();
        this.breakStart = event.getBreakStart();
        this.breakEnd = event.getBreakEnd();
        this.overTimeHours = event.getOverTimeHours();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteEntryCommand deleteCandidateCommand) {
		EntryDeletedEvent CandidateDeletedEvent = new EntryDeletedEvent();
		BeanUtils.copyProperties(deleteCandidateCommand, CandidateDeletedEvent);
		AggregateLifecycle.apply(CandidateDeletedEvent);
	}

	@EventSourcingHandler
	public void on(EntryDeletedEvent event) {
		this.id = event.getId();
	}
}
