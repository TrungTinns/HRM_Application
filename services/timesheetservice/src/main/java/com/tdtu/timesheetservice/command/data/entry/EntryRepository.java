package com.tdtu.timesheetservice.command.data.entry;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.google.cloud.firestore.Query;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class EntryRepository {
	private static final String COLLECTION_NAME = "Entries";
	public String save(Entry e) throws InterruptedException, ExecutionException {
		 Firestore db = FirestoreClient.getFirestore();
	     Map<String, Object> EntryMap = new HashMap<>();
	     EntryMap.put("empId", e.getEmpId());
	     EntryMap.put("clockIn", e.getClockIn());
		 EntryMap.put("clockOut", e.getClockOut());
		 EntryMap.put("breakStart", e.getBreakStart());
		 EntryMap.put("breakEnd", e.getBreakEnd());
		 EntryMap.put("overTimeHours", e.getOverTimeHours());
	        
	     ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(EntryMap);
	
	     return collection.get().getUpdateTime().toString();
	}

    public String update(Entry e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> EntryMap = new HashMap<>();
        EntryMap.put("empId", e.getEmpId());
        EntryMap.put("clockIn", e.getClockIn());
        EntryMap.put("clockOut", e.getClockOut());
        EntryMap.put("breakStart", e.getBreakStart());
        EntryMap.put("breakEnd", e.getBreakEnd());
        EntryMap.put("overTimeHours", e.getOverTimeHours());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(EntryMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

        return "Successfully Deleted " + id;
    }

    public Entry findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        Entry e;
        if (document.exists()) {
            e = document.toObject(Entry.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<Entry> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<Entry> EntryList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            Entry e = document.toObject(Entry.class);
            e.setId(document.getId());
            EntryList.add(e);
        }

        return EntryList;
    }
    
    public List<Entry> findByEmpId(String id) throws InterruptedException, ExecutionException {
    	Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).whereEqualTo("empId",id).get();

        List<Entry> EntryList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            Entry e = document.toObject(Entry.class);
            e.setId(document.getId());
            EntryList.add(e);
        }

        return EntryList;
	}
    
    public List<Entry> findByLockInDate(String date) throws ParseException, InterruptedException, ExecutionException {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        Date startOfDay = formatter.parse(date + "T00:00:00");
        Date endOfDay = formatter.parse(date + "T23:59:59");
        
        Firestore db = FirestoreClient.getFirestore();
        Query query = db.collection(COLLECTION_NAME)
                .whereGreaterThanOrEqualTo("clockIn", startOfDay)
                .whereLessThanOrEqualTo("clockIn", endOfDay);

        ApiFuture<QuerySnapshot> querySnapshot = query.get();
        
        List<Entry> EntryList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            Entry e = document.toObject(Entry.class);
            e.setId(document.getId());
            EntryList.add(e);
        }

        return EntryList;
    }
    
    public List<Entry> findByLockOutDate(String date) throws ParseException, InterruptedException, ExecutionException {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        Date startOfDay = formatter.parse(date + "T00:00:00");
        Date endOfDay = formatter.parse(date + "T23:59:59");
        
        Firestore db = FirestoreClient.getFirestore();
        Query query = db.collection(COLLECTION_NAME)
                .whereGreaterThanOrEqualTo("clockOut", startOfDay)
                .whereLessThanOrEqualTo("clockOut", endOfDay);

        ApiFuture<QuerySnapshot> querySnapshot = query.get();
        
        List<Entry> EntryList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            Entry e = document.toObject(Entry.class);
            e.setId(document.getId());
            EntryList.add(e);
        }

        return EntryList;
    }
    
    public Entry findByEmpIdAndClockInDate(String id, String date) throws InterruptedException, ExecutionException, ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        Date startOfDay = formatter.parse(date + "T00:00:00");
        Date endOfDay = formatter.parse(date + "T23:59:59");
        
        Firestore db = FirestoreClient.getFirestore();
        Query query = db.collection(COLLECTION_NAME)
                .whereEqualTo("empId", id)
                .whereGreaterThanOrEqualTo("clockIn", startOfDay)
                .whereLessThanOrEqualTo("clockIn", endOfDay);

        ApiFuture<QuerySnapshot> querySnapshot = query.get();
        List<QueryDocumentSnapshot> documents = querySnapshot.get().getDocuments();

        if (!documents.isEmpty()) {
            QueryDocumentSnapshot document = documents.get(0);
            Entry entry = document.toObject(Entry.class);
            entry.setId(document.getId());
            return entry;
        }
        return null;
    }
    
    public Entry findByEmpIdAndClockOutDate(String id, String date) throws InterruptedException, ExecutionException, ParseException {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        Date startOfDay = formatter.parse(date + "T00:00:00");
        Date endOfDay = formatter.parse(date + "T23:59:59");
        
        Firestore db = FirestoreClient.getFirestore();
        Query query = db.collection(COLLECTION_NAME)
                .whereEqualTo("empId", id)
                .whereGreaterThanOrEqualTo("clockOut", startOfDay)
                .whereLessThanOrEqualTo("clockOut", endOfDay);

        ApiFuture<QuerySnapshot> querySnapshot = query.get();
        List<QueryDocumentSnapshot> documents = querySnapshot.get().getDocuments();

        if (!documents.isEmpty()) {
            QueryDocumentSnapshot document = documents.get(0);
            Entry entry = document.toObject(Entry.class);
            entry.setId(document.getId());
            return entry;
        }
        return null;
	}
}
