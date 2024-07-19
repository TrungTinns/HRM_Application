package com.tdtu.employeeservice.command.aggregate;

import java.util.List;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.employeeservice.command.command.level.CreateLevelCommand;
import com.tdtu.employeeservice.command.command.level.DeleteLevelCommand;
import com.tdtu.employeeservice.command.command.level.UpdateLevelCommand;
import com.tdtu.employeeservice.command.data.level.LevelDetailed;
import com.tdtu.employeeservice.command.event.level.LevelCreatedEvent;
import com.tdtu.employeeservice.command.event.level.LevelDeletedEvent;
import com.tdtu.employeeservice.command.event.level.LevelUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class LevelAggregate {

	@AggregateIdentifier
	private String id;
	private String skillType;
	private List<LevelDetailed> levels;

	// CREATE EVENT
	@CommandHandler
	public LevelAggregate(CreateLevelCommand createLevelCommand) {
		LevelCreatedEvent levelCreatedEvent = new LevelCreatedEvent();
		BeanUtils.copyProperties(createLevelCommand, levelCreatedEvent);
		AggregateLifecycle.apply(levelCreatedEvent);
	}

	@EventSourcingHandler
	public void on(LevelCreatedEvent event) {
		this.id = event.getId();
		this.skillType = event.getSkillType();
		this.levels = event.getLevels();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateLevelCommand updateLevelCommand) {
		LevelUpdatedEvent LevelUpdatedEvent = new LevelUpdatedEvent();
		BeanUtils.copyProperties(updateLevelCommand, LevelUpdatedEvent);
		AggregateLifecycle.apply(LevelUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(LevelUpdatedEvent event) {
		this.id = event.getId();
		this.skillType = event.getSkillType();
		this.levels = event.getLevels();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteLevelCommand deletLevelCommand) {
		LevelDeletedEvent LevelDeletedEvent = new LevelDeletedEvent();
		BeanUtils.copyProperties(deletLevelCommand, LevelDeletedEvent);
		AggregateLifecycle.apply(LevelDeletedEvent);
	}

	@EventSourcingHandler
	public void on(LevelDeletedEvent event) {
		this.id = event.getId();
	}
}
