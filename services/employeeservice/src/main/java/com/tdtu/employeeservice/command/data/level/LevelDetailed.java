package com.tdtu.employeeservice.command.data.level;

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
public class LevelDetailed {
	private String name;
	private Double progress;
	private boolean isDefault;
}
