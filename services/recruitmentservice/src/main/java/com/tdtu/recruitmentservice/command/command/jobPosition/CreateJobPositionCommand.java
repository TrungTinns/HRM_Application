package com.tdtu.recruitmentservice.command.command.jobPosition;

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
public class CreateJobPositionCommand {
	@TargetAggregateIdentifier
	private String id;
	private String name;
	private String department;
	private String jobLocation;
	private String mailAlias;
	private String empType;
	private int target;
	private String recruiterId;
	private String interviewers;
	private String description;
}
