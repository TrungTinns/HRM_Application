package com.tdtu.payrollservice.kafka;

import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tdtu.payrollservice.model.employee.EmployeeResponseModel;
import com.tdtu.payrollservice.model.timesheet.TimeSheetResponseModel;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Service
public class ConsumerService {
	
	@Autowired
    private ObjectMapper objectMapper;
	
	private EmployeeResponseModel employee;
	
	private TimeSheetResponseModel timeSheet;

	
	@KafkaListener(topics="employee-response", groupId ="employee-group")
	public void consumeEmployeeResponse(@Payload String message, Acknowledgment acknowledgment) {
		log.info(message);
		try {
            employee = objectMapper.readValue(message, EmployeeResponseModel.class);
    		acknowledgment.acknowledge();
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
		
	}
	
	@KafkaListener(topics="timesheet-response", groupId ="timesheet-group")
	public void consumeTimeSheetResponse(@Payload String message, Acknowledgment acknowledgment) {
		log.info(message);
		SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy");
		try {
			timeSheet = objectMapper.readValue(message, TimeSheetResponseModel.class);
    		acknowledgment.acknowledge();
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
	}
}
