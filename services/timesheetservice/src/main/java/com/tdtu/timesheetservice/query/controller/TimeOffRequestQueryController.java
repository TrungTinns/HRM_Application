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
import com.tdtu.timesheetservice.query.model.TimeOffRequestResponseModel;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetAllTimeOffRequestsQuery;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetTimeOfRequestsByEmpIdAndTimeQuery;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetTimeOffRequestQuery;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetTimeOffRequestsByEmpIdQuery;

@RestController
@RequestMapping("/api/v1/timesheet/timeOffRequest")
public class TimeOffRequestQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public TimeOffRequestResponseModel getTimeOffRequestDetail(@PathVariable String id) {
		GetTimeOffRequestQuery getTimeOffRequestQuery = new GetTimeOffRequestQuery();
		getTimeOffRequestQuery.setId(id);

		TimeOffRequestResponseModel empResponseModel = queryGateway
				.query(getTimeOffRequestQuery, ResponseTypes.instanceOf(TimeOffRequestResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<TimeOffRequestResponseModel> getAllTimeOffRequests() {
		GetAllTimeOffRequestsQuery getAllTimeOffRequestsQuery = new GetAllTimeOffRequestsQuery();
		List<TimeOffRequestResponseModel> lstEmp = queryGateway
				.query(getAllTimeOffRequestsQuery, ResponseTypes.multipleInstancesOf(TimeOffRequestResponseModel.class)).join();
		return lstEmp;
	}
	
	@GetMapping("/by-empId")
	public List<TimeOffRequestResponseModel> getTimeOffRequestsByEmpId(@RequestParam(name ="empId") String empId) {
		GetTimeOffRequestsByEmpIdQuery getAllTimeOffRequestsQuery = new GetTimeOffRequestsByEmpIdQuery(empId);
		List<TimeOffRequestResponseModel> lstEmp = queryGateway
				.query(getAllTimeOffRequestsQuery, ResponseTypes.multipleInstancesOf(TimeOffRequestResponseModel.class)).join();
		return lstEmp;
	}
	
	@GetMapping("/by-empId-time")
	public List<TimeOffRequestResponseModel> getTimeOffRequestsByEmpIdAndTime(@RequestParam(name ="empId") String empId,@RequestParam(name = "month") String monthStr,@RequestParam(name = "year") String yearStr) {
		Integer month = convertStringIntoInteger(monthStr,"month");
		Integer year = convertStringIntoInteger(yearStr,"year");
		
		GetTimeOfRequestsByEmpIdAndTimeQuery getAllTimeOffRequestsQuery = new GetTimeOfRequestsByEmpIdAndTimeQuery(empId, month, year);
		List<TimeOffRequestResponseModel> lstEmp = queryGateway
				.query(getAllTimeOffRequestsQuery, ResponseTypes.multipleInstancesOf(TimeOffRequestResponseModel.class)).join();
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
