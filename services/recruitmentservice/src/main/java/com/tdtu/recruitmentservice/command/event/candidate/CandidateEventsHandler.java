package com.tdtu.recruitmentservice.command.event.candidate;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.recruitmentservice.command.data.candidate.Candidate;
import com.tdtu.recruitmentservice.command.data.candidate.CandidateService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CandidateEventsHandler {
	@Autowired
	private CandidateService candidateService;

	@EventHandler
	public void on(CandidateCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling CandidateCreatedEvent for: " + event.getId());
		Candidate candidate = new Candidate();
		BeanUtils.copyProperties(event, candidate);
		candidateService.save(candidate);
		log.info("Candidate created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(CandidateUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling CandidateUpdatedEvent for: " + event.getId());
		Optional<Candidate> CandidateOptional = Optional.ofNullable(candidateService.findById(event.getId()));
		if (CandidateOptional.isPresent()) {
			Candidate candidate = CandidateOptional.get();
			BeanUtils.copyProperties(event, candidate);
			candidateService.update(candidate);
			log.info("Candidate updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("Candidate not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(CandidateDeletedEvent event) {
		log.info("Handling CandidateDeletedEvent for: " + event.getId());
		candidateService.deleteById(event.getId());
		log.info("Candidate deleted from Firestore: " + event.getId());
	}
}
