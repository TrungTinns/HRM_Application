package com.tdtu.employeeservice.util;

import java.util.concurrent.ExecutionException;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;

public class FirestoreUtil {
	public static DocumentReference getDocumentReference(String documentPath) {
        Firestore firestore = FirestoreClient.getFirestore();
        return firestore.document(documentPath);
  }
}
