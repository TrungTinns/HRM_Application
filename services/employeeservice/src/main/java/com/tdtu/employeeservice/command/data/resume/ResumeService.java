package com.tdtu.employeeservice.command.data.resume;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResumeService {
	@Autowired
	ResumeRepository repo;

	public String save(Resume e) throws InterruptedException, ExecutionException {
		return repo.save(e);
	}

	public String update(Resume e) throws InterruptedException, ExecutionException {
		return repo.update(e);	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Resume findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Resume> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
