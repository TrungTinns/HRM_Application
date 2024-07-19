package com.tdtu.employeeservice.command.command.level;

import java.util.List;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

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
public class CreateLevelCommand {
	@TargetAggregateIdentifier
	private String id;
	private String skillType;
	private List<LevelDetailed> levels;
}
