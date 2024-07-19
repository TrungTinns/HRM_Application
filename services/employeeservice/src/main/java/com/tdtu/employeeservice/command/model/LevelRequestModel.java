package com.tdtu.employeeservice.command.model;

import java.util.List;

import com.tdtu.employeeservice.command.data.level.LevelDetailed;

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
public class LevelRequestModel {
	private String id;
	private String skillType;
	private List<LevelDetailed> levels;
}
