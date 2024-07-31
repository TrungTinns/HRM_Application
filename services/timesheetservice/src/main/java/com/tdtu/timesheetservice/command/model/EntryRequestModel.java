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
public class EntryRequestModel {
	private String id;
	private String empId;
	private Date clockIn;
	private Date clockOut;
	private Date breakStart;
	private Date breakEnd;
	private Double overTimeHours;
}
