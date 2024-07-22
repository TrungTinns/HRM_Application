package com.tdtu.departmentservice.command.event.department;

import java.util.Date;
import java.util.List;

import com.google.cloud.firestore.DocumentReference;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DepartmentCreatedEvent {
	private String id;
	private String name;
	private String managerId;
	private String parentDepartmentId;
}
