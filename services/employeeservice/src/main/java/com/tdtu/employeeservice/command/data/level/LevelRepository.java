package com.tdtu.employeeservice.command.data.level;

import java.util.ArrayList;
import java.util.List;
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
public class LevelRepository {
	private static final String COLLECTION_NAME = "Levels";

	public String save(Level e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(e);

		return collection.get().getUpdateTime().toString();
	}

	public String update(Level e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(e);

		return collection.get().getUpdateTime().toString();
	}

	public String deleteById(String id) {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

		return "Sucessfully Delete " + id;
	}

	public Level findById(String id) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
		ApiFuture<DocumentSnapshot> future = reference.get();
		DocumentSnapshot document = future.get();

		Level level;
		if (document.exists()) {
			level = document.toObject(Level.class);
			level.setId(document.getId());
			return level;
		}
		return null;
	}

	public List<Level> findAll() throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

		List<Level> levels = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Level level = document.toObject(Level.class);
			level.setId(document.getId());
			levels.add(level);
		}

		return levels;
	}
}
