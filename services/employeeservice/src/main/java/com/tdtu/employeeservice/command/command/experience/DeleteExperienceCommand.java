package com.tdtu.employeeservice.command.command.experience;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DeleteExperienceCommand {

	@TargetAggregateIdentifier
	private String id;
}
