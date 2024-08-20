package com.tdtu.timesheetservice.command.data.complianceRule;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ComplianceRuleService {
	@Autowired
	ComplianceRuleRepository repo;

	public String save(ComplianceRule e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(ComplianceRule e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public ComplianceRule findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<ComplianceRule> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
