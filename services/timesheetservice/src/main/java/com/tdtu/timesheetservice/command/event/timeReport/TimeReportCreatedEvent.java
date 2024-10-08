package com.tdtu.timesheetservice.command.event.timeReport;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TimeReportCreatedEvent {
	private String id;
	private String empId;
	private String reportType;
	private Date startDate;
	private Date endDate;
	private Double totalHours;
	private Double overTimeHours;
	private int leaveDays;
}
