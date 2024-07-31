package com.tdtu.timesheetservice.command.data.timeOffRequest;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TimeOffRequest {
	private String id;
	private String empId;
	private String leaveType;
	private Date applicationDate;
	private Date startDate;
	private Date endDate;
	private String status;
}
