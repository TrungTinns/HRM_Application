package com.tdtu.employeeservice.command.data.skill;

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

import lombok.extern.slf4j.Slf4j;

@Repository
public class SkillRepository {
    private static final String COLLECTION_NAME = "Skills";

    public String save(Skill e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();

        Map<String, Object> skillMap = new HashMap<>();
        skillMap.put("skillType", e.getSkillType());
        skillMap.put("name", e.getName());
        skillMap.put("levels", e.getLevelsRef());

        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);
        return collection.get().getUpdateTime().toString();
    }

    public String update(Skill e) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> skillMap = new HashMap<>();
        skillMap.put("skillType", e.getSkillType());
        skillMap.put("name", e.getName());
        skillMap.put("levels", e.getLevelsRef());
        ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

        return collection.get().getUpdateTime().toString();
    }

    public String deleteById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();
        return "Sucessfully Delete " + id;
    }

    public Skill findById(String id) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
        ApiFuture<DocumentSnapshot> future = reference.get();
        DocumentSnapshot document = future.get();

        Skill e;
        if (document.exists()) {
            e = document.toObject(Skill.class);
            e.setId(document.getId());
            return e;
        }
        return null;
    }

    public List<Skill> findAll() throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

        List<Skill> skillList = new ArrayList<>();
        for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
            Skill skill = document.toObject(Skill.class);
            skill.setId(document.getId());
            skillList.add(skill);
        }
        return skillList;
    }
}
