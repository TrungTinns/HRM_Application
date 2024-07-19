package com.tdtu.employeeservice.query.model;

import java.util.List;

import com.tdtu.employeeservice.command.data.level.Level;

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
public class SkillResponseModel {
	private String id;
	private String skillType;
	private List<String> name;
	private Level levels;
}
