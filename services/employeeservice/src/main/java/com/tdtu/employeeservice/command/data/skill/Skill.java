package com.tdtu.employeeservice.command.data.skill;

import java.util.List;
import java.util.concurrent.ExecutionException;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.employeeservice.command.data.level.Level;
import com.tdtu.employeeservice.util.FirestoreUtil;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Skill {
	private String id;
	private String skillType;
	private List<String> name;
	private DocumentReference levels;
	public Level getLevels() throws InterruptedException, ExecutionException {
		return FirestoreUtil.getLevel(levels);
	}
	public DocumentReference getLevelsRef() {
		return this.levels;
	}
}
