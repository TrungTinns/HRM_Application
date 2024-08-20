package com.tdtu.timesheetservice.command.event.projectAllocation;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProjectAllocationDeletedEvent {
	private String id;
}
