package com.tdtu.timesheetservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.timesheetservice.query.model.ProjectAllocationResponseModel;
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.projectAllocation.GetProjectAllocationQuery;

@RestController
@RequestMapping("/api/v1/timesheet/projectAllocation")
public class ProjectAllocationQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public ProjectAllocationResponseModel getCandidateDetail(@PathVariable String id) {
		GetProjectAllocationQuery getCandidateQuery = new GetProjectAllocationQuery();
		getCandidateQuery.setId(id);

		ProjectAllocationResponseModel empResponseModel = queryGateway
				.query(getCandidateQuery, ResponseTypes.instanceOf(ProjectAllocationResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<ProjectAllocationResponseModel> getAllCandidates() {
		GetAllEntriesQuery getAllCandidatesQuery = new GetAllEntriesQuery();
		List<ProjectAllocationResponseModel> lstEmp = queryGateway
				.query(getAllCandidatesQuery, ResponseTypes.multipleInstancesOf(ProjectAllocationResponseModel.class)).join();
		return lstEmp;
	}
}
