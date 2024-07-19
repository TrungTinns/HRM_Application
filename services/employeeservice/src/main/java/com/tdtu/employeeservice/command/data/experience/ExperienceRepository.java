package com.tdtu.employeeservice.command.data.experience;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import org.springframework.stereotype.Repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.Timestamp;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;

@Repository
public class ExperienceRepository {
	private static final String COLLECTION_NAME = "Experience";

	public String save(Experience e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
	    skillMap.put("experiences", e.getExperiences());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String update(Experience e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(e);

		return collection.get().getUpdateTime().toString();
	}

	public String deleteById(String id) {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

		return "Sucessfully Delete " + id;
	}

	public Experience findById(String id) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
		ApiFuture<DocumentSnapshot> future = reference.get();
		DocumentSnapshot document = future.get();

		Experience e;
		if (document.exists()) {
			e = document.toObject(Experience.class);
			e.setId(document.getId());
			List<Map<String, Object>> experiencesMap = (List<Map<String, Object>>) document.get("experiences");
			List<DetailedExperience> detailedExperiences = (List<DetailedExperience>) experiencesMap.stream()
					.map(map -> {
                        DetailedExperience detailedExperience = new DetailedExperience();
                        detailedExperience.setDescription((String) map.get("description"));
                        detailedExperience.setDisplayType((String) map.get("displayType"));
                        detailedExperience.setStartDate(((Timestamp) map.get("startDate")).toDate());
                        detailedExperience.setEndDate(((Timestamp) map.get("endDate")).toDate());
                        detailedExperience.setTitle((String) map.get("title"));
                        detailedExperience.setType((String) map.get("type"));
//                        BeanUtils.copyProperties(map,detailedExperience);
                        return detailedExperience;
                    })
			.collect(Collectors.toList());
            e.setExperiences(detailedExperiences);
			return e;
		}
		return null;
	}

	public List<Experience> findAll() throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

		List<Experience> experienceList = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Experience e = document.toObject(Experience.class);
			e.setId(document.getId());
			List<Map<String, Object>> experiencesMap = (List<Map<String, Object>>) document.get("experiences");
			List<DetailedExperience> detailedExperiences = (List<DetailedExperience>) experiencesMap.stream()
					.map(map -> {
                        DetailedExperience detailedExperience = new DetailedExperience();
                        detailedExperience.setDescription((String) map.get("description"));
                        detailedExperience.setDisplayType((String) map.get("displayType"));
                        detailedExperience.setStartDate(((Timestamp) map.get("startDate")).toDate());
                        detailedExperience.setEndDate(((Timestamp) map.get("endDate")).toDate());
                        detailedExperience.setTitle((String) map.get("title"));
                        detailedExperience.setType((String) map.get("type"));
//                        BeanUtils.copyProperties(map,detailedExperience);
                        return detailedExperience;
                    })
			.collect(Collectors.toList());
            e.setExperiences(detailedExperiences);
			experienceList.add(e);
		}

		return experienceList;
	}
}
