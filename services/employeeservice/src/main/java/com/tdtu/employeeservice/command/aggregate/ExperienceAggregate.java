package com.tdtu.employeeservice.command.aggregate;

import java.util.List;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.employeeservice.command.command.experience.CreateExperienceCommand;
import com.tdtu.employeeservice.command.command.experience.DeleteExperienceCommand;
import com.tdtu.employeeservice.command.command.experience.UpdateExperienceCommand;
import com.tdtu.employeeservice.command.data.experience.DetailedExperience;
import com.tdtu.employeeservice.command.event.experience.ExperienceCreatedEvent;
import com.tdtu.employeeservice.command.event.experience.ExperienceDeletedEvent;
import com.tdtu.employeeservice.command.event.experience.ExperienceUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class ExperienceAggregate {
	
	@AggregateIdentifier
	private String id;
	private List<DetailedExperience> experiences;

	// CREATE EVENT
	@CommandHandler
	public ExperienceAggregate(CreateExperienceCommand createExperienceCommand) {
		ExperienceCreatedEvent experienceCreatedEvent = new ExperienceCreatedEvent();
		BeanUtils.copyProperties(createExperienceCommand, experienceCreatedEvent);
		AggregateLifecycle.apply(experienceCreatedEvent);
	}

	@EventSourcingHandler
	public void on(ExperienceCreatedEvent event) {
//		BeanUtils.copyProperties(this, event);
		this.id = event.getId();
        this.experiences = event.getExperiences();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateExperienceCommand updateExperienceCommand) {
		ExperienceUpdatedEvent experienceUpdatedEvent = new ExperienceUpdatedEvent();
		BeanUtils.copyProperties(updateExperienceCommand, experienceUpdatedEvent);
		AggregateLifecycle.apply(experienceUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(ExperienceUpdatedEvent event) {
		this.id = event.getId();
        this.experiences = event.getExperiences();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteExperienceCommand deleteExperienceCommand) {
		ExperienceDeletedEvent experienceDeletedEvent = new ExperienceDeletedEvent();
		BeanUtils.copyProperties(deleteExperienceCommand, experienceDeletedEvent);
		AggregateLifecycle.apply(experienceDeletedEvent);
	}

	@EventSourcingHandler
	public void on(ExperienceDeletedEvent event) {
		this.id = event.getId();
	}
}
