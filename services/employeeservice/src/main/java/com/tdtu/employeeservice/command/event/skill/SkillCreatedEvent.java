package com.tdtu.employeeservice.command.event.skill;

import java.util.List;

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
public class SkillCreatedEvent {
	private String id;
	private String skillType;
	private List<String> name;
	private DocumentReference levels;
}
