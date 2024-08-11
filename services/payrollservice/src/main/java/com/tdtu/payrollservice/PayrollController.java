package com.tdtu.payrollservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.payrollservice.kafka.ConsumerService;
import com.tdtu.payrollservice.kafka.ProducerService;
import com.tdtu.payrollservice.model.employee.EmployeeResponseModel;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/payroll")
public class PayrollController {
	
	@Autowired
	private ProducerService producer;

	@Autowired
	private ConsumerService consumer;
	
	@GetMapping 
	public PayrollResponseModel calculatePayrolll(
			@RequestParam("empId") String empId,
			@RequestParam("month") String monthStr,
			@RequestParam("year") String yearStr) throws InterruptedException {
		
		producer.sendEmployeeRequest(empId);
		
		Thread.sleep(2000);
		EmployeeResponseModel employee = consumer.getEmployee();
		log.info(employee.toString());
		return null;
	}
}
