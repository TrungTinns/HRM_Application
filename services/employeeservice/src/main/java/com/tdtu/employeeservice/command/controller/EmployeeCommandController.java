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
import com.tdtu.employeeservice.command.command.employee.CreateEmployeeCommand;
import com.tdtu.employeeservice.command.command.employee.DeleteEmployeeCommand;
import com.tdtu.employeeservice.command.command.employee.UpdateEmployeeCommand;
import com.tdtu.employeeservice.command.data.employee.Employee;
import com.tdtu.employeeservice.command.data.employee.EmployeeService;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;
import com.tdtu.employeeservice.command.model.LevelRequestModel;
import com.tdtu.employeeservice.command.model.ResumeRequestModel;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/employee")
public class EmployeeCommandController {

	@Autowired
	private CommandGateway commandGateway;
	
	@Autowired
    private ResumeCommandController resumeCommandController;
    
    @Autowired
    private EmployeeService empService;
    
    private static final String REFERENCE_COLLECTION = "Resume";

    @PostMapping
    public String addEmployee(@RequestBody EmployeeRequestModel model) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ResumeRequestModel resumeModel = new ResumeRequestModel();
        resumeModel.setExperience(model.getResume().getExperience());
        resumeModel.setSkillTypes(model.getResume().getSkillTypes());
        try {
            CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
                try {
                    return resumeCommandController.addResume(resumeModel);
                } catch (InterruptedException | ExecutionException e) {
                    e.printStackTrace();
                    throw new RuntimeException(e);
                }
            });
            String resumeId = future.get();
            DocumentReference resumeRef = db.collection(REFERENCE_COLLECTION).document(resumeId);     
            
            CreateEmployeeCommand command = new CreateEmployeeCommand(UUID.randomUUID().toString(), model.getFirstName(),
                    model.getLastName(), model.getEmail(), model.getDateOfBirth(), model.getPosition(), model.getSalary(),
                    model.getDepartment(), model.getPhone(), model.getImg(), model.getTags(), model.getCoachId(),
                    model.getManagerId(), resumeRef);
            commandGateway.sendAndWait(command);
            return "Added an Employee with ID: " + command.getId();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            return "Failed to add Employee: " + e.getMessage();
        }
    }


	@PutMapping
	public String updateEmployee(@RequestBody EmployeeRequestModel model) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
        
        Employee emp = empService.findById(model.getId());
        CompletableFuture<String> future = null;
        if (emp != null && emp.getResumeRef() != null) {
            String resumeId = emp.getResumeRef().getId();
            ResumeRequestModel resumeModel = new ResumeRequestModel();
            resumeModel.setId(resumeId);
    		resumeModel.setExperience(model.getResume().getExperience());
    		resumeModel.setSkillTypes(model.getResume().getSkillTypes());
            future = CompletableFuture.supplyAsync(() -> {
				try {
					return resumeCommandController.updateResume(resumeModel);
				} catch (InterruptedException e) {
					e.printStackTrace();
				} catch (ExecutionException e) {
					e.printStackTrace();
				}
				return resumeId;
			});
            future.get();
        }
		
		UpdateEmployeeCommand command = new UpdateEmployeeCommand(model.getId(), model.getFirstName(),
				model.getLastName(), model.getEmail(), model.getDateOfBirth(), model.getPosition(), model.getSalary(),
				model.getDepartment(), model.getPhone(), model.getImg(), model.getTags(), model.getCoachId(),
				model.getManagerId(), emp.getResumeRef());
		commandGateway.sendAndWait(command);
		return "Updated an Employee with ID: " + model.getId().toString();
	}

	@DeleteMapping("/{id}")
	public String deleteEmployee(@PathVariable String id) {
		commandGateway.sendAndWait(new DeleteEmployeeCommand(id));
		return "Deleted an Employee with ID: " + id;
	}
}
