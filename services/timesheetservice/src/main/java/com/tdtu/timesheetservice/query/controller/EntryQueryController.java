package com.tdtu.timesheetservice.query.controller;

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
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntriesByEmpIdQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByEmpIdAndClockInDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryQuery;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	
	
	@GetMapping("/entry")
	public EntryResponseModel getEntryByEmpIdAndLockInDate(@RequestParam(name = "empId") String empId, @RequestParam(name = "clockInDate") String clockInDate){
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
			Date parsedDate = sdf.parse(clockInDate);
			
            GetEntryByEmpIdAndClockInDateQuery query = new GetEntryByEmpIdAndClockInDateQuery(empId, clockInDate);
            EntryResponseModel empResponseModel = queryGateway
                    .query(query, EntryResponseModel.class)
                    .join();
            return empResponseModel;
		} catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid clockInDate value, expected yyyy-MM-dd");
        }
	}
	
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleException(Exception e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid clockInDate value, expected yyyy-MM-dd");
    }

}
