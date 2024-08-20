package com.tdtu.timesheetservice.command.data.project;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Project {
	private String id;
	private String name;
	private String description;
}
