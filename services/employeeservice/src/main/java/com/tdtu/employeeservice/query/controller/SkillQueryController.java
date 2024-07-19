package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.SkillResponseModel;
import com.tdtu.employeeservice.query.queries.skill.GetAllSkillsQuery;
import com.tdtu.employeeservice.query.queries.skill.GetSkillQuery;

@RestController
@RequestMapping("/api/v1/skill")
public class SkillQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public SkillResponseModel getSkillDetail(@PathVariable String id) {
		GetSkillQuery getSkillQuery = new GetSkillQuery();
		getSkillQuery.setId(id);

		SkillResponseModel skillResponseModel = queryGateway
				.query(getSkillQuery, ResponseTypes.instanceOf(SkillResponseModel.class)).join();
		return skillResponseModel;
	}

	@GetMapping
	public List<SkillResponseModel> getAllSkills() {
		GetAllSkillsQuery getAllSkillsQuery = new GetAllSkillsQuery();
		List<SkillResponseModel> lstEmp = queryGateway
				.query(getAllSkillsQuery, ResponseTypes.multipleInstancesOf(SkillResponseModel.class)).join();
		return lstEmp;
	}
}
