package com.tdtu.timesheetservice.command.command.timeReport;

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
public class UpdateTimeReportCommand {
	@TargetAggregateIdentifier
	private String id;
	private String empId;
	private String reportType;
	private Date startDate;
	private Date endDate;
	private Double totalHours;
	private Double overTimeHours;
	private int leaveDays;
}
