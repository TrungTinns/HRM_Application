package com.tdtu.employeeservice.command.data.level;

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
public class Level {
	private String id;
	private String skillType;
	private List<LevelDetailed> levels;
}
