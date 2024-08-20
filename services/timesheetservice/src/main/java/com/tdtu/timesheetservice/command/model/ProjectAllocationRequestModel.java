package com.tdtu.timesheetservice.command.model;

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
public class ProjectAllocationRequestModel {
	private String id;
	private String empId;
	private String projectId;
	private String taskId;
	private Double timeSpent;
}
