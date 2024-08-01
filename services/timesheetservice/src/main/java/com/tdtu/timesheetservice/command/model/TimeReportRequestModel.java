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
public class TimeReportRequestModel {
	private String id;
	private String empId;
	private String reportType;
	private Date startDate;
	private Date endDate;
	private Double totalHours;
	private Double overTimeHours;
	private int leaveDays;
}
