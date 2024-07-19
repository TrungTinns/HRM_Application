package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.experience.Experience;
import com.tdtu.employeeservice.command.data.experience.ExperienceService;
import com.tdtu.employeeservice.query.model.ExperienceResponseModel;
import com.tdtu.employeeservice.query.queries.experience.GetAllExperienceQuery;
import com.tdtu.employeeservice.query.queries.experience.GetExperienceQuery;

@Component
public class ExperienceProjection {
	@Autowired
	private ExperienceService experienceService;

	@QueryHandler
	public ExperienceResponseModel handle(GetExperienceQuery getExperienceQuery)
			throws InterruptedException, ExecutionException {
		ExperienceResponseModel model = new ExperienceResponseModel();
		Optional<Experience> experienceOptional = Optional.ofNullable(experienceService.findById(getExperienceQuery.getId()));
		if (experienceOptional.isPresent()) {
			Experience Experience = experienceOptional.get();
			BeanUtils.copyProperties(Experience, model);
		}
		return model;
	}

	@QueryHandler
	public List<ExperienceResponseModel> handle(GetAllExperienceQuery getAllExperiencesQuery)
			throws InterruptedException, ExecutionException {
		List<Experience> lstEntity = experienceService.findAll();
		List<ExperienceResponseModel> lstExperience = new ArrayList<>();
		for (Experience Experience : lstEntity) {
			ExperienceResponseModel model = new ExperienceResponseModel();
			BeanUtils.copyProperties(Experience, model);
			lstExperience.add(model);
		}
		return lstExperience;
	}
}
