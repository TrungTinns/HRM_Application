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
public class TimeOffRequestRequestModel {
	private String id;
	private String empId;
	private String leaveType;
	private Date applicationDate;
	private Date startDate;
	private Date endDate;
	private String status;
}
