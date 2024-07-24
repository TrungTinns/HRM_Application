package com.tdtu.recruitmentservice.comand.data.candidate;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
@Service
public class CandidateService {

	@Autowired
	CandidateRepository repo;

	public String save(Candidate e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(Candidate e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Candidate findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Candidate> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
