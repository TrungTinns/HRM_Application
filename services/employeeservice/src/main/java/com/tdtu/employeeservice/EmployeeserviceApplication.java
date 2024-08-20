package com.tdtu.employeeservice;

import org.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.messaging.handler.annotation.Payload;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import com.tdtu.employeeservice.command.controller.EmployeeCommandController;
import com.tdtu.employeeservice.command.data.contract.Contract;
import com.tdtu.employeeservice.command.data.employee.Employee;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;
import com.tdtu.employeeservice.config.AxonConfig;
import com.tdtu.employeeservice.query.controller.EmployeeQueryController;
import com.tdtu.employeeservice.query.model.CandidateResponseModel;
import com.tdtu.employeeservice.query.model.EmployeeResponseModel;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@EnableDiscoveryClient
@EnableKafka
@Import({ AxonConfig.class })
@Slf4j
public class EmployeeserviceApplication {
	
	@Autowired
    private KafkaTemplate<String, String> kafkaTemplate;
    
    @Autowired
    private EmployeeCommandController employeeCommandController;
    
    @Autowired
    private EmployeeQueryController employeeQueryController; 
    
    @Autowired
    private ObjectMapper objectMapper;

    @KafkaListener(topics = "recruitment", groupId = "employee-group")
    public void consume(@Payload String message, Acknowledgment acknowledgment) throws Exception {
    	try {
    		String jsonParser = JsonParser.parseString(message).getAsString();
    		Contract contractModel = new Contract();
            CandidateResponseModel canModel = objectMapper.readValue(jsonParser, CandidateResponseModel.class);
            EmployeeRequestModel empModel = new EmployeeRequestModel();
            empModel.setName(canModel.getName());
            empModel.setRole(canModel.getAppliedJob());
            empModel.setMail(canModel.getMail());
            empModel.setMobile(canModel.getMobile());
            empModel.setDepartment(canModel.getDepartment());
            empModel.setCertification(canModel.getDegree());
            empModel.setContract(contractModel);
            
            employeeCommandController.addEmployee(empModel);
            acknowledgment.acknowledge();
        } catch (JsonSyntaxException e) {
            log.error("Error parsing JSON message: " + e.getMessage(), e);
        } catch (Exception e) {
            log.error("Error processing message: " + e.getMessage(), e);
        }
    }
    
    @KafkaListener(topics = "employee-request", groupId = "employee-group")
    public void consumeEmployeeRequest(@Payload String message, Acknowledgment acknowledgment) throws Exception {
    	EmployeeResponseModel resp = employeeQueryController.getEmployeeDetail(message);
    	
    	JSONObject jsonObject = new JSONObject(resp);
    	String empJson = jsonObject.toString();
    	
    	log.info(empJson);
        kafkaTemplate.send("employee-response", empJson);
        acknowledgment.acknowledge();
    }

    public static void main(String[] args) {
        SpringApplication.run(EmployeeserviceApplication.class, args);
    }
}
