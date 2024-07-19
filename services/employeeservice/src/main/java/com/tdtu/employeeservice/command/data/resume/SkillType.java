package com.tdtu.employeeservice.command.data.resume;

import java.util.List;

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
public class SkillType {
	private String skillType;
	private List<SkillDetailed> skills;
}
