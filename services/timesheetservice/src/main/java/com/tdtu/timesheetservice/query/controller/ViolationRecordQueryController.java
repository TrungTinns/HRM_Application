package com.tdtu.timesheetservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.tdtu.timesheetservice.query.model.ErrorResponseModel;
import com.tdtu.timesheetservice.query.model.ViolationRecordResponseModel;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetAllViolationRecordsQuery;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetViolationRecordQuery;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetViolationRecordsByEmpIdAndTimeQuery;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetViolationRecordsByEmpIdQuery;

@RestController
@RequestMapping("/api/v1/timesheet/violationRecord")
public class ViolationRecordQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public ViolationRecordResponseModel getViolationRecordDetail(@PathVariable String id) {
		GetViolationRecordQuery getViolationRecordQuery = new GetViolationRecordQuery();
		getViolationRecordQuery.setId(id);

		ViolationRecordResponseModel empResponseModel = queryGateway
				.query(getViolationRecordQuery, ResponseTypes.instanceOf(ViolationRecordResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<ViolationRecordResponseModel> getAllViolationRecords() {
		GetAllViolationRecordsQuery getAllViolationRecordsQuery = new GetAllViolationRecordsQuery();
		List<ViolationRecordResponseModel> lstEmp = queryGateway
				.query(getAllViolationRecordsQuery, ResponseTypes.multipleInstancesOf(ViolationRecordResponseModel.class)).join();
		return lstEmp;
	}
	
	@GetMapping("/by-empId")
	public List<ViolationRecordResponseModel> getViolationRecordsByEmpId(@RequestParam(name = "empId") String empId) {
		GetViolationRecordsByEmpIdQuery getAllViolationRecordsQuery = new GetViolationRecordsByEmpIdQuery(empId);
		List<ViolationRecordResponseModel> lstEmp = queryGateway
				.query(getAllViolationRecordsQuery, ResponseTypes.multipleInstancesOf(ViolationRecordResponseModel.class)).join();
		return lstEmp;
	}
	
	@GetMapping("/by-empId-time")
	public List<ViolationRecordResponseModel> getViolationRecordsByEmpIdAndTime(@RequestParam(name = "empId") String empId ,@RequestParam(name = "month") String monthStr,@RequestParam(name = "year") String yearStr) {
		Integer month = convertStringIntoInteger(monthStr,"month");
		Integer year = convertStringIntoInteger(yearStr,"year");
		
		GetViolationRecordsByEmpIdAndTimeQuery getAllViolationRecordsQuery = new GetViolationRecordsByEmpIdAndTimeQuery(empId,month,year);
		List<ViolationRecordResponseModel> lstEmp = queryGateway
				.query(getAllViolationRecordsQuery, ResponseTypes.multipleInstancesOf(ViolationRecordResponseModel.class)).join();
		return lstEmp;
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
