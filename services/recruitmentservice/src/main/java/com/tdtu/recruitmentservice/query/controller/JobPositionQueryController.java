package com.tdtu.recruitmentservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.recruitmentservice.query.model.JobPositionResponseModel;
import com.tdtu.recruitmentservice.query.queries.jobPosition.GetAllJobPositionsQuery;
import com.tdtu.recruitmentservice.query.queries.jobPosition.GetJobPositionQuery;

@RestController
@RequestMapping("/api/v1/recruitment/jobPosition")
public class JobPositionQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public JobPositionResponseModel getJobPositionDetail(@PathVariable String id) {
		GetJobPositionQuery getJobPositionQuery = new GetJobPositionQuery();
		getJobPositionQuery.setId(id);

		JobPositionResponseModel empResponseModel = queryGateway
				.query(getJobPositionQuery, ResponseTypes.instanceOf(JobPositionResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<JobPositionResponseModel> getAllJobPositions() {
		GetAllJobPositionsQuery getAllJobPositionsQuery = new GetAllJobPositionsQuery();
		List<JobPositionResponseModel> lstEmp = queryGateway
				.query(getAllJobPositionsQuery, ResponseTypes.multipleInstancesOf(JobPositionResponseModel.class)).join();
		return lstEmp;
	}
}
