package com.tdtu.timesheetservice.command.event.timeOffRequest;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.timeOffRequest.TimeOffRequest;
import com.tdtu.timesheetservice.command.data.timeOffRequest.TimeOffRequestService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class TimeOffRequestEventsHandler {
	@Autowired
	private TimeOffRequestService TimeOffRequestService;

	@EventHandler
	public void on(TimeOffRequestCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling TimeOffRequestCreatedEvent for: " + event.getId());
		TimeOffRequest TimeOffRequest = new TimeOffRequest();
		BeanUtils.copyProperties(event, TimeOffRequest);
		TimeOffRequestService.save(TimeOffRequest);
		log.info("TimeOffRequest created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(TimeOffRequestUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling TimeOffRequestUpdatedEvent for: " + event.getId());
		Optional<TimeOffRequest> TimeOffRequestOptional = Optional.ofNullable(TimeOffRequestService.findById(event.getId()));
		if (TimeOffRequestOptional.isPresent()) {
			TimeOffRequest TimeOffRequest = TimeOffRequestOptional.get();
			BeanUtils.copyProperties(event, TimeOffRequest);
			TimeOffRequestService.update(TimeOffRequest);
			log.info("TimeOffRequest updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("TimeOffRequest not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(TimeOffRequestDeletedEvent event) {
		log.info("Handling TimeOffRequestDeletedEvent for: " + event.getId());
		TimeOffRequestService.deleteById(event.getId());
		log.info("TimeOffRequest deleted from Firestore: " + event.getId());
	}
}
