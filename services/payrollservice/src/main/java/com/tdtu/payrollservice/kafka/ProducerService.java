package com.tdtu.payrollservice.kafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class ProducerService {
	
	@Autowired
	private KafkaTemplate<String, String> kafkaTemplate;
	
	 private static final String EMPLOYEE_TOPIC = "employee-request";
	 
	 private static final String TIMESHEET_TOPIC = "timesheet-request";
	 

	public void sendEmployeeRequest(String empId) {
		kafkaTemplate.send(EMPLOYEE_TOPIC, empId);
	}
	
	public void sendTimeSheetRequest(String empId, String month, String year) {
		String data = empId + "," + month +"," + year;
		kafkaTemplate.send(TIMESHEET_TOPIC, data);
	}
	
}
