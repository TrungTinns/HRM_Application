package com.tdtu.timesheetservice.query.model;

import java.util.List;

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
	private List<EntryResponseModel> entries;
	private List<ViolationRecordResponseModel> violation;
	private List<TimeOffRequestResponseModel> timeOff;
	private double totalOverTimes;
	private double penaltyAmount;
	private double totalOfficalHours;
}
