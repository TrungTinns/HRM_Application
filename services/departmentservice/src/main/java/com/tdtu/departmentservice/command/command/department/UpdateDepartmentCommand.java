package com.tdtu.departmentservice.command.command.department;

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
public class UpdateDepartmentCommand {
	@TargetAggregateIdentifier
	private String id;
	private String name;
	private String managerId;
	private String parentDepartmentId;
}
