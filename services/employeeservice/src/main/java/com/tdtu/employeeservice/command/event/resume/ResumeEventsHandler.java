package com.tdtu.employeeservice.command.event.resume;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.resume.Resume;
import com.tdtu.employeeservice.command.data.resume.ResumeService;
import com.tdtu.employeeservice.command.event.skill.SkillEventsHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ResumeEventsHandler {
	@Autowired
	private ResumeService resumeService;

	@EventHandler
	public void on(ResumeCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ResumeCreatedEvent for: " + event.getId());
		Resume emp = new Resume();
		BeanUtils.copyProperties(event, emp);
		resumeService.save(emp);
		log.info("Resume created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(ResumeUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ResumeUpdatedEvent for: " + event.getId());
		Optional<Resume> resumeOptional = Optional.ofNullable(resumeService.findById(event.getId()));
		if (resumeOptional.isPresent()) {
			Resume resume = resumeOptional.get();
			BeanUtils.copyProperties(event, resume);
			resumeService.save(resume);
			log.info("Resume updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("Resume not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(ResumeDeletedEvent event) {
		log.info("Handling ResumeDeletedEvent for: " + event.getId());
		resumeService.deleteById(event.getId());
		log.info("Resume deleted from Firestore: " + event.getId());
	}
}
