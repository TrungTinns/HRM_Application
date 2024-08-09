package com.tdtu.timesheetservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.timesheetservice.query.model.ViolationRecordResponseModel;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetAllViolationRecordsQuery;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetViolationRecordQuery;
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
}
