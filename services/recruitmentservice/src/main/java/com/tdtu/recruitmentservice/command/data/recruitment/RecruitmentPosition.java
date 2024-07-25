package com.tdtu.recruitmentservice.command.data.recruitment;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RecruitmentPosition {
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
