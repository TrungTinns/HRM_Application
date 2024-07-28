package com.tdtu.employeeservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.messaging.handler.annotation.Payload;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.tdtu.employeeservice.command.controller.EmployeeCommandController;
import com.tdtu.employeeservice.config.AxonConfig;
import com.tdtu.employeeservice.query.model.CandidateResponseModel;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@EnableDiscoveryClient
@EnableKafka
@Import({ AxonConfig.class })
@Slf4j
@ComponentScan(basePackages = "com.tdtu.employeeservice")
public class EmployeeserviceApplication {
    
    @Autowired
    private EmployeeCommandController employeeCommandController;

    @KafkaListener(topics = "recruitment", groupId = "employee-group")
    public void consume(@Payload String message, Acknowledgment acknowledgment) throws Exception {
        try {
        	log.info("Received Message: {}", message);
        	Gson gson = new GsonBuilder().setPrettyPrinting().create();
            CandidateResponseModel model = gson.fromJson(message, CandidateResponseModel.class);
            log.info("Converted to CandidateResponseModel: {}", model);

            acknowledgment.acknowledge();
        } catch (Exception e) {
            log.error("Error processing message: " + e.getMessage(), e);
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(EmployeeserviceApplication.class, args);
    }
}
