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
import com.tdtu.employeeservice.command.command.skill.CreateSkillCommand;
import com.tdtu.employeeservice.command.command.skill.DeleteSkillCommand;
import com.tdtu.employeeservice.command.command.skill.UpdateSkillCommand;
import com.tdtu.employeeservice.command.data.skill.Skill;
import com.tdtu.employeeservice.command.data.skill.SkillService;
import com.tdtu.employeeservice.command.model.LevelRequestModel;
import com.tdtu.employeeservice.command.model.SkillRequestModel;

@RestController
@RequestMapping("/api/v1/skill")
public class SkillCommandController {
    @Autowired
    private CommandGateway commandGateway;
    
    @Autowired
    private LevelCommandController levelCommandController;
    
    @Autowired
    private SkillService skillService;
    
    private static final String REFERENCE_COLLECTION = "Levels";

    @PostMapping
    public String addSkill(@RequestBody SkillRequestModel model) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        LevelRequestModel levelModel = new LevelRequestModel();
        levelModel.setSkillType(model.getSkillType());
        levelModel.setLevels(model.getLevels());
        CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> levelCommandController.addLevel(levelModel));
        String levelId = future.get();
        DocumentReference levelRef = db.collection(REFERENCE_COLLECTION).document(levelId);     

        CreateSkillCommand command = new CreateSkillCommand(
                UUID.randomUUID().toString(),
                model.getSkillType(),
                model.getName(),
                levelRef);
        
        commandGateway.sendAndWait(command);
        return command.getId();
    }

    @PutMapping
    public String updateSkill(@RequestBody SkillRequestModel model) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        
        Skill skill = skillService.findById(model.getId());
        CompletableFuture<String> future = null;
        if (skill != null && skill.getLevelsRef() != null) {
            String levelId = skill.getLevelsRef().getId();
            LevelRequestModel levelModel = new LevelRequestModel();
            levelModel.setId(levelId);
            levelModel.setSkillType(model.getSkillType());
            levelModel.setLevels(model.getLevels());
            future = CompletableFuture.supplyAsync(() -> levelCommandController.updateLevel(levelModel));
            future.get();
        }
 
        UpdateSkillCommand command = new UpdateSkillCommand(
                model.getId(),
                model.getSkillType(),
                model.getName(),
                skill.getLevelsRef()
        );
        commandGateway.sendAndWait(command);
        return model.getId();
    }
    
    @DeleteMapping("/{id}")
    public String deleteSkill(@PathVariable String id) throws InterruptedException, ExecutionException {
    	Skill skill = skillService.findById(id);
        if (skill != null && skill.getLevelsRef() != null) {
            String levelId = skill.getLevelsRef().getId();
            CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> levelCommandController.deleteLevel(levelId));
            future.get();  // Wait for the deletion to complete
        }
        
        commandGateway.sendAndWait(new DeleteSkillCommand(id));
        return id;
    }
}
