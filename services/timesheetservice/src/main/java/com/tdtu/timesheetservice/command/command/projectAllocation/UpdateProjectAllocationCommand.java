package com.tdtu.timesheetservice.command.command.projectAllocation;

import java.util.Date;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

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
public class UpdateProjectAllocationCommand {
	@TargetAggregateIdentifier
	private String id;
	private String empId;
	private String projectId;
	private String taskId;
	private Double timeSpent;
}
