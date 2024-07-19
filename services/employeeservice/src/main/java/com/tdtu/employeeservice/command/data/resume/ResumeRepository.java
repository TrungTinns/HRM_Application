package com.tdtu.employeeservice.command.data.resume;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;

@Repository
public class ResumeRepository {
	private static final String COLLECTION_NAME = "Resume";

	public String save(Resume e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
	    skillMap.put("skillTypes", e.getSkillTypes());
	    skillMap.put("experience", e.getExperienceRef());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String update(Resume e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
	    skillMap.put("skillTypes", e.getSkillTypes());
	    skillMap.put("experience", e.getExperienceRef());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String deleteById(String id) {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

		return "Sucessfully Delete " + id;
	}

	public Resume findById(String id) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
		ApiFuture<DocumentSnapshot> future = reference.get();
		DocumentSnapshot document = future.get();

		Resume resume;
		if (document.exists()) {
			resume = document.toObject(Resume.class);
			resume.setId(document.getId());
			return resume;
		}
		return null;
	}

	public List<Resume> findAll() throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

		List<Resume> resumeList = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Resume resume = document.toObject(Resume.class);
			resume.setId(document.getId());
			resumeList.add(resume);
		}

		return resumeList;
	}
}
