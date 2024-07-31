package com.tdtu.timesheetservice.command.event.entrie;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.entrie.Entry;
import com.tdtu.timesheetservice.command.data.entrie.EntryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class EntryEventsHandler {
	@Autowired
	private EntryService EntryService;

	@EventHandler
	public void on(EntryCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling EntryCreatedEvent for: " + event.getId());
		Entry Entry = new Entry();
		BeanUtils.copyProperties(event, Entry);
		EntryService.save(Entry);
		log.info("Entry created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(EntryUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling EntryUpdatedEvent for: " + event.getId());
		Optional<Entry> EntryOptional = Optional.ofNullable(EntryService.findById(event.getId()));
		if (EntryOptional.isPresent()) {
			Entry Entry = EntryOptional.get();
			BeanUtils.copyProperties(event, Entry);
			EntryService.update(Entry);
			log.info("Entry updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("Entry not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(EntryDeletedEvent event) {
		log.info("Handling EntryDeletedEvent for: " + event.getId());
		EntryService.deleteById(event.getId());
		log.info("Entry deleted from Firestore: " + event.getId());
	}
}
