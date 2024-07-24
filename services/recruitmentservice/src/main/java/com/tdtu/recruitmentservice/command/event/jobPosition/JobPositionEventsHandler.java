package com.tdtu.recruitmentservice.command.event.jobPosition;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.recruitmentservice.command.data.jobPosition.JobPosition;
import com.tdtu.recruitmentservice.command.data.jobPosition.JobPositionService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class JobPositionEventsHandler {
	@Autowired
	private JobPositionService jobPositionService;

	@EventHandler
	public void on(JobPositionCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling JobPositionCreatedEvent for: " + event.getId());
		JobPosition JobPosition = new JobPosition();
		BeanUtils.copyProperties(event, JobPosition);
		jobPositionService.save(JobPosition);
		log.info("JobPosition created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(JobPositionUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling JobPositionUpdatedEvent for: " + event.getId());
		Optional<JobPosition> empOptional = Optional.ofNullable(jobPositionService.findById(event.getId()));
		if (empOptional.isPresent()) {
			JobPosition emp = empOptional.get();
			BeanUtils.copyProperties(event, emp);
			jobPositionService.update(emp);
			log.info("JobPosition updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("JobPosition not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(JobPositionDeletedEvent event) {
		log.info("Handling JobPositionDeletedEvent for: " + event.getId());
		jobPositionService.deleteById(event.getId());
		log.info("JobPosition deleted from Firestore: " + event.getId());
	}
}
