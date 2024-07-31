package com.tdtu.timesheetservice.command.data.violationRecords;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ViolationRecord {
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
