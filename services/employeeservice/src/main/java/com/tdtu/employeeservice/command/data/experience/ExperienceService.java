package com.tdtu.employeeservice.command.data.experience;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.cloud.Timestamp;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.tdtu.employeeservice.command.data.skill.SkillRepository;

@Service
public class ExperienceService {

	@Autowired
	private ExperienceRepository repo;

	public String save(Experience e) throws InterruptedException, ExecutionException {
		return repo.save(e);
	}

	public String update(Experience e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Experience findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Experience> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
