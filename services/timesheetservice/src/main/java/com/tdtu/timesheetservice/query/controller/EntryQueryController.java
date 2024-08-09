package com.tdtu.timesheetservice.query.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.tdtu.timesheetservice.query.model.EntryResponseModel;
import com.tdtu.timesheetservice.query.model.ErrorResponseModel;
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntriesByEmpIdQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByClockInDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByClockOutDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByEmpIdAndClockInDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByEmpIdAndClockOutDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryQuery;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/v1/timesheet")
public class EntryQueryController {
	@Autowired
	private QueryGateway queryGateway;

	private static final String DATE_FORMAT = "yyyy-MM-dd";
	
	@GetMapping("/entry/{id}")
	public EntryResponseModel getEntryDetail(@PathVariable String id) {
		GetEntryQuery getEntryQuery = new GetEntryQuery();
		getEntryQuery.setId(id);

		EntryResponseModel empResponseModel = queryGateway
				.query(getEntryQuery, ResponseTypes.instanceOf(EntryResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping("/entries")
	public List<EntryResponseModel> getAllEntries() {
		GetAllEntriesQuery getAllEntrysQuery = new GetAllEntriesQuery();
		List<EntryResponseModel> lst = queryGateway
				.query(getAllEntrysQuery, ResponseTypes.multipleInstancesOf(EntryResponseModel.class)).join();
		return lst;
	}
	
	@GetMapping("/entries/{empId}")
	public List<EntryResponseModel> getEntriesByEmpId(@PathVariable String empId) {
		GetEntriesByEmpIdQuery query = new GetEntriesByEmpIdQuery();
		query.setEmpId(empId);
		
		List<EntryResponseModel> lst = queryGateway
				.query(query, ResponseTypes.multipleInstancesOf(EntryResponseModel.class)).join();
		return lst;
 	}
	
	
	@GetMapping("/entry/by-empId-and-clockInDate")
	public EntryResponseModel getEntryByEmpIdAndClockInDate(@RequestParam(name = "empId") String empId, @RequestParam(name = "clockInDate") String clockInDate){
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
			Date parsedDate = sdf.parse(clockInDate);
			
            GetEntryByEmpIdAndClockInDateQuery query = new GetEntryByEmpIdAndClockInDateQuery(empId, clockInDate);
            EntryResponseModel empResponseModel = queryGateway
                    .query(query, EntryResponseModel.class)
                    .join();
            return empResponseModel;
		} catch (ParseException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid clockInDate value, expected yyyy-MM-dd");
        }
		catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred");
		}
	}
	
	@GetMapping("/entry/by-empId-and-clockOutDate")
	public EntryResponseModel getEntryByEmpIdAndClockOutDate(@RequestParam(name = "empId") String empId, @RequestParam(name = "clockOutDate") String clockOutDate) throws ParseException{
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
			Date parsedDate = sdf.parse(clockOutDate);
			
			GetEntryByEmpIdAndClockOutDateQuery query = new GetEntryByEmpIdAndClockOutDateQuery(empId, clockOutDate);
            EntryResponseModel empResponseModel = queryGateway
                    .query(query, EntryResponseModel.class)
                    .join();
            return empResponseModel;
		}
		catch (ParseException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid clockOutDate value, expected yyyy-MM-dd");
        } 
		catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred");
		}
	}
	
	@GetMapping("/entry/by-clockInDate")
	public List<EntryResponseModel> getEntryByClockIntDate(@RequestParam(name = "clockInDate") String clockInDate) throws ParseException{
		try {
			
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
			Date parsedDate = sdf.parse(clockInDate);

			GetEntryByClockInDateQuery query = new GetEntryByClockInDateQuery(clockInDate);
    		List<EntryResponseModel> lst = queryGateway
    				.query(query, ResponseTypes.multipleInstancesOf(EntryResponseModel.class)).join();
    		return lst;
		}
		catch (ParseException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid clockInDate value, expected yyyy-MM-dd");
        } 
		catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred");
		}
	}
	
	@GetMapping("/entry/by-clockOutDate")
	public List<EntryResponseModel> getEntryByClockOutDate(@RequestParam(name = "clockOutDate") String clockOutDate) throws ParseException{
		try {
			
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
			Date parsedDate = sdf.parse(clockOutDate);

			GetEntryByClockOutDateQuery query = new GetEntryByClockOutDateQuery(clockOutDate);
    		List<EntryResponseModel> lst = queryGateway
    				.query(query, ResponseTypes.multipleInstancesOf(EntryResponseModel.class)).join();
    		return lst;
		}
		catch (ParseException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid clockOutDate value, expected yyyy-MM-dd");
        } 
		catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred");
		}
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
