package com.tdtu.employeeservice.command.command.resume;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DeleteResumeCommand {
	@TargetAggregateIdentifier
	private String id;
}
