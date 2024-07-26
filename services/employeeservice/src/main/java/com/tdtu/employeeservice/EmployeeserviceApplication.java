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
import org.springframework.context.annotation.ComponentScan;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tdtu.employeeservice.command.controller.EmployeeCommandController;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;
import com.tdtu.employeeservice.config.AxonConfig;
import com.tdtu.employeeservice.kafka.KafkaConsumer;

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

	 @Autowired
	 private ObjectMapper objectMapper;


	@KafkaListener(topics = "recruitment", groupId = "employee-group")
    public void consume(@Payload String message, Acknowledgment acknowledgment) throws Exception {
        try {
//            log.info("Received message: {}", message);
            EmployeeRequestModel employeeRequestModel = objectMapper.readValue(message, EmployeeRequestModel.class);
            employeeCommandController.addEmployee(employeeRequestModel);
            acknowledgment.acknowledge();
//            log.info("Message processed successfully: {}", message);
        } catch (Exception e) {
            log.error("Error processing message: " + e.getMessage(), e);
        }
    }
	
    public static void main(String[] args) {
        SpringApplication.run(EmployeeserviceApplication.class, args);
    }
}
