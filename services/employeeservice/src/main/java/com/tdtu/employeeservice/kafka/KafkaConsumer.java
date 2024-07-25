package com.tdtu.employeeservice.kafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tdtu.employeeservice.command.controller.EmployeeCommandController;
import com.tdtu.employeeservice.command.model.EmployeeRequestModel;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KafkaConsumer {

    @Autowired
    private EmployeeCommandController employeeCommandController;

    @Autowired
    private ObjectMapper objectMapper;

    @KafkaListener(topics = "recruitment", groupId = "employee-group")
    public void consume(@Payload String message, Acknowledgment acknowledgment) throws Exception {
        try {
            log.info("Received message: {}", message);
            EmployeeRequestModel employeeRequestModel = objectMapper.readValue(message, EmployeeRequestModel.class);
            employeeCommandController.addEmployee(employeeRequestModel);
            acknowledgment.acknowledge();
            log.info("Message processed successfully: {}", message);
        } catch (Exception e) {
            log.error("Error processing message: " + e.getMessage(), e);
        }
    }
}
