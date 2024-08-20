package com.tdtu.timesheetservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.timeReport.TimeReport;
import com.tdtu.timesheetservice.command.data.timeReport.TimeReportService;
import com.tdtu.timesheetservice.query.model.TimeReportResponseModel;
import com.tdtu.timesheetservice.query.queries.timeReport.GetAllTimeReportsQuery;
import com.tdtu.timesheetservice.query.queries.timeReport.GetTimeReportQuery;


@Component
public class TimeReportProjection {
	@Autowired
	private TimeReportService TimeReportService;

	@QueryHandler
	public TimeReportResponseModel handle(GetTimeReportQuery getTimeReportQuery)
			throws InterruptedException, ExecutionException {
		TimeReportResponseModel model = new TimeReportResponseModel();
		Optional<TimeReport> empOptional = Optional.ofNullable(TimeReportService.findById(getTimeReportQuery.getId()));
		if (empOptional.isPresent()) {
			TimeReport TimeReport = empOptional.get();
			BeanUtils.copyProperties(TimeReport, model);
		}
		return model;
	}

	@QueryHandler
	public List<TimeReportResponseModel> handle(GetAllTimeReportsQuery getAllTimeReportsQuery)
			throws InterruptedException, ExecutionException {
		List<TimeReport> lstEntity = TimeReportService.findAll();
		List<TimeReportResponseModel> lstEmp = new ArrayList<>();
		for (TimeReport TimeReport : lstEntity) {
			TimeReportResponseModel model = new TimeReportResponseModel();
			BeanUtils.copyProperties(TimeReport, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
