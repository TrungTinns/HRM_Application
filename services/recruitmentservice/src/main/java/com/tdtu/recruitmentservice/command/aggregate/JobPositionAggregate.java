package com.tdtu.recruitmentservice.command.aggregate;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.recruitmentservice.command.command.jobPosition.CreateJobPositionCommand;
import com.tdtu.recruitmentservice.command.command.jobPosition.DeleteJobPositionCommand;
import com.tdtu.recruitmentservice.command.command.jobPosition.UpdateJobPositionCommand;
import com.tdtu.recruitmentservice.command.event.jobPosition.JobPositionCreatedEvent;
import com.tdtu.recruitmentservice.command.event.jobPosition.JobPositionDeletedEvent;
import com.tdtu.recruitmentservice.command.event.jobPosition.JobPositionUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class JobPositionAggregate {
	@AggregateIdentifier
	private String id;
	private String name;
	private String department;
	private String jobLocation;
	private String mailAlias;
	private String empType;
	private int target;
	private String recruiterId;
	private String interviewers;
	private String description;
	
	// CREATE EVENT
	@CommandHandler
	public JobPositionAggregate(CreateJobPositionCommand createJobPositionCommand) {
		JobPositionCreatedEvent JobPositionCreatedEvent = new JobPositionCreatedEvent();
		BeanUtils.copyProperties(createJobPositionCommand, JobPositionCreatedEvent);
		AggregateLifecycle.apply(JobPositionCreatedEvent);
	}

	@EventSourcingHandler
	public void on(JobPositionCreatedEvent event) {
		this.id = event.getId();
        this.name = event.getName();
        this.department = event.getDepartment();
        this.jobLocation = event.getJobLocation();
        this.mailAlias = event.getMailAlias();
        this.empType = event.getEmpType();
        this.target = event.getTarget();
        this.recruiterId = event.getRecruiterId();
        this.interviewers = event.getInterviewers();
        this.description = event.getDescription();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateJobPositionCommand updateJobPositionCommand) {
		JobPositionUpdatedEvent JobPositionUpdatedEvent = new JobPositionUpdatedEvent();
		BeanUtils.copyProperties(updateJobPositionCommand, JobPositionUpdatedEvent);
		AggregateLifecycle.apply(JobPositionUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(JobPositionUpdatedEvent event) {
		this.id = event.getId();
        this.name = event.getName();
        this.department = event.getDepartment();
        this.jobLocation = event.getJobLocation();
        this.mailAlias = event.getMailAlias();
        this.empType = event.getEmpType();
        this.target = event.getTarget();
        this.recruiterId = event.getRecruiterId();
        this.interviewers = event.getInterviewers();
        this.description = event.getDescription();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteJobPositionCommand deleteJobPositionCommand) {
		JobPositionDeletedEvent JobPositionDeletedEvent = new JobPositionDeletedEvent();
		BeanUtils.copyProperties(deleteJobPositionCommand, JobPositionDeletedEvent);
		AggregateLifecycle.apply(JobPositionDeletedEvent);
	}

	@EventSourcingHandler
	public void on(JobPositionDeletedEvent event) {
		this.id = event.getId();
	}
}
