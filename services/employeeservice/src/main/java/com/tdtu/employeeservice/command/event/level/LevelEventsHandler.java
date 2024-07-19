package com.tdtu.employeeservice.command.event.level;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.level.Level;
import com.tdtu.employeeservice.command.data.level.LevelService;
import com.tdtu.employeeservice.command.event.experience.ExperienceEventsHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LevelEventsHandler {
	
	@Autowired
	private LevelService levelService;

	@EventHandler
	public void on(LevelCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling LevelCreatedEvent for: " + event.getId());
		Level level = new Level();
		BeanUtils.copyProperties(event, level);
		levelService.save(level);
		log.info("Level created and saved to Firestore: " + level.getId());
	}

	@EventHandler
	public void on(LevelUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling LevelUpdatedEvent for: " + event.getId());
		Optional<Level> LevelOptional = Optional.ofNullable(levelService.findById(event.getId()));
		if (LevelOptional.isPresent()) {
			Level level = LevelOptional.get();
			BeanUtils.copyProperties(event, level);
			levelService.update(level);
			log.info("Level updated and saved to Firestore: " + level.getId());
		} 
		else {
			 throw new IllegalArgumentException("Level not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(LevelDeletedEvent event) {
		log.info("Handling LevelDeletedEvent for: " + event.getId());
        levelService.deleteById(event.getId());
        log.info("Level deleted from Firestore: " + event.getId());

	}
}
