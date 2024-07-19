package com.tdtu.employeeservice.command.event.experience;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.experience.Experience;
import com.tdtu.employeeservice.command.data.experience.ExperienceService;
import com.tdtu.employeeservice.command.event.skill.SkillEventsHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ExperienceEventsHandler {

	@Autowired
	private ExperienceService exprienceService;

	@EventHandler
	public void on(ExperienceCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ExperienceCreatedEvent for: " + event.getId());
		Experience exprience = new Experience();
		BeanUtils.copyProperties(event, exprience);
		exprienceService.save(exprience);
		log.info("Experience created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(ExperienceUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ExperienceUpdatedEvent for: " + event.getId());
		Optional<Experience> exprienceOptional = Optional.ofNullable(exprienceService.findById(event.getId()));
		if (exprienceOptional.isPresent()) {
			Experience exprience = exprienceOptional.get();
			BeanUtils.copyProperties(event, exprience);
			exprienceService.save(exprience);
			log.info("Experience created and saved to Firestore: " + event.getId());
		} else {
			 throw new IllegalArgumentException("Experience not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(ExperienceDeletedEvent event) {
		log.info("Handling ExperienceDeletedEvent for: " + event.getId());
		exprienceService.deleteById(event.getId());
		log.info("Experience deleted from Firestore: " + event.getId());
	}
}
