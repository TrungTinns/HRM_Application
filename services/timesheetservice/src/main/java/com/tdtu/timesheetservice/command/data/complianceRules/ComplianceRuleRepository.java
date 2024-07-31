package com.tdtu.timesheetservice.command.data.complianceRules;

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
public class ComplianceRuleRepository {
	private static final String COLLECTION_NAME = "ComplianceRules";
	public String save(ComplianceRule e) throws InterruptedException, ExecutionException {
		 Firestore db = FirestoreClient.getFirestore();
	     Map<String, Object> ComplianceRuleMap = new HashMap<>();
	     ComplianceRuleMap.put("ruleDescription", e.getRuleDescription());
	     ComplianceRuleMap.put("penaltyDescription", e.getPenaltyDescription());
		 ComplianceRuleMap.put("penaltyAmount", e.getPenaltyAmount());
		 ComplianceRuleMap.put("effectiveDate", e.getEffectiveDate());
	        
	     ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(ComplianceRuleMap);
	
	     return collection.get().getUpdateTime().toString();
	}

    public String update(ComplianceRule e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> ComplianceRuleMap = new HashMap<>();
        ComplianceRuleMap.put("ruleDescription", e.getRuleDescription());
	    ComplianceRuleMap.put("penaltyDescription", e.getPenaltyDescription());
		ComplianceRuleMap.put("penaltyAmount", e.getPenaltyAmount());
		ComplianceRuleMap.put("effectiveDate", e.getEffectiveDate());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(ComplianceRuleMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public ComplianceRule findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        ComplianceRule e;
        if (document.exists()) {
            e = document.toObject(ComplianceRule.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<ComplianceRule> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<ComplianceRule> ComplianceRuleList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            ComplianceRule e = document.toObject(ComplianceRule.class);
            e.setId(document.getId());
            ComplianceRuleList.add(e);
        }

        return ComplianceRuleList;
    }
}
