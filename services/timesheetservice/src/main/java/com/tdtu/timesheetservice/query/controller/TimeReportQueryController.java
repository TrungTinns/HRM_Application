package com.tdtu.timesheetservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.timesheetservice.query.model.TimeReportResponseModel;
import com.tdtu.timesheetservice.query.queries.timeReport.GetAllTimeReportsQuery;
import com.tdtu.timesheetservice.query.queries.timeReport.GetTimeReportQuery;

@RestController
@RequestMapping("/api/v1/timesheet/timeReport")
public class TimeReportQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public TimeReportResponseModel getTimeReportDetail(@PathVariable String id) {
		GetTimeReportQuery getTimeReportQuery = new GetTimeReportQuery();
		getTimeReportQuery.setId(id);

		TimeReportResponseModel empResponseModel = queryGateway
				.query(getTimeReportQuery, ResponseTypes.instanceOf(TimeReportResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<TimeReportResponseModel> getAllTimeReports() {
		GetAllTimeReportsQuery getAllTimeReportsQuery = new GetAllTimeReportsQuery();
		List<TimeReportResponseModel> lstEmp = queryGateway
				.query(getAllTimeReportsQuery, ResponseTypes.multipleInstancesOf(TimeReportResponseModel.class)).join();
		return lstEmp;
	}
}
