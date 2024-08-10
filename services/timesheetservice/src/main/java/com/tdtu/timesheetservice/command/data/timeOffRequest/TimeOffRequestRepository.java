package com.tdtu.timesheetservice.command.data.timeOffRequest;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import org.springframework.stereotype.Repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.tdtu.timesheetservice.command.data.violationRecord.ViolationRecord;

@Repository
public class TimeOffRequestRepository {
	private static final String COLLECTION_NAME = "TimeOffRequests";
	public String save(TimeOffRequest e) throws InterruptedException, ExecutionException {
		 Firestore db = FirestoreClient.getFirestore();
	     Map<String, Object> TimeOffRequestMap = new HashMap<>();
	     TimeOffRequestMap.put("empId", e.getEmpId());
	     TimeOffRequestMap.put("leaveType", e.getLeaveType());
		 TimeOffRequestMap.put("applicationDate", e.getApplicationDate());
		 TimeOffRequestMap.put("startDate", e.getStartDate());
		 TimeOffRequestMap.put("endDate", e.getEndDate());
		 TimeOffRequestMap.put("status", e.getStatus());
	        
	     ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(TimeOffRequestMap);
	
	     return collection.get().getUpdateTime().toString();
	}

    public String update(TimeOffRequest e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> TimeOffRequestMap = new HashMap<>();
        TimeOffRequestMap.put("empId", e.getEmpId());
	    TimeOffRequestMap.put("leaveType", e.getLeaveType());
		TimeOffRequestMap.put("applicationDate", e.getApplicationDate());
		TimeOffRequestMap.put("startDate", e.getStartDate());
		TimeOffRequestMap.put("endDate", e.getEndDate());
		TimeOffRequestMap.put("status", e.getStatus());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(TimeOffRequestMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public TimeOffRequest findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        TimeOffRequest e;
        if (document.exists()) {
            e = document.toObject(TimeOffRequest.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<TimeOffRequest> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<TimeOffRequest> TimeOffRequestList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            TimeOffRequest e = document.toObject(TimeOffRequest.class);
            e.setId(document.getId());
            TimeOffRequestList.add(e);
        }

        return TimeOffRequestList;
    }
    
    public List<TimeOffRequest> findByEmpId(String empId) throws InterruptedException, ExecutionException {
    	Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME)
        		.whereEqualTo("empId", empId)
        		.get();

        List<TimeOffRequest> TimeOffRequestList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            TimeOffRequest e = document.toObject(TimeOffRequest.class);
            e.setId(document.getId());
            TimeOffRequestList.add(e);
        }

        return TimeOffRequestList;
	}
    
    public List<TimeOffRequest> findByEmpIdAndTime(String empId, Integer month, Integer year) throws InterruptedException, ExecutionException {
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
    	
        ApiFuture<QuerySnapshot> querySnapshot1 = db.collection(COLLECTION_NAME)
        		.whereEqualTo("empId", empId)
        		.whereGreaterThanOrEqualTo("startDate", startDate)
        		.whereLessThan("startDate", endDate)
        		.get();
        
        ApiFuture<QuerySnapshot> querySnapshot2 = db.collection(COLLECTION_NAME)
        		.whereEqualTo("empId", empId)
        		.whereGreaterThanOrEqualTo("endDate", startDate)
        		.whereLessThan("endDate", endDate)
        		.get();
        
        List<TimeOffRequest> lstReq = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot1.get().getDocuments()) {
            TimeOffRequest e = document.toObject(TimeOffRequest.class);
            e.setId(document.getId());
            lstReq.add(e);
        }
        for (DocumentSnapshot document : querySnapshot2.get().getDocuments()) {
            TimeOffRequest e = document.toObject(TimeOffRequest.class);
            e.setId(document.getId());
            lstReq.add(e);
        }
        
        lstReq = lstReq
        		.stream()
        		.distinct()
        		.collect(Collectors.toList());

        return lstReq;
	}
}
