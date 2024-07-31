package com.tdtu.timesheetservice.command.event.complianceRule;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.complianceRule.ComplianceRule;
import com.tdtu.timesheetservice.command.data.complianceRule.ComplianceRuleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ComplianceRuleEventsHandler {
	@Autowired
	private ComplianceRuleService ComplianceRuleService;

	@EventHandler
	public void on(ComplianceRuleCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ComplianceRuleCreatedEvent for: " + event.getId());
		ComplianceRule ComplianceRule = new ComplianceRule();
		BeanUtils.copyProperties(event, ComplianceRule);
		ComplianceRuleService.save(ComplianceRule);
		log.info("ComplianceRule created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(ComplianceRuleUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ComplianceRuleUpdatedEvent for: " + event.getId());
		Optional<ComplianceRule> ComplianceRuleOptional = Optional.ofNullable(ComplianceRuleService.findById(event.getId()));
		if (ComplianceRuleOptional.isPresent()) {
			ComplianceRule ComplianceRule = ComplianceRuleOptional.get();
			BeanUtils.copyProperties(event, ComplianceRule);
			ComplianceRuleService.update(ComplianceRule);
			log.info("ComplianceRule updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("ComplianceRule not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(ComplianceRuleDeletedEvent event) {
		log.info("Handling ComplianceRuleDeletedEvent for: " + event.getId());
		ComplianceRuleService.deleteById(event.getId());
		log.info("ComplianceRule deleted from Firestore: " + event.getId());
	}
}
