package com.tdtu.recruitmentservice.command.data.recruitment;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecruitmentPositionService {
	@Autowired
	RecruitmentPositionRepository repo;

	public String save(RecruitmentPosition e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(RecruitmentPosition e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public RecruitmentPosition findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<RecruitmentPosition> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
