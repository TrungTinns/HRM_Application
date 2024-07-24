package com.tdtu.recruitmentservice.comand.data.jobPosition;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class JobPosition {
	private String id;
	private String name;
	private String managerId;
	private String parentDepartmentId;
	private String department;
	private String jobLocation;
	private String mailAlias;
	private String empType;
	private int target;
	private String recruiterId;
	private String interviewers;
	private String description;
}
