package com.tdtu.employeeservice.command.data.resume;

import java.util.List;
import java.util.concurrent.ExecutionException;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.employeeservice.command.data.experience.Experience;
import com.tdtu.employeeservice.util.FirestoreUtil;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Resume {
	private String id;
	private List<SkillType> skillTypes;
	private DocumentReference experience;

	public Experience getExperience() throws InterruptedException, ExecutionException {
		return FirestoreUtil.getExperience(experience);
	}
	
	public Experience getExperienceObj() throws InterruptedException, ExecutionException {
		return getExperience();
	}
	
	public DocumentReference getExperienceRef() {
        return this.experience;
    }

}
