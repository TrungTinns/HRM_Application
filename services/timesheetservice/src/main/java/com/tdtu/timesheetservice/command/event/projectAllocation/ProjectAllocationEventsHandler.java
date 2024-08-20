package com.tdtu.timesheetservice.command.event.projectAllocation;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.projectAllocation.ProjectAllocation;
import com.tdtu.timesheetservice.command.data.projectAllocation.ProjectAllocationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ProjectAllocationEventsHandler {
	@Autowired
	private ProjectAllocationService ProjectAllocationService;

	@EventHandler
	public void on(ProjectAllocationCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ProjectAllocationCreatedEvent for: " + event.getId());
		ProjectAllocation ProjectAllocation = new ProjectAllocation();
		BeanUtils.copyProperties(event, ProjectAllocation);
		ProjectAllocationService.save(ProjectAllocation);
		log.info("ProjectAllocation created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(ProjectAllocationUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ProjectAllocationUpdatedEvent for: " + event.getId());
		Optional<ProjectAllocation> ProjectAllocationOptional = Optional.ofNullable(ProjectAllocationService.findById(event.getId()));
		if (ProjectAllocationOptional.isPresent()) {
			ProjectAllocation ProjectAllocation = ProjectAllocationOptional.get();
			BeanUtils.copyProperties(event, ProjectAllocation);
			ProjectAllocationService.update(ProjectAllocation);
			log.info("ProjectAllocation updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("ProjectAllocation not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(ProjectAllocationDeletedEvent event) {
		log.info("Handling ProjectAllocationDeletedEvent for: " + event.getId());
		ProjectAllocationService.deleteById(event.getId());
		log.info("ProjectAllocation deleted from Firestore: " + event.getId());
	}
}
