package com.tdtu.timesheetservice.command.data.violationRecord;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
	
	private static final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
	
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
    
    public List<ViolationRecord> findByEmpIdAndTime(String empId, Integer month, Integer year) throws InterruptedException, ExecutionException {
    	Firestore db = FirestoreClient.getFirestore();
    	
    	// START DATE
    	Calendar startCalendar = Calendar.getInstance();
    	startCalendar.set(Calendar.YEAR, year);
    	startCalendar.set(Calendar.MONTH, month - 1);
    	startCalendar.set(Calendar.DAY_OF_MONTH, 1);
    	startCalendar.set(Calendar.HOUR_OF_DAY, 0);
        startCalendar.set(Calendar.MINUTE, 0);
        startCalendar.set(Calendar.SECOND, 0);
        
    	Date startDate = startCalendar.getTime();
    	
    	// END DATE
    	Calendar endCalendar = Calendar.getInstance();
    	endCalendar.set(Calendar.YEAR, year);
    	endCalendar.set(Calendar.MONTH, month - 1);
    	endCalendar.set(Calendar.DAY_OF_MONTH, endCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
    	endCalendar.set(Calendar.HOUR_OF_DAY, 23);
        endCalendar.set(Calendar.MINUTE, 59);
        endCalendar.set(Calendar.SECOND, 59);
        
    	Date endDate = endCalendar.getTime();
    	
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME)
        		.whereEqualTo("empId", empId)
        		.whereGreaterThanOrEqualTo("violationDate", startDate)
        		.whereLessThan("violationDate", endDate)
        		.get();
        
        List<ViolationRecord> ViolationRecordList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            ViolationRecord e = document.toObject(ViolationRecord.class);
            e.setId(document.getId());
            ViolationRecordList.add(e);
        }

        return ViolationRecordList;
	}
}
