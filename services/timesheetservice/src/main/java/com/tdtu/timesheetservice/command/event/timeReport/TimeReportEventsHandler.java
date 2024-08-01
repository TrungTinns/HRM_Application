package com.tdtu.timesheetservice.command.event.timeReport;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.timeReport.TimeReport;
import com.tdtu.timesheetservice.command.data.timeReport.TimeReportService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class TimeReportEventsHandler {
	@Autowired
	private TimeReportService TimeReportService;

	@EventHandler
	public void on(TimeReportCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling TimeReportCreatedEvent for: " + event.getId());
		TimeReport TimeReport = new TimeReport();
		BeanUtils.copyProperties(event, TimeReport);
		TimeReportService.save(TimeReport);
		log.info("TimeReport created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(TimeReportUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling TimeReportUpdatedEvent for: " + event.getId());
		Optional<TimeReport> TimeReportOptional = Optional.ofNullable(TimeReportService.findById(event.getId()));
		if (TimeReportOptional.isPresent()) {
			TimeReport TimeReport = TimeReportOptional.get();
			BeanUtils.copyProperties(event, TimeReport);
			TimeReportService.update(TimeReport);
			log.info("TimeReport updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("TimeReport not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(TimeReportDeletedEvent event) {
		log.info("Handling TimeReportDeletedEvent for: " + event.getId());
		TimeReportService.deleteById(event.getId());
		log.info("TimeReport deleted from Firestore: " + event.getId());
	}
}
