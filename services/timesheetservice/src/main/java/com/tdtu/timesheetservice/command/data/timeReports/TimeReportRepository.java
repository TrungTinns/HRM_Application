package com.tdtu.timesheetservice.command.data.timeReports;

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
public class TimeReportRepository {
	private static final String COLLECTION_NAME = "TimeReports";
	public String save(TimeReport e) throws InterruptedException, ExecutionException {
		 Firestore db = FirestoreClient.getFirestore();
	     Map<String, Object> TimeReportMap = new HashMap<>();
	     TimeReportMap.put("empId", e.getEmpId());
	     TimeReportMap.put("reportType", e.getReportType());
		 TimeReportMap.put("startDate", e.getStartDate());
		 TimeReportMap.put("endDate", e.getEndDate());
		 TimeReportMap.put("totalHours", e.getTotalHours());
		 TimeReportMap.put("overTimeHours", e.getOverTimeHours());
		 TimeReportMap.put("leaveDays", e.getLeaveDays());
	        
	     ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(TimeReportMap);
	
	     return collection.get().getUpdateTime().toString();
	}

    public String update(TimeReport e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> TimeReportMap = new HashMap<>();
        TimeReportMap.put("empId", e.getEmpId());
	    TimeReportMap.put("reportType", e.getReportType());
		TimeReportMap.put("startDate", e.getStartDate());
		TimeReportMap.put("endDate", e.getEndDate());
		TimeReportMap.put("totalHours", e.getTotalHours());
		TimeReportMap.put("overTimeHours", e.getOverTimeHours());
		TimeReportMap.put("leaveDays", e.getLeaveDays());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(TimeReportMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public TimeReport findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        TimeReport e;
        if (document.exists()) {
            e = document.toObject(TimeReport.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<TimeReport> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<TimeReport> TimeReportList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            TimeReport e = document.toObject(TimeReport.class);
            e.setId(document.getId());
            TimeReportList.add(e);
        }

        return TimeReportList;
    }
}
