package com.tdtu.employeeservice.util;

import java.util.concurrent.ExecutionException;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import com.tdtu.employeeservice.command.data.experience.Experience;
import com.tdtu.employeeservice.command.data.level.Level;
import com.tdtu.employeeservice.command.data.resume.Resume;

public class FirestoreUtil {
	public static Resume getResume(DocumentReference documentReference)
			throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<DocumentSnapshot> future = documentReference.get();
		DocumentSnapshot document = future.get();
		if (document.exists()) {
			Resume resume = document.toObject(Resume.class);
			return resume;
		} else {
			throw new RuntimeException("Resume document not found for reference: " + documentReference.getPath());
		}
	}

	public static Experience getExperience(DocumentReference documentReference)
			throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<DocumentSnapshot> future = documentReference.get();
		DocumentSnapshot document = future.get();
		if (document.exists()) {
			Experience r = document.toObject(Experience.class);
			r.setId(document.getId());
			return r;
		} else {
			throw new RuntimeException("Experience document not found for reference: " + documentReference.getPath());
		}
	}


	public static Level getLevel(DocumentReference documentReference)
			throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<DocumentSnapshot> future = documentReference.get();
		DocumentSnapshot document = future.get();
		if (document.exists()) {
			return document.toObject(Level.class);
		} else {
			throw new RuntimeException("Level document not found for reference: " + documentReference.getPath());
		}
	}
	
	 public static DocumentReference getDocumentReference(String documentPath) {
	        Firestore firestore = FirestoreClient.getFirestore();
	        return firestore.document(documentPath);
	  }

}
