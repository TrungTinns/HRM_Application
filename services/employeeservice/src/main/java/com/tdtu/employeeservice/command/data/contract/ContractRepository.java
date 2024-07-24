package com.tdtu.employeeservice.command.data.contract;

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
public class ContractRepository {
	private static final String COLLECTION_NAME = "Contracts";
	
	public String save(Contract c) throws InterruptedException, ExecutionException {		
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
	    skillMap.put("id", c.getId());
	    skillMap.put("schedule", c.getSchedule());
	    skillMap.put("salaryStructure", c.getSalaryStructure());
	    skillMap.put("contractType", c.getContractType());
	    skillMap.put("cost", c.getCost());
	    skillMap.put("startDate", c.getStartDate());
	    skillMap.put("endDate", c.getEndDate());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(c.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String update(Contract c) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
		skillMap.put("id", c.getId());
	    skillMap.put("schedule", c.getSchedule());
	    skillMap.put("salaryStructure", c.getSalaryStructure());
	    skillMap.put("contractType", c.getContractType());
	    skillMap.put("cost", c.getCost());
	    skillMap.put("startDate", c.getStartDate());
	    skillMap.put("endDate", c.getEndDate());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(c.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String deleteById(String id) {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

		return "Sucessfully Delete " + id;
	}

	public Contract findById(String id) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
		ApiFuture<DocumentSnapshot> future = reference.get();
		DocumentSnapshot document = future.get();

		Contract c;
		if (document.exists()) {
			c = document.toObject(Contract.class);
			c.setId(document.getId());
			return c;
		}
		return null;
	}

	public List<Contract> findAll() throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

		List<Contract> contracts = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Contract c = document.toObject(Contract.class);
			c.setId(document.getId());
			contracts.add(c);
		}

		return contracts;
	}
}
