package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.ResumeResponseModel;
import com.tdtu.employeeservice.query.queries.resume.GetAllResumeQuery;
import com.tdtu.employeeservice.query.queries.resume.GetResumeQuery;

@RestController
@RequestMapping("/api/v1/resume")
public class ResumeQueryController {

	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public ResumeResponseModel getResumeDetail(@PathVariable String id) {
		GetResumeQuery getResumeQuery = new GetResumeQuery();
		getResumeQuery.setId(id);

		ResumeResponseModel resumeResponseModel = queryGateway
				.query(getResumeQuery, ResponseTypes.instanceOf(ResumeResponseModel.class)).join();
		return resumeResponseModel;
	}

	@GetMapping
	public List<ResumeResponseModel> getAllResumes() {
		GetAllResumeQuery getAllResumeQuery = new GetAllResumeQuery();
		List<ResumeResponseModel> lstResume = queryGateway
				.query(getAllResumeQuery, ResponseTypes.multipleInstancesOf(ResumeResponseModel.class)).join();
		return lstResume;
	}
}
