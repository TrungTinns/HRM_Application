package com.tdtu.timesheetservice.command.event.timeOffRequest;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TimeOffRequestDeletedEvent {
	private String id;
}
