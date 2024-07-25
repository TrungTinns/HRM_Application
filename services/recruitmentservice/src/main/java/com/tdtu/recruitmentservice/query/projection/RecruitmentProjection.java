package com.tdtu.recruitmentservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.recruitmentservice.command.data.recruitment.Recruitment;
import com.tdtu.recruitmentservice.command.data.recruitment.RecruitmentService;
import com.tdtu.recruitmentservice.query.model.RecruitmentResponseModel;
import com.tdtu.recruitmentservice.query.queries.recruitment.GetAllRecruitmentsQuery;
import com.tdtu.recruitmentservice.query.queries.recruitment.GetRecruitmentQuery;

@Component
public class RecruitmentProjection {
	@Autowired
	private RecruitmentService RecruitmentService;

	@QueryHandler
	public RecruitmentResponseModel handle(GetRecruitmentQuery getRecruitmentQuery)
			throws InterruptedException, ExecutionException {
		RecruitmentResponseModel model = new RecruitmentResponseModel();
		Optional<Recruitment> empOptional = Optional.ofNullable(RecruitmentService.findById(getRecruitmentQuery.getId()));
		if (empOptional.isPresent()) {
			Recruitment Recruitment = empOptional.get();
			BeanUtils.copyProperties(Recruitment, model);
		}
		return model;
	}

	@QueryHandler
	public List<RecruitmentResponseModel> handle(GetAllRecruitmentsQuery getAllRecruitmentsQuery)
			throws InterruptedException, ExecutionException {
		List<Recruitment> lstEntity = RecruitmentService.findAll();
		List<RecruitmentResponseModel> lstEmp = new ArrayList<>();
		for (Recruitment Recruitment : lstEntity) {
			RecruitmentResponseModel model = new RecruitmentResponseModel();
			BeanUtils.copyProperties(Recruitment, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
