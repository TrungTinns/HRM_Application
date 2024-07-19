package com.tdtu.employeeservice.command.command.skill;

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
public class DeleteSkillCommand {
	@TargetAggregateIdentifier
	private String id;
}
