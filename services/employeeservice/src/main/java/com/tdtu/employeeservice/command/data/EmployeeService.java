package com.tdtu.employeeservice.command.data;

import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;

@Service
public class EmployeeService {
	
	private static final String COLLECTION_NAME = "Employee";
	
	public String save(Employee e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(e);
		
		return collection.get().getUpdateTime().toString();
	}
	
	public String update(Employee e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(e);
	
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
		if(document.exists()) {
			e = document.toObject(Employee.class);
			return e;
		}
		return null;
	}
}
