package com.tdtu.recruitmentservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.recruitmentservice.command.data.candidate.Candidate;
import com.tdtu.recruitmentservice.command.data.candidate.CandidateService;
import com.tdtu.recruitmentservice.query.model.CandidateResponseModel;
import com.tdtu.recruitmentservice.query.queries.candidate.GetAllCandidatesQuery;
import com.tdtu.recruitmentservice.query.queries.candidate.GetCandidateQuery;

@Component
public class CandidateProjection {
	@Autowired
	private CandidateService candidateService;

	@QueryHandler
	public CandidateResponseModel handle(GetCandidateQuery getCandidateQuery)
			throws InterruptedException, ExecutionException {
		CandidateResponseModel model = new CandidateResponseModel();
		Optional<Candidate> empOptional = Optional.ofNullable(candidateService.findById(getCandidateQuery.getId()));
		if (empOptional.isPresent()) {
			Candidate Candidate = empOptional.get();
			BeanUtils.copyProperties(Candidate, model);
		}
		return model;
	}

	@QueryHandler
	public List<CandidateResponseModel> handle(GetAllCandidatesQuery getAllCandidatesQuery)
			throws InterruptedException, ExecutionException {
		List<Candidate> lstEntity = candidateService.findAll();
		List<CandidateResponseModel> lstEmp = new ArrayList<>();
		for (Candidate Candidate : lstEntity) {
			CandidateResponseModel model = new CandidateResponseModel();
			BeanUtils.copyProperties(Candidate, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
