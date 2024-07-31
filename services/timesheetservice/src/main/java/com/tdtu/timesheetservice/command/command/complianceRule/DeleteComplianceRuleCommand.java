package com.tdtu.timesheetservice.command.command.complianceRule;

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
public class DeleteComplianceRuleCommand {
	@TargetAggregateIdentifier
	private String id;
}
