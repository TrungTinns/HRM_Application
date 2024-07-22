package com.tdtu.departmentservice.command.event.department;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DepartmentUpdatedEvent {
	private String id;
	private String name;
	private String managerId;
	private String parentDepartmentId;
}
