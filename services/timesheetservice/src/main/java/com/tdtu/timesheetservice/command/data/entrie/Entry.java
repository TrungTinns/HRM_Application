package com.tdtu.timesheetservice.command.data.entrie;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Entry {
	private String id;
	private String empId;
	private Date clockIn;
	private Date clockOut;
	private Date breakStart;
	private Date breakEnd;
	private Double overTimeHours;
	
}
