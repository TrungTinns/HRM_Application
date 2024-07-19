package com.tdtu.employeeservice.command.event.skill;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.skill.Skill;
import com.tdtu.employeeservice.command.data.skill.SkillService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SkillEventsHandler {
    @Autowired
    private SkillService skillService;

    @EventHandler
    public void on(SkillCreatedEvent event) throws InterruptedException, ExecutionException {
        log.info("Handling SkillCreatedEvent for: " + event.getId());
        Skill skill = new Skill();
        BeanUtils.copyProperties(event, skill);
        skillService.save(skill);
        log.info("Skill created and saved to Firestore: " + event.getId());
    }

    @EventHandler
    public void on(SkillUpdatedEvent event) throws InterruptedException, ExecutionException {
        log.info("Handling SkillUpdatedEvent for: " + event.getId());
        Optional<Skill> skillOptional = Optional.ofNullable(skillService.findById(event.getId()));
        if (skillOptional.isPresent()) {
            Skill skill = skillOptional.get();
            BeanUtils.copyProperties(event, skill);
            skillService.update(skill);
            log.info("Skill updated and saved to Firestore: " + event.getId());
        } else {
            throw new IllegalArgumentException("Skill not found for update: " + event.getId());
        }
    }

    @EventHandler
    public void on(SkillDeletedEvent event) throws InterruptedException, ExecutionException {
        log.info("Handling SkillDeletedEvent for: " + event.getId());
        skillService.deleteById(event.getId());
        log.info("Skill deleted from Firestore: " + event.getId());
    }
}
