package com.tdtu.recruitmentservice.command.data.recruitment;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tdtu.recruitmentservice.query.model.CandidateResponseModel;

@Service
public class RecruitmentService {
	@Autowired
	RecruitmentRepository repo;

	public String save(Recruitment e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(Recruitment e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Recruitment findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Recruitment> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
	
	public void sendMessage(CandidateResponseModel candidate) {
		repo.sendMessage(candidate);
	}
}
