package com.tdtu.timesheetservice.command.data.violationRecord;

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
public class ViolationRecordRepository {
	private static final String COLLECTION_NAME = "ViolationRecords";
	public String save(ViolationRecord e) throws InterruptedException, ExecutionException {
		 Firestore db = FirestoreClient.getFirestore();
	     Map<String, Object> ViolationRecordMap = new HashMap<>();
	     ViolationRecordMap.put("empId", e.getEmpId());
	     ViolationRecordMap.put("ruleId", e.getRuleId());
		 ViolationRecordMap.put("violationDate", e.getViolationDate());
		 ViolationRecordMap.put("penaltyApplied", e.getPenaltyApplied()); 
		 ViolationRecordMap.put("comment", e.getComment());
	        
	     ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(ViolationRecordMap);
	
	     return collection.get().getUpdateTime().toString();
	}

    public String update(ViolationRecord e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> ViolationRecordMap = new HashMap<>();
        ViolationRecordMap.put("empId", e.getEmpId());
	    ViolationRecordMap.put("ruleId", e.getRuleId());
		ViolationRecordMap.put("violationDate", e.getViolationDate());
		ViolationRecordMap.put("penaltyApplied", e.getPenaltyApplied()); 
		ViolationRecordMap.put("comment", e.getComment());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(ViolationRecordMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public ViolationRecord findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        ViolationRecord e;
        if (document.exists()) {
            e = document.toObject(ViolationRecord.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<ViolationRecord> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<ViolationRecord> ViolationRecordList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            ViolationRecord e = document.toObject(ViolationRecord.class);
            e.setId(document.getId());
            ViolationRecordList.add(e);
        }

        return ViolationRecordList;
    }
    
    public List<ViolationRecord> findByEmpId(String empId) throws InterruptedException, ExecutionException {
    	Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).whereEqualTo("empId", empId).get();

        List<ViolationRecord> ViolationRecordList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            ViolationRecord e = document.toObject(ViolationRecord.class);
            e.setId(document.getId());
            ViolationRecordList.add(e);
        }

        return ViolationRecordList;
	}
}
