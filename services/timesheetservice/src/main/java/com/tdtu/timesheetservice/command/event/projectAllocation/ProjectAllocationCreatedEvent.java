package com.tdtu.timesheetservice.command.event.projectAllocation;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProjectAllocationCreatedEvent {
	private String id;
	private String empId;
	private String projectId;
	private String taskId;
	private Double timeSpent;
}
