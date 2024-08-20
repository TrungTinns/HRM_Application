package com.tdtu.recruitmentservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.recruitmentservice.command.command.candidate.CreateCandidateCommand;
import com.tdtu.recruitmentservice.command.command.candidate.DeleteCandidateCommand;
import com.tdtu.recruitmentservice.command.command.candidate.UpdateCandidateCommand;
import com.tdtu.recruitmentservice.command.event.candidate.CandidateCreatedEvent;
import com.tdtu.recruitmentservice.command.event.candidate.CandidateDeletedEvent;
import com.tdtu.recruitmentservice.command.event.candidate.CandidateUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class CandidateAggregate {
	@AggregateIdentifier
	private String id;
	private String name;
	private String subject;
	private String mail;
	private String phone;
	private String mobile;
	private String profileAddress;
	private String degree;
	private String interviewerId;
	private String recruiterId;
	private String appliedJob;
	private String department;
	private String source;
	private String medium;
	private Date availability;
	private int evaluation;
	private Double expectedSalary;
	private Double proposedSalary;
	private String applicationSummary;
	private String jobPositionId;
	private int stage;
	private boolean isHired;
	private boolean isOffered;
	
	// CREATE EVENT
	@CommandHandler
	public CandidateAggregate(CreateCandidateCommand createCandidateCommand) {
		CandidateCreatedEvent CandidateCreatedEvent = new CandidateCreatedEvent();
		BeanUtils.copyProperties(createCandidateCommand, CandidateCreatedEvent);
		AggregateLifecycle.apply(CandidateCreatedEvent);
	}

	@EventSourcingHandler
	public void on(CandidateCreatedEvent event) {
		this.id = event.getId();
        this.name = event.getName();
        this.subject = event.getSubject();
        this.mail = event.getMail();
        this.phone = event.getPhone();
        this.mobile = event.getMobile();
        this.profileAddress = event.getProfileAddress();
        this.degree = event.getDegree();
        this.interviewerId = event.getInterviewerId();
        this.recruiterId = event.getRecruiterId();
        this.appliedJob = event.getAppliedJob();
        this.department = event.getDepartment();
        this.source = event.getSource();
        this.medium = event.getMedium();
        this.availability = event.getAvailability();
        this.evaluation = event.getEvaluation();
        this.expectedSalary = event.getExpectedSalary();
        this.proposedSalary = event.getProposedSalary();
        this.applicationSummary = event.getApplicationSummary();
        this.jobPositionId = event.getJobPositionId();
        this.stage = event.getStage();
        this.isHired = event.getIsHired();
        this.isOffered = event.getIsOffered();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateCandidateCommand updateCandidateCommand) {
		CandidateUpdatedEvent CandidateUpdatedEvent = new CandidateUpdatedEvent();
		BeanUtils.copyProperties(updateCandidateCommand, CandidateUpdatedEvent);
		AggregateLifecycle.apply(CandidateUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(CandidateUpdatedEvent event) {
		this.id = event.getId();
        this.name = event.getName();
        this.subject = event.getSubject();
        this.mail = event.getMail();
        this.phone = event.getPhone();
        this.mobile = event.getMobile();
        this.profileAddress = event.getProfileAddress();
        this.degree = event.getDegree();
        this.interviewerId = event.getInterviewerId();
        this.recruiterId = event.getRecruiterId();
        this.appliedJob = event.getAppliedJob();
        this.department = event.getDepartment();
        this.source = event.getSource();
        this.medium = event.getMedium();
        this.availability = event.getAvailability();
        this.evaluation = event.getEvaluation();
        this.expectedSalary = event.getExpectedSalary();
        this.proposedSalary = event.getProposedSalary();
        this.applicationSummary = event.getApplicationSummary();
        this.jobPositionId = event.getJobPositionId();
        this.stage = event.getStage();
        this.isHired = event.getIsHired();	
        this.isOffered = event.getIsOffered();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteCandidateCommand deleteCandidateCommand) {
		CandidateDeletedEvent CandidateDeletedEvent = new CandidateDeletedEvent();
		BeanUtils.copyProperties(deleteCandidateCommand, CandidateDeletedEvent);
		AggregateLifecycle.apply(CandidateDeletedEvent);
	}

	@EventSourcingHandler
	public void on(CandidateDeletedEvent event) {
		this.id = event.getId();
	}
}
