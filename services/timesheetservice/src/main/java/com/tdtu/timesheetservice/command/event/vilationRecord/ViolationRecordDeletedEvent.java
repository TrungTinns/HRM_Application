package com.tdtu.timesheetservice.command.event.vilationRecord;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ViolationRecordDeletedEvent {
	private String id;
}
