package com.tdtu.employeeservice.command.aggregate;

import java.util.List;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.employeeservice.command.command.skill.CreateSkillCommand;
import com.tdtu.employeeservice.command.command.skill.DeleteSkillCommand;
import com.tdtu.employeeservice.command.command.skill.UpdateSkillCommand;
import com.tdtu.employeeservice.command.event.skill.SkillCreatedEvent;
import com.tdtu.employeeservice.command.event.skill.SkillDeletedEvent;
import com.tdtu.employeeservice.command.event.skill.SkillUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class SkillAggregate {

    @AggregateIdentifier
    private String id;
    private String skillType;
    private List<String> name;
    private DocumentReference levels;

    // CREATE EVENT
    @CommandHandler
    public SkillAggregate(CreateSkillCommand createSkillCommand) {
        SkillCreatedEvent skillCreatedEvent = new SkillCreatedEvent();
        BeanUtils.copyProperties(createSkillCommand, skillCreatedEvent);
        AggregateLifecycle.apply(skillCreatedEvent);
    }

    @EventSourcingHandler
    public void on(SkillCreatedEvent event) {
        this.id = event.getId();
        this.skillType = event.getSkillType();
        this.name = event.getName();
        this.levels = event.getLevels();
    }

    // UPDATED EVENT
    @CommandHandler
    public void handle(UpdateSkillCommand updateSkillCommand) {
        SkillUpdatedEvent skillUpdatedEvent = new SkillUpdatedEvent();
        BeanUtils.copyProperties(updateSkillCommand, skillUpdatedEvent);
        AggregateLifecycle.apply(skillUpdatedEvent);
    }

    @EventSourcingHandler
    public void on(SkillUpdatedEvent event) {
        this.id = event.getId();
        this.skillType = event.getSkillType();
        this.name = event.getName();
        this.levels = event.getLevels();
    }

    // DELETE EVENT
    @CommandHandler
    public void handle(DeleteSkillCommand deleteSkillCommand) {
        SkillDeletedEvent skillDeletedEvent = new SkillDeletedEvent(deleteSkillCommand.getId());
        AggregateLifecycle.apply(skillDeletedEvent);
    }

    @EventSourcingHandler
    public void on(SkillDeletedEvent event) {
        this.id = event.getId();
        AggregateLifecycle.markDeleted();
    }
}
