package com.tdtu.recruitmentservice.comand.data.jobPosition;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JobPositionService {
	@Autowired
	JobPositionRepository repo;

	public String save(JobPosition e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(JobPosition e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public JobPosition findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<JobPosition> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
