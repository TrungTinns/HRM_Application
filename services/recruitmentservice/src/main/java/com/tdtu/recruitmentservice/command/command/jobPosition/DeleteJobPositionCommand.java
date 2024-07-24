package com.tdtu.recruitmentservice.command.command.jobPosition;

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
public class DeleteJobPositionCommand {
	@TargetAggregateIdentifier
	private String id;
}
