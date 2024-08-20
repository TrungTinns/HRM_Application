package com.tdtu.timesheetservice.command.command.complianceRule;

import java.util.Date;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class UpdateComplianceRuleCommand {
	@TargetAggregateIdentifier
	private String id;
	private String ruleDescription;
	private String penaltyDescription;
	private Double penaltyAmount;
	private Date effectiveDate;
}
