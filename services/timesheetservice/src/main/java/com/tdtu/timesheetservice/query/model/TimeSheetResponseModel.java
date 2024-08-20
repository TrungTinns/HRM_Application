package com.tdtu.timesheetservice.query.model;

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
public class TimeSheetResponseModel {
	private int totalDay;
	private double totalOverTimes;
	private double penaltyAmount;
	private double totalOfficalHours;
}
