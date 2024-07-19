package com.tdtu.employeeservice.command.controller;

import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import com.tdtu.employeeservice.command.command.resume.CreateResumeCommand;
import com.tdtu.employeeservice.command.command.resume.DeleteResumeCommand;
import com.tdtu.employeeservice.command.command.resume.UpdateResumeCommand;
import com.tdtu.employeeservice.command.data.resume.Resume;
import com.tdtu.employeeservice.command.data.resume.ResumeService;
import com.tdtu.employeeservice.command.model.ExperienceRequestModel;
import com.tdtu.employeeservice.command.model.LevelRequestModel;
import com.tdtu.employeeservice.command.model.ResumeRequestModel;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/resume")
public class ResumeCommandController {

	@Autowired
	private CommandGateway commandGateway;
	
	@Autowired
    private ExperienceCommandController experienceCommandController;
    
    @Autowired
    private ResumeService resumeService;
    
    private static final String REFERENCE_COLLECTION = "Experience";

	@PostMapping
	public String addResume(@RequestBody ResumeRequestModel model) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		
		ExperienceRequestModel experienceModel = new ExperienceRequestModel();
        experienceModel.setExperiences(model.getExperience().getExperiences());

        CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> experienceCommandController.addExperience(experienceModel));
        String experienceId = future.get();
        DocumentReference experienceRef = db.collection(REFERENCE_COLLECTION).document(experienceId);     
        
        log.info(experienceRef.toString());
		CreateResumeCommand command = new CreateResumeCommand(
				UUID.randomUUID().toString(),
				experienceRef,
				model.getSkillTypes()
		);
		commandGateway.sendAndWait(command);
		return command.getId();
	}

	@PutMapping
	public String updateResume(@RequestBody ResumeRequestModel model) throws InterruptedException, ExecutionException {
		Resume resume = resumeService.findById(model.getId());
        CompletableFuture<String> future = null;
        if (resume != null && resume.getExperienceRef() != null) {
            String experienceId = resume.getExperienceRef().getId();
            ExperienceRequestModel experienceModel = new ExperienceRequestModel();
            experienceModel.setId(experienceId);
            experienceModel.setExperiences(model.getExperience().getExperiences());

            future = CompletableFuture.supplyAsync(() -> experienceCommandController.updateExperience(experienceModel));
            future.get();
        }
        
		UpdateResumeCommand command = new UpdateResumeCommand(
				model.getId(), 
				resume.getExperienceRef(),
				model.getSkillTypes()
		);
		commandGateway.sendAndWait(command);
		return model.getId();
	}

	@DeleteMapping("/{id}")
	public String deleteResume(@PathVariable String id) {
		commandGateway.sendAndWait(new DeleteResumeCommand(id));
		return id;
	}
}
