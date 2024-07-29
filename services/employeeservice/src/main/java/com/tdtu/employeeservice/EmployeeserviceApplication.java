package com.tdtu.employeeservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.messaging.handler.annotation.Payload;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import com.tdtu.employeeservice.command.controller.EmployeeCommandController;
import com.tdtu.employeeservice.command.data.contract.Contract;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;
import com.tdtu.employeeservice.config.AxonConfig;
import com.tdtu.employeeservice.query.model.CandidateResponseModel;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@EnableDiscoveryClient
@EnableKafka
@Import({ AxonConfig.class })
@Slf4j
public class EmployeeserviceApplication {
    
    @Autowired
    private EmployeeCommandController employeeCommandController;
    
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

    public static void main(String[] args) {
        SpringApplication.run(EmployeeserviceApplication.class, args);
    }
}
