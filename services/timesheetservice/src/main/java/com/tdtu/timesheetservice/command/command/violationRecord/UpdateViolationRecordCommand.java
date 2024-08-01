package com.tdtu.timesheetservice.command.command.violationRecord;

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
public class UpdateViolationRecordCommand {
	@TargetAggregateIdentifier
	private String id;
	private String empId;
	private String ruleId;
	private Date violationDate;
	private boolean penaltyApplied;
	private String comment;
	
	public void setPenaltyApplied(boolean penaltyApplied) {
		this.penaltyApplied = penaltyApplied;
	}
	
	public boolean getPenaltyApplied() {
		return this.penaltyApplied;
	}
}
