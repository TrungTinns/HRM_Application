package com.tdtu.timesheetservice.command.event.complianceRule;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ComplianceRuleDeletedEvent {
	private String id;
}
