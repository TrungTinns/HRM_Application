package com.tdtu.recruitmentservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.recruitmentservice.command.data.jobPosition.JobPosition;
import com.tdtu.recruitmentservice.command.data.jobPosition.JobPositionService;
import com.tdtu.recruitmentservice.query.model.JobPositionResponseModel;
import com.tdtu.recruitmentservice.query.queries.jobPosition.GetAllJobPositionsQuery;
import com.tdtu.recruitmentservice.query.queries.jobPosition.GetJobPositionQuery;

@Component
public class JobPositionProjection {
	@Autowired
	private JobPositionService JobPositionService;

	@QueryHandler
	public JobPositionResponseModel handle(GetJobPositionQuery getJobPositionQuery)
			throws InterruptedException, ExecutionException {
		JobPositionResponseModel model = new JobPositionResponseModel();
		Optional<JobPosition> empOptional = Optional.ofNullable(JobPositionService.findById(getJobPositionQuery.getId()));
		if (empOptional.isPresent()) {
			JobPosition JobPosition = empOptional.get();
			BeanUtils.copyProperties(JobPosition, model);
		}
		return model;
	}

	@QueryHandler
	public List<JobPositionResponseModel> handle(GetAllJobPositionsQuery getAllJobPositionsQuery)
			throws InterruptedException, ExecutionException {
		List<JobPosition> lstEntity = JobPositionService.findAll();
		List<JobPositionResponseModel> lstEmp = new ArrayList<>();
		for (JobPosition JobPosition : lstEntity) {
			JobPositionResponseModel model = new JobPositionResponseModel();
			BeanUtils.copyProperties(JobPosition, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
