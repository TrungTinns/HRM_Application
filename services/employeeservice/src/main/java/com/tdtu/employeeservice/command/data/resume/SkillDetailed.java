package com.tdtu.employeeservice.command.data.resume;

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
public class SkillDetailed {
	private String skill;
	private String level;
	private Double progress;
	private boolean isDefault;
}
