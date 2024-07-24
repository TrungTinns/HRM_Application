package com.tdtu.recruitmentservice.ulti;

import java.util.concurrent.ExecutionException;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import com.tdtu.employeeservice.command.data.contract.Contract;

public class FirestoreUtil {
	public static DocumentReference getDocumentReference(String documentPath) {
        Firestore firestore = FirestoreClient.getFirestore();
        return firestore.document(documentPath);
	}
	
	public static Contract getContract(DocumentReference documentReference)
			throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<DocumentSnapshot> future = documentReference.get();
		DocumentSnapshot document = future.get();
		if (document.exists()) {
			return document.toObject(Contract.class);
		} else {
			throw new RuntimeException("Level document not found for reference: " + documentReference.getPath());
		}
	}
}
