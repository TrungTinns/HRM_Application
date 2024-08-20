package com.tdtu.employeeservice.command.model;

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
public class DepartmentRequestModel {
	private String id;
	private String name;
	private String managerId;
	private String parentDepartmentId;
}
