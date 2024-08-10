package com.tdtu.timesheetservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.timeOffRequest.TimeOffRequest;
import com.tdtu.timesheetservice.command.data.timeOffRequest.TimeOffRequestService;
import com.tdtu.timesheetservice.query.model.TimeOffRequestResponseModel;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetAllTimeOffRequestsQuery;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetTimeOffRequestQuery;
import com.tdtu.timesheetservice.query.queries.timeOffRequest.GetTimeOffRequestsByEmpIdQuery;

@Component
public class TimeOffRequestProjection {
	@Autowired
	private TimeOffRequestService TimeOffRequestService;

	@QueryHandler
	public TimeOffRequestResponseModel handle(GetTimeOffRequestQuery getTimeOffRequestQuery)
			throws InterruptedException, ExecutionException {
		TimeOffRequestResponseModel model = new TimeOffRequestResponseModel();
		Optional<TimeOffRequest> optional = Optional.ofNullable(TimeOffRequestService.findById(getTimeOffRequestQuery.getId()));
		if (optional.isPresent()) {
			TimeOffRequest TimeOffRequest = optional.get();
			BeanUtils.copyProperties(TimeOffRequest, model);
		}
		return model;
	}

	@QueryHandler
	public List<TimeOffRequestResponseModel> handle(GetAllTimeOffRequestsQuery getAllTimeOffRequestsQuery)
			throws InterruptedException, ExecutionException {
		List<TimeOffRequest> lstEntity = TimeOffRequestService.findAll();
		List<TimeOffRequestResponseModel> lstEmp = new ArrayList<>();
		for (TimeOffRequest TimeOffRequest : lstEntity) {
			TimeOffRequestResponseModel model = new TimeOffRequestResponseModel();
			BeanUtils.copyProperties(TimeOffRequest, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
	
	@QueryHandler
	public List<TimeOffRequestResponseModel> handle(GetTimeOffRequestsByEmpIdQuery getTimeOffRequestsByEmpIdQuery)
			throws InterruptedException, ExecutionException {
		List<TimeOffRequest> lstEntity = TimeOffRequestService.findByEmpId(getTimeOffRequestsByEmpIdQuery.getEmpId());
		List<TimeOffRequestResponseModel> lstEmp = new ArrayList<>();
		for (TimeOffRequest TimeOffRequest : lstEntity) {
			TimeOffRequestResponseModel model = new TimeOffRequestResponseModel();
			BeanUtils.copyProperties(TimeOffRequest, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
