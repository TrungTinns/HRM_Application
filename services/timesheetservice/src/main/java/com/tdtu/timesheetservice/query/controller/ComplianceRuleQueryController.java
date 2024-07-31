package com.tdtu.timesheetservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.timesheetservice.query.model.ComplianceRuleResponseModel;
import com.tdtu.timesheetservice.query.queries.complianceRule.GetAllComplianceRulesQuery;
import com.tdtu.timesheetservice.query.queries.complianceRule.GetComplianceRuleQuery;

@RestController
@RequestMapping("/api/v1/timesheet/complianceRule")
public class ComplianceRuleQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public ComplianceRuleResponseModel getCandidateDetail(@PathVariable String id) {
		GetComplianceRuleQuery getCandidateQuery = new GetComplianceRuleQuery();
		getCandidateQuery.setId(id);

		ComplianceRuleResponseModel empResponseModel = queryGateway
				.query(getCandidateQuery, ResponseTypes.instanceOf(ComplianceRuleResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<ComplianceRuleResponseModel> getAllCandidates() {
		GetAllComplianceRulesQuery getAllCandidatesQuery = new GetAllComplianceRulesQuery();
		List<ComplianceRuleResponseModel> lstEmp = queryGateway
				.query(getAllCandidatesQuery, ResponseTypes.multipleInstancesOf(ComplianceRuleResponseModel.class)).join();
		return lstEmp;
	}
}
