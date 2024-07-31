package com.tdtu.timesheetservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.complianceRules.ComplianceRule;
import com.tdtu.timesheetservice.command.data.complianceRules.ComplianceRuleService;
import com.tdtu.timesheetservice.query.model.ComplianceRuleResponseModel;
import com.tdtu.timesheetservice.query.queries.complianceRule.GetAllComplianceRulesQuery;
import com.tdtu.timesheetservice.query.queries.complianceRule.GetComplianceRuleQuery;

@Component
public class ComplianceRuleProjection {
	@Autowired
	private ComplianceRuleService ComplianceRuleService;

	@QueryHandler
	public ComplianceRuleResponseModel handle(GetComplianceRuleQuery getComplianceRuleQuery)
			throws InterruptedException, ExecutionException {
		ComplianceRuleResponseModel model = new ComplianceRuleResponseModel();
		Optional<ComplianceRule> empOptional = Optional.ofNullable(ComplianceRuleService.findById(getComplianceRuleQuery.getId()));
		if (empOptional.isPresent()) {
			ComplianceRule ComplianceRule = empOptional.get();
			BeanUtils.copyProperties(ComplianceRule, model);
		}
		return model;
	}

	@QueryHandler
	public List<ComplianceRuleResponseModel> handle(GetAllComplianceRulesQuery getAllComplianceRulesQuery)
			throws InterruptedException, ExecutionException {
		List<ComplianceRule> lstEntity = ComplianceRuleService.findAll();
		List<ComplianceRuleResponseModel> lstEmp = new ArrayList<>();
		for (ComplianceRule ComplianceRule : lstEntity) {
			ComplianceRuleResponseModel model = new ComplianceRuleResponseModel();
			BeanUtils.copyProperties(ComplianceRule, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
