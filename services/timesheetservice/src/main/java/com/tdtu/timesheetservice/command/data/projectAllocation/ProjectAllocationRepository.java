package com.tdtu.timesheetservice.command.data.projectAllocation;

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
public class ProjectAllocationRepository {
	private static final String COLLECTION_NAME = "ProjectAllocations";
	public String save(ProjectAllocation e) throws InterruptedException, ExecutionException {
		 Firestore db = FirestoreClient.getFirestore();
	     Map<String, Object> ProjectAllocationMap = new HashMap<>();
	     ProjectAllocationMap.put("empId", e.getEmpId());
	     ProjectAllocationMap.put("projectId", e.getProjectId());
		 ProjectAllocationMap.put("taskId", e.getTaskId());
		 ProjectAllocationMap.put("timeSpent", e.getTimeSpent());
	        
	     ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(ProjectAllocationMap);
	
	     return collection.get().getUpdateTime().toString();
	}

    public String update(ProjectAllocation e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> ProjectAllocationMap = new HashMap<>();
        ProjectAllocationMap.put("empId", e.getEmpId());
	    ProjectAllocationMap.put("projectId", e.getProjectId());
		ProjectAllocationMap.put("taskId", e.getTaskId());
		ProjectAllocationMap.put("timeSpent", e.getTimeSpent());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(ProjectAllocationMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public ProjectAllocation findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        ProjectAllocation e;
        if (document.exists()) {
            e = document.toObject(ProjectAllocation.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<ProjectAllocation> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<ProjectAllocation> ProjectAllocationList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            ProjectAllocation e = document.toObject(ProjectAllocation.class);
            e.setId(document.getId());
            ProjectAllocationList.add(e);
        }

        return ProjectAllocationList;
    }
}
