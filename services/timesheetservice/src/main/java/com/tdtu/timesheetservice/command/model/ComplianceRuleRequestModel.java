package com.tdtu.timesheetservice.command.model;

import java.util.Date;

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
public class ComplianceRuleRequestModel {
	private String id;
	private String ruleDescription;
	private String penaltyDescription;
	private Double penaltyAmount;
	private Date effectiveDate;
}
