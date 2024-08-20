package com.tdtu.timesheetservice.command.event.vilationRecord;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.violationRecord.ViolationRecord;
import com.tdtu.timesheetservice.command.data.violationRecord.ViolationRecordService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ViolationRecordEventsHandler {
	@Autowired
	private ViolationRecordService ViolationReportService;

	@EventHandler
	public void on(ViolationRecordCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ViolationRecordCreatedEvent for: " + event.getId());
		ViolationRecord ViolationReport = new ViolationRecord();
		BeanUtils.copyProperties(event, ViolationReport);
		ViolationReportService.save(ViolationReport);
		log.info("ViolationRecord created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(ViolationRecordUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ViolationRecordUpdatedEvent for: " + event.getId());
		Optional<ViolationRecord> ViolationReportOptional = Optional.ofNullable(ViolationReportService.findById(event.getId()));
		if (ViolationReportOptional.isPresent()) {
			ViolationRecord ViolationReport = ViolationReportOptional.get();
			BeanUtils.copyProperties(event, ViolationReport);
			ViolationReportService.update(ViolationReport);
			log.info("ViolationRecord updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("ViolationRecord not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(ViolationRecordDeletedEvent event) {
		log.info("Handling ViolationRecordDeletedEvent for: " + event.getId());
		ViolationReportService.deleteById(event.getId());
		log.info("ViolationRecord deleted from Firestore: " + event.getId());
	}
}
