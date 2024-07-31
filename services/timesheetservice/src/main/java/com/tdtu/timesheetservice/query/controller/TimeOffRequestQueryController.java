package com.tdtu.timesheetservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.timesheetservice.query.model.TimeOffRequestResponseModel;
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetAllTimeOffRequestsQuery;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetTimeOffRequestQuery;

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
}
