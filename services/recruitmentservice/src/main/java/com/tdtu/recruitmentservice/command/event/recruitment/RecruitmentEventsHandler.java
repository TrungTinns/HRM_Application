package com.tdtu.recruitmentservice.command.event.recruitment;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.recruitmentservice.command.data.recruitment.Recruitment;
import com.tdtu.recruitmentservice.command.data.recruitment.RecruitmentService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class RecruitmentEventsHandler {
	@Autowired
	private RecruitmentService RecruitmentService;

	@EventHandler
	public void on(RecruitmentCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling RecruitmentCreatedEvent for: " + event.getId());
		Recruitment Recruitment = new Recruitment();
		BeanUtils.copyProperties(event, Recruitment);
		RecruitmentService.save(Recruitment);
		log.info("Recruitment created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(RecruitmentUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling RecruitmentUpdatedEvent for: " + event.getId());
		Optional<Recruitment> recruitmentOptional = Optional.ofNullable(RecruitmentService.findById(event.getId()));
		if (recruitmentOptional.isPresent()) {
			Recruitment recruitment = recruitmentOptional.get();
			BeanUtils.copyProperties(event,recruitment);
			RecruitmentService.update(recruitment);
			log.info("Recruitment and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("Recruitment not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(RecruitmentDeletedEvent event) {
		log.info("Handling RecruitmentDeletedEvent for: " + event.getId());
		RecruitmentService.deleteById(event.getId());
		log.info("Recruitment deleted from Firestore: " + event.getId());
	}
}
