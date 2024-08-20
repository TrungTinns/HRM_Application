package com.tdtu.timesheetservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.timesheetservice.command.command.timeReport.CreateTimeReportCommand;
import com.tdtu.timesheetservice.command.command.timeReport.DeleteTimeReportCommand;
import com.tdtu.timesheetservice.command.command.timeReport.UpdateTimeReportCommand;
import com.tdtu.timesheetservice.command.event.timeReport.TimeReportCreatedEvent;
import com.tdtu.timesheetservice.command.event.timeReport.TimeReportDeletedEvent;
import com.tdtu.timesheetservice.command.event.timeReport.TimeReportUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class TimeReportAggregate {
	@AggregateIdentifier
	private String id;
	private String empId;
	private String reportType;
	private Date startDate;
	private Date endDate;
	private Double totalHours;
	private Double overTimeHours;
	private int leaveDays;

	
	// CREATE EVENT
	@CommandHandler
	public TimeReportAggregate(CreateTimeReportCommand createTimeReportCommand) {
		TimeReportCreatedEvent TimeReportCreatedEvent = new TimeReportCreatedEvent();
		BeanUtils.copyProperties(createTimeReportCommand, TimeReportCreatedEvent);
		AggregateLifecycle.apply(TimeReportCreatedEvent);
	}

	@EventSourcingHandler
	public void on(TimeReportCreatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.reportType = event.getReportType();
        this.totalHours = event.getTotalHours();
        this.startDate = event.getStartDate();
        this.endDate = event.getEndDate();
        this.overTimeHours = event.getOverTimeHours();
        this.leaveDays = event.getLeaveDays();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateTimeReportCommand updateTimeReportCommand) {
		TimeReportUpdatedEvent TimeReportUpdatedEvent = new TimeReportUpdatedEvent();
		BeanUtils.copyProperties(updateTimeReportCommand, TimeReportUpdatedEvent);
		AggregateLifecycle.apply(TimeReportUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(TimeReportUpdatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.reportType = event.getReportType();
        this.totalHours = event.getTotalHours();
        this.startDate = event.getStartDate();
        this.endDate = event.getEndDate();
        this.overTimeHours = event.getOverTimeHours();
        this.leaveDays = event.getLeaveDays();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteTimeReportCommand deleteTimeReportCommand) {
		TimeReportDeletedEvent TimeReportDeletedEvent = new TimeReportDeletedEvent();
		BeanUtils.copyProperties(deleteTimeReportCommand, TimeReportDeletedEvent);
		AggregateLifecycle.apply(TimeReportDeletedEvent);
	}

	@EventSourcingHandler
	public void on(TimeReportDeletedEvent event) {
		this.id = event.getId();
	}
}
