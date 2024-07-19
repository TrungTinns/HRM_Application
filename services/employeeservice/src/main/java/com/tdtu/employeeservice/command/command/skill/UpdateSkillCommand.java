package com.tdtu.employeeservice.command.command.skill;

import java.util.List;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

import com.google.cloud.firestore.DocumentReference;
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
public class UpdateSkillCommand {
	@TargetAggregateIdentifier
	private String id;
	private String skillType;
	private List<String> name;
	private DocumentReference levels;
}
