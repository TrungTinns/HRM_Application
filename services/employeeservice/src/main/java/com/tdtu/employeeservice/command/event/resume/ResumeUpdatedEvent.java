package com.tdtu.employeeservice.command.event.resume;

import java.util.List;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.employeeservice.command.data.resume.SkillType;

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
public class ResumeUpdatedEvent {
	private String id;
	private DocumentReference experience;
	private List<SkillType> skillTypes;
}
