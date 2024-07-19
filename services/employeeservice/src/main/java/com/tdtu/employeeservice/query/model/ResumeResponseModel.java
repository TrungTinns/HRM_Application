package com.tdtu.employeeservice.query.model;

import java.util.List;

import com.tdtu.employeeservice.command.data.experience.Experience;
import com.tdtu.employeeservice.command.data.resume.SkillType;
import com.tdtu.employeeservice.command.data.skill.Skill;

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

public class ResumeResponseModel {
	private String id;
	private Experience experience;
	private List<SkillType> skillTypes;
}
