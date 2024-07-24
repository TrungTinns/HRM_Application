package com.tdtu.recruitmentservice.command.event.jobPosition;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class JobPositionUpdatedEvent {
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
