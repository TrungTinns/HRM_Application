package com.tdtu.employeeservice.command.data.department;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Department {
	private String id;
	private String name;
	private String managerId;
	private String parentDepartmentId;
}
