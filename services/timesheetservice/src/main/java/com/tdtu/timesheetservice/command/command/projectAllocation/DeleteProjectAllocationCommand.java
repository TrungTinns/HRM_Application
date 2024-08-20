package com.tdtu.timesheetservice.command.command.projectAllocation;

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
public class DeleteProjectAllocationCommand {
	@TargetAggregateIdentifier
	private String id;
}
