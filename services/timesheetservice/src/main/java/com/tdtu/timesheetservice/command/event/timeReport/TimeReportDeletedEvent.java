package com.tdtu.timesheetservice.command.event.timeReport;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TimeReportDeletedEvent {
	private String id;
}
