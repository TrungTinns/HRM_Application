package com.tdtu.timesheetservice.command.data.timeOffRequests;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;


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
}
