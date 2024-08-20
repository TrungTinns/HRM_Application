package com.tdtu.recruitmentservice.command.data.candidate;

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
public class CandidateRepository {

    private static final String COLLECTION_NAME = "Candidates";

    public String save(Candidate e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> candidateMap = new HashMap<>();
        candidateMap.put("name", e.getName());
        candidateMap.put("subject", e.getSubject());
        candidateMap.put("mail", e.getMail());
        candidateMap.put("phone", e.getPhone());
        candidateMap.put("mobile", e.getMobile());
        candidateMap.put("profileAddress", e.getProfileAddress());
        candidateMap.put("degree", e.getDegree());
        candidateMap.put("interviewerId", e.getInterviewerId());
        candidateMap.put("recruiterId", e.getRecruiterId());
        candidateMap.put("appliedJob", e.getAppliedJob());
        candidateMap.put("department", e.getDepartment());
        candidateMap.put("source", e.getSource());
        candidateMap.put("medium", e.getMedium());
        candidateMap.put("availability", e.getAvailability());
        candidateMap.put("evaluation", e.getEvaluation());
        candidateMap.put("expectedSalary", e.getExpectedSalary());
        candidateMap.put("proposedSalary", e.getProposedSalary());
        candidateMap.put("applicationSummary", e.getApplicationSummary());
        candidateMap.put("jobPositionId", e.getJobPositionId());
        candidateMap.put("stage", e.getStage());
        candidateMap.put("isHired", e.getIsHired());
        candidateMap.put("isOffered", e.getIsOffered());
        
        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(candidateMap);

        return collection.get().getUpdateTime().toString();
    }

    public String update(Candidate e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> candidateMap = new HashMap<>();
        candidateMap.put("name", e.getName());
        candidateMap.put("subject", e.getSubject());
        candidateMap.put("mail", e.getMail());
        candidateMap.put("phone", e.getPhone());
        candidateMap.put("mobile", e.getMobile());
        candidateMap.put("profileAddress", e.getProfileAddress());
        candidateMap.put("degree", e.getDegree());
        candidateMap.put("interviewerId", e.getInterviewerId());
        candidateMap.put("recruiterId", e.getRecruiterId());
        candidateMap.put("appliedJob", e.getAppliedJob());
        candidateMap.put("department", e.getDepartment());
        candidateMap.put("source", e.getSource());
        candidateMap.put("medium", e.getMedium());
        candidateMap.put("availability", e.getAvailability());
        candidateMap.put("evaluation", e.getEvaluation());
        candidateMap.put("expectedSalary", e.getExpectedSalary());
        candidateMap.put("proposedSalary", e.getProposedSalary());
        candidateMap.put("applicationSummary", e.getApplicationSummary());
        candidateMap.put("jobPositionId", e.getJobPositionId());
        candidateMap.put("stage", e.getStage());
        candidateMap.put("isHired", e.getIsHired());
        candidateMap.put("isOffered", e.getIsOffered());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(candidateMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public Candidate findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        Candidate e;
        if (document.exists()) {
            e = document.toObject(Candidate.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<Candidate> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<Candidate> candidateList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            Candidate e = document.toObject(Candidate.class);
            e.setId(document.getId());
            candidateList.add(e);
        }

        return candidateList;
    }
}
