package com.tdtu.timesheetservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.timesheetservice.command.command.complianceRule.CreateComplianceRuleCommand;
import com.tdtu.timesheetservice.command.command.complianceRule.DeleteComplianceRuleCommand;
import com.tdtu.timesheetservice.command.command.complianceRule.UpdateComplianceRuleCommand;
import com.tdtu.timesheetservice.command.event.complianceRule.ComplianceRuleCreatedEvent;
import com.tdtu.timesheetservice.command.event.complianceRule.ComplianceRuleDeletedEvent;
import com.tdtu.timesheetservice.command.event.complianceRule.ComplianceRuleUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class ComplianceRuleAggregate {
	@AggregateIdentifier
	private String id;
	private String ruleDescription;
	private String penaltyDescription;
	private Double penaltyAmount;
	private Date effectiveDate;

	
	// CREATE EVENT
	@CommandHandler
	public ComplianceRuleAggregate(CreateComplianceRuleCommand createComplianceRuleCommand) {
		ComplianceRuleCreatedEvent ComplianceRuleCreatedEvent = new ComplianceRuleCreatedEvent();
		BeanUtils.copyProperties(createComplianceRuleCommand, ComplianceRuleCreatedEvent);
		AggregateLifecycle.apply(ComplianceRuleCreatedEvent);
	}

	@EventSourcingHandler
	public void on(ComplianceRuleCreatedEvent event) {
		this.id = event.getId();
        this.ruleDescription = event.getRuleDescription();
        this.penaltyDescription = event.getPenaltyDescription();
        this.penaltyAmount = event.getPenaltyAmount();
        this.effectiveDate = event.getEffectiveDate();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateComplianceRuleCommand updateComplianceRuleCommand) {
		ComplianceRuleUpdatedEvent ComplianceRuleUpdatedEvent = new ComplianceRuleUpdatedEvent();
		BeanUtils.copyProperties(updateComplianceRuleCommand, ComplianceRuleUpdatedEvent);
		AggregateLifecycle.apply(ComplianceRuleUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(ComplianceRuleUpdatedEvent event) {
		this.id = event.getId();
        this.ruleDescription = event.getRuleDescription();
        this.penaltyDescription = event.getPenaltyDescription();
        this.penaltyAmount = event.getPenaltyAmount();
        this.effectiveDate = event.getEffectiveDate();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteComplianceRuleCommand deleteComplianceRuleCommand) {
		ComplianceRuleDeletedEvent ComplianceRuleDeletedEvent = new ComplianceRuleDeletedEvent();
		BeanUtils.copyProperties(deleteComplianceRuleCommand, ComplianceRuleDeletedEvent);
		AggregateLifecycle.apply(ComplianceRuleDeletedEvent);
	}

	@EventSourcingHandler
	public void on(ComplianceRuleDeletedEvent event) {
		this.id = event.getId();
	}
}
