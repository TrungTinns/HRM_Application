package com.tdtu.recruitmentservice.command.data.recruitment;

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
public class RecruitmentRepository {
    private static final String COLLECTION_NAME = "Recruitments";

    public String save(Recruitment e) throws InterruptedException, ExecutionException {        
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> jobPositionMap = new HashMap<>();
        jobPositionMap.put("candidateId", e.getCandidateId());
        jobPositionMap.put("offeredDate", e.getOfferedDate());
        
        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(jobPositionMap);

        return collection.get().getUpdateTime().toString();
    }

    public String update(Recruitment e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> jobPositionMap = new HashMap<>();
        jobPositionMap.put("candidateId", e.getCandidateId());
        jobPositionMap.put("offeredDate", e.getOfferedDate());
        
        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(jobPositionMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public Recruitment findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        Recruitment e;
        if (document.exists()) {
            e = document.toObject(Recruitment.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<Recruitment> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<Recruitment> jobPositionList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            Recruitment e = document.toObject(Recruitment.class);
            e.setId(document.getId());
            jobPositionList.add(e);
        }

        return jobPositionList;
    }
}
