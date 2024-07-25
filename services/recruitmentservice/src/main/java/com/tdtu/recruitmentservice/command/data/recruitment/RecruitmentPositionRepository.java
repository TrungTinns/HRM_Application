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
public class RecruitmentPositionRepository {
    private static final String COLLECTION_NAME = "JobPositions";

    public String save(RecruitmentPosition e) throws InterruptedException, ExecutionException {        
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> jobPositionMap = new HashMap<>();
        jobPositionMap.put("name", e.getName());
        jobPositionMap.put("department", e.getDepartment());
        jobPositionMap.put("jobLocation", e.getJobLocation());
        jobPositionMap.put("mailAlias", e.getMailAlias());
        jobPositionMap.put("empType", e.getEmpType());
        jobPositionMap.put("target", e.getTarget());
        jobPositionMap.put("recruiterId", e.getRecruiterId());
        jobPositionMap.put("interviewers", e.getInterviewers());
        jobPositionMap.put("description", e.getDescription());
        
        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(jobPositionMap);

        return collection.get().getUpdateTime().toString();
    }

    public String update(RecruitmentPosition e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> jobPositionMap = new HashMap<>();
        jobPositionMap.put("name", e.getName());
        jobPositionMap.put("department", e.getDepartment());
        jobPositionMap.put("jobLocation", e.getJobLocation());
        jobPositionMap.put("mailAlias", e.getMailAlias());
        jobPositionMap.put("empType", e.getEmpType());
        jobPositionMap.put("target", e.getTarget());
        jobPositionMap.put("recruiterId", e.getRecruiterId());
        jobPositionMap.put("interviewers", e.getInterviewers());
        jobPositionMap.put("description", e.getDescription());
        
        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(jobPositionMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public RecruitmentPosition findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        RecruitmentPosition e;
        if (document.exists()) {
            e = document.toObject(RecruitmentPosition.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<RecruitmentPosition> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<RecruitmentPosition> jobPositionList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            RecruitmentPosition e = document.toObject(RecruitmentPosition.class);
            e.setId(document.getId());
            jobPositionList.add(e);
        }

        return jobPositionList;
    }
}
