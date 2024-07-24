package com.tdtu.recruitmentservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.recruitmentservice.query.model.CandidateResponseModel;
import com.tdtu.recruitmentservice.query.queries.candidate.GetAllCandidatesQuery;
import com.tdtu.recruitmentservice.query.queries.candidate.GetCandidateQuery;

@RestController
@RequestMapping("/api/v1/recruitment/candidate")
public class CandidateQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public CandidateResponseModel getContractDetail(@PathVariable String id) {
		GetCandidateQuery getContractQuery = new GetCandidateQuery();
		getContractQuery.setId(id);

		CandidateResponseModel empResponseModel = queryGateway
				.query(getContractQuery, ResponseTypes.instanceOf(CandidateResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<CandidateResponseModel> getAllContracts() {
		GetAllCandidatesQuery getAllContractsQuery = new GetAllCandidatesQuery();
		List<CandidateResponseModel> lstEmp = queryGateway
				.query(getAllContractsQuery, ResponseTypes.multipleInstancesOf(CandidateResponseModel.class)).join();
		return lstEmp;
	}
}