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
import com.tdtu.employeeservice.command.model.ContractRequestModel;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;

@RestController
@RequestMapping("/api/v1/employee")
public class EmployeeCommandController {

	@Autowired
	private CommandGateway commandGateway;
	
    @Autowired
    private EmployeeService empService;
    
    @Autowired
    private ContractCommandController contractCommandController;
    
    private static final String REFERENCE_COLLECTION = "Contracts";

    @PostMapping
    public String addEmployee(@RequestBody EmployeeRequestModel model) throws InterruptedException, ExecutionException {
    	 Firestore db = FirestoreClient.getFirestore();
         ContractRequestModel contractModel = new ContractRequestModel();
         contractModel.setSchedule(model.getContract().getSchedule());
         contractModel.setSalaryStructure(model.getContract().getSalaryStructure());
         contractModel.setContractType(model.getContract().getContractType());
         contractModel.setCost(model.getContract().getCost());
         contractModel.setStartDate(model.getContract().getStartDate());
         contractModel.setEndDate(model.getContract().getEndDate());
         CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> contractCommandController.addContract(contractModel));
         String contractId = future.get();
         DocumentReference contractRef = db.collection(REFERENCE_COLLECTION).document(contractId);
         
    	CreateEmployeeCommand command = new CreateEmployeeCommand(UUID.randomUUID().toString(), model.getName(),
                model.getRole(), model.getMail(), model.getMobile(), model.getDepartment(), model.getManagerId(),
                model.isManager(), model.getWorkLocation(), model.getPersonalAddress(), model.getPersonalMail(), model.getPersonalMobile(), 
                model.getRelativeName(), model.getRelativeMobile(), model.getCertification(), model.getSchool(), model.getMaritalStatus(), model.getChild(), 
                model.getNationality(), model.getIdNum(), model.getSsNum(), model.getPassport(), model.getSex(), model.getBirthDate(), model.getBirthPlace(), contractRef
        );
        commandGateway.sendAndWait(command);
        return "Added an Employee with ID: " + command.getId();
    }


	@PutMapping
	public String updateEmployee(@RequestBody EmployeeRequestModel model) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		Employee employee = empService.findById(model.getId());
        CompletableFuture<String> future = null;
        
        if (employee != null && employee.getContractRef() != null) {
            String contractId = employee.getContractRef().getId();
            ContractRequestModel contractModel = new ContractRequestModel();
            contractModel.setSchedule(model.getContract().getSchedule());
            contractModel.setSalaryStructure(model.getContract().getSalaryStructure());
            contractModel.setContractType(model.getContract().getContractType());
            contractModel.setCost(model.getContract().getCost());
            contractModel.setStartDate(model.getContract().getStartDate());
            contractModel.setEndDate(model.getContract().getEndDate());
            future = CompletableFuture.supplyAsync(() -> contractCommandController.updateContract(contractModel));
            future.get();
        }
        
		UpdateEmployeeCommand command = new UpdateEmployeeCommand(model.getId(), model.getName(),
				model.getRole(), model.getMail(), model.getMobile(), model.getDepartment(), model.getManagerId(),
	            model.isManager(), model.getWorkLocation(), model.getPersonalAddress(), model.getPersonalMail(), model.getPersonalMobile(), 
	            model.getRelativeName(), model.getRelativeMobile(), model.getCertification(), model.getSchool(), model.getMaritalStatus(), model.getChild(), 
	            model.getNationality(), model.getIdNum(), model.getSsNum(), model.getPassport(), model.getSex(), model.getBirthDate(), model.getBirthPlace(), employee.getContractRef()
	    );
		commandGateway.sendAndWait(command);
		return "Updated an Employee with ID: " + model.getId().toString();
	}

	@DeleteMapping("/{id}")
	public String deleteEmployee(@PathVariable String id) throws InterruptedException, ExecutionException {
		Employee employee = empService.findById(id);
		if (employee != null && employee.getContractRef() != null) {
            String contractId = employee.getContractRef().getId();
            CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> contractCommandController.deleteContract(contractId));
            future.get();
        }
		commandGateway.sendAndWait(new DeleteEmployeeCommand(id));
		return "Deleted an Employee with ID: " + id;
	}
}
