package com.tdtu.timesheetservice.command.data.projectAllocation;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProjectAllocation {
	private String id;
	private String empId;
	private String projectId;
	private String taskId;
	private Double timeSpent;
}
