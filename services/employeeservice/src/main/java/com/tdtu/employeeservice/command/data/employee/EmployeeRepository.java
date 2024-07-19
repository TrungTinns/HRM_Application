package com.tdtu.employeeservice.command.data.employee;

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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class EmployeeRepository {
	
	private static final String COLLECTION_NAME = "Employee";
	
	public String save(Employee e) throws InterruptedException, ExecutionException {		
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
	    skillMap.put("firstName", e.getFirstName());
	    skillMap.put("lastName", e.getLastName());
	    skillMap.put("dateOfBirth", e.getDateOfBirth());
	    skillMap.put("email", e.getEmail());
	    skillMap.put("position", e.getPosition());
	    skillMap.put("salary", e.getSalary());
	    skillMap.put("department", e.getDepartment());
	    skillMap.put("phone", e.getPhone());
	    skillMap.put("img", e.getImg());
	    skillMap.put("tags", e.getTags());
	    skillMap.put("managerId", e.getManagerId());
	    skillMap.put("coachId", e.getCoachId());
	    skillMap.put("resume", e.getResumeRef());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String update(Employee e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
	    skillMap.put("firstName", e.getFirstName());
	    skillMap.put("lastName", e.getLastName());
	    skillMap.put("dateOfBirth", e.getDateOfBirth());
	    skillMap.put("email", e.getEmail());
	    skillMap.put("position", e.getPosition());
	    skillMap.put("salary", e.getSalary());
	    skillMap.put("department", e.getDepartment());
	    skillMap.put("phone", e.getPhone());
	    skillMap.put("img", e.getImg());
	    skillMap.put("tags", e.getTags());
	    skillMap.put("managerId", e.getManagerId());
	    skillMap.put("coachId", e.getCoachId());
	    skillMap.put("resume", e.getResumeRef());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String deleteById(String id) {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

		return "Sucessfully Delete " + id;
	}

	public Employee findById(String id) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
		ApiFuture<DocumentSnapshot> future = reference.get();
		DocumentSnapshot document = future.get();

		Employee e;
		if (document.exists()) {
			e = document.toObject(Employee.class);
			e.setId(document.getId());
			log.info(e.getResume().getExperience().toString().toUpperCase());
			return e;
		}
		return null;
	}

	public List<Employee> findAll() throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

		List<Employee> employeeList = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Employee e = document.toObject(Employee.class);
			e.setId(document.getId());
			employeeList.add(e);
		}

		return employeeList;
	}
}

