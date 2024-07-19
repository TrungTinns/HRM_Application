package com.tdtu.employeeservice.command.aggregate;

import java.util.List;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.employeeservice.command.command.resume.CreateResumeCommand;
import com.tdtu.employeeservice.command.command.resume.DeleteResumeCommand;
import com.tdtu.employeeservice.command.command.resume.UpdateResumeCommand;
import com.tdtu.employeeservice.command.data.resume.SkillType;
import com.tdtu.employeeservice.command.event.resume.ResumeCreatedEvent;
import com.tdtu.employeeservice.command.event.resume.ResumeDeletedEvent;
import com.tdtu.employeeservice.command.event.resume.ResumeUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class ResumeAggregate {

	@AggregateIdentifier
	private String id;
	
	private DocumentReference experience;
	private List<SkillType> skillTypes;

	// CREATE EVENT
	@CommandHandler
	public ResumeAggregate(CreateResumeCommand createResumeCommand) {
		ResumeCreatedEvent resumeCreatedEvent = new ResumeCreatedEvent();
		BeanUtils.copyProperties(createResumeCommand, resumeCreatedEvent);
		AggregateLifecycle.apply(resumeCreatedEvent);
	}

	@EventSourcingHandler
	public void on(ResumeCreatedEvent event) {
		this.id = event.getId();
		this.experience = event.getExperience();
		this.skillTypes = event.getSkillTypes();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateResumeCommand updateResumeCommand) {
		ResumeUpdatedEvent resumeUpdatedEvent = new ResumeUpdatedEvent();
		BeanUtils.copyProperties(updateResumeCommand, resumeUpdatedEvent);
		AggregateLifecycle.apply(resumeUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(ResumeUpdatedEvent event) {
		this.id = event.getId();
		this.experience = event.getExperience();
		this.skillTypes = event.getSkillTypes();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteResumeCommand deletResumeCommand) {
		ResumeDeletedEvent resumeDeletedEvent = new ResumeDeletedEvent();
		BeanUtils.copyProperties(deletResumeCommand, resumeDeletedEvent);
		AggregateLifecycle.apply(resumeDeletedEvent);
	}

	@EventSourcingHandler
	public void on(ResumeDeletedEvent event) {
		this.id = event.getId();
	}
}
