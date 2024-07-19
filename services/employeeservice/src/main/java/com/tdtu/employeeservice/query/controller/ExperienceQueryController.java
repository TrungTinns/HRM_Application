package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.ExperienceResponseModel;
import com.tdtu.employeeservice.query.queries.experience.GetAllExperienceQuery;
import com.tdtu.employeeservice.query.queries.experience.GetExperienceQuery;

@RestController
@RequestMapping("/api/v1/experience")
public class ExperienceQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public ExperienceResponseModel getExperienceDetail(@PathVariable String id) {
		GetExperienceQuery getExperienceQuery = new GetExperienceQuery();
		getExperienceQuery.setId(id);

		ExperienceResponseModel empResponseModel = queryGateway
				.query(getExperienceQuery, ResponseTypes.instanceOf(ExperienceResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<ExperienceResponseModel> getAllExperiences() {
		GetAllExperienceQuery getAllExperiencesQuery = new GetAllExperienceQuery();
		List<ExperienceResponseModel> lstEmp = queryGateway
				.query(getAllExperiencesQuery, ResponseTypes.multipleInstancesOf(ExperienceResponseModel.class)).join();
		return lstEmp;
	}
}
