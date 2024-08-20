package com.tdtu.payrollservice;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.tdtu.payrollservice.kafka.ConsumerService;
import com.tdtu.payrollservice.kafka.ProducerService;
import com.tdtu.payrollservice.model.ErrorResponseModel;
import com.tdtu.payrollservice.model.employee.EmployeeResponseModel;
import com.tdtu.payrollservice.model.timesheet.TimeSheetResponseModel;

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
			@RequestParam("year") String yearStr,
			@RequestParam("otBounus") String otBounus,
			@RequestParam("tax") String tax,
			@RequestParam("hourlySalary") String hourlySalary,
			@RequestParam("dailySalary") String dailySalary) throws InterruptedException{
		
		Integer month = convertStringIntoInteger(monthStr,"month");
		Integer year = convertStringIntoInteger(yearStr,"year");
		
		producer.sendEmployeeRequest(empId);
		producer.sendTimeSheetRequest(empId, monthStr, yearStr);
		
		Thread.sleep(2000);
		EmployeeResponseModel employee = consumer.getEmployee();
		TimeSheetResponseModel timesheet = consumer.getTimeSheet();
		
		double salary = 0;
		if (employee.getContract().getSchedulePay().equals("Daily")) {
			salary = (timesheet.getTotalDay() * Double.parseDouble(dailySalary) 
			        + timesheet.getTotalOverTimes() * Double.parseDouble(otBounus)) 
			        * (1 - Double.parseDouble(tax)) - timesheet.getPenaltyAmount();
		}
		else {
			salary = (timesheet.getTotalOfficalHours() * Double.parseDouble(hourlySalary) 
			        + timesheet.getTotalOverTimes() * Double.parseDouble(otBounus)) 
			        * (1 - Double.parseDouble(tax)) - timesheet.getPenaltyAmount();
		}
		
		PayrollResponseModel resp = new PayrollResponseModel();
		resp.setEmpId(empId);
		resp.setSalary(salary);
		BeanUtils.copyProperties(timesheet, resp);
		
		return resp;
		
	}
	
	public Integer convertStringIntoInteger(String source, String field) {
		Integer target;
		try {
			target = Integer.parseInt(source);
			
			if (field == "month" && (target < 1  || target > 12)) {
				throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Month value must be in range [1,12]"); 
			}
			
			if (field == "year" && target < 0) {
				throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Year value must be greater than 0"); 
			}
		}
		catch (NumberFormatException e) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid " + field + " value"); 
		}
		return target;
	}
		
	
	@ExceptionHandler(ResponseStatusException.class)
    public ResponseEntity<ErrorResponseModel> handleResponseStatusException(ResponseStatusException e) {
        String message = e.getReason() != null ? e.getReason() : "An unexpected error occurred";
        ErrorResponseModel errorResponse = new ErrorResponseModel(e.getStatusCode().value(), message);
        return new ResponseEntity<>(errorResponse, e.getStatusCode());
    }
		
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponseModel> handleException(Exception e) {
    	ErrorResponseModel errorResponse = new ErrorResponseModel(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage());
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
