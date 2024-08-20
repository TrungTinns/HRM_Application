package com.tdtu.payrollservice.model.timesheet;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

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
public class ViolationRecordResponseModel {
	private String id;
	private String empId;
	private String ruleId;
	 @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "EEE MMM dd HH:mm:ss zzz yyyy", timezone = "ICT")
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
