package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.skill.Skill;
import com.tdtu.employeeservice.command.data.skill.SkillService;
import com.tdtu.employeeservice.query.model.SkillResponseModel;
import com.tdtu.employeeservice.query.queries.skill.GetAllSkillsQuery;
import com.tdtu.employeeservice.query.queries.skill.GetSkillQuery;

@Component
public class SkillProjection {
	@Autowired
	private SkillService skillService;

	@QueryHandler
	public SkillResponseModel handle(GetSkillQuery getSkillQuery)
			throws InterruptedException, ExecutionException {
		SkillResponseModel model = new SkillResponseModel();
		Optional<Skill> empOptional = Optional.ofNullable(skillService.findById(getSkillQuery.getId()));
		if (empOptional.isPresent()) {
			Skill Skill = empOptional.get();
			BeanUtils.copyProperties(Skill, model);
		}
		return model;
	}

	@QueryHandler
	public List<SkillResponseModel> handle(GetAllSkillsQuery getAllSkillsQuery)
			throws InterruptedException, ExecutionException {
		List<Skill> lstEntity = skillService.findAll();
		List<SkillResponseModel> lstEmp = new ArrayList<>();
		for (Skill Skill : lstEntity) {
			SkillResponseModel model = new SkillResponseModel();
			BeanUtils.copyProperties(Skill, model);
			lstEmp.add(model);
		}
		return lstEmp;
	}
}
