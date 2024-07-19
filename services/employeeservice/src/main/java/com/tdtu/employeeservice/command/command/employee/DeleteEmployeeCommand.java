package com.tdtu.employeeservice.command.command.employee;


import org.axonframework.modelling.command.TargetAggregateIdentifier;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DeleteEmployeeCommand {
	@TargetAggregateIdentifier
	private String id;
}
