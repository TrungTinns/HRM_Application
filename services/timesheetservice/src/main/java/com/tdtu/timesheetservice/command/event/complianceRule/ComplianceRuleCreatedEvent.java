package com.tdtu.timesheetservice.command.event.complianceRule;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ComplianceRuleCreatedEvent {
	private String id;
	private String ruleDescription;
	private String penaltyDescription;
	private Double penaltyAmount;
	private Date effectiveDate;
}
