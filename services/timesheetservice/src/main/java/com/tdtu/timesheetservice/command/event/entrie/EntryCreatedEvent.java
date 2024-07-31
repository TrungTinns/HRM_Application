package com.tdtu.timesheetservice.command.event.entrie;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EntryCreatedEvent {
	private String id;
	private String empId;
	private Date clockIn;
	private Date clockOut;
	private Date breakStart;
	private Date breakEnd;
	private Double overTimeHours;
}
