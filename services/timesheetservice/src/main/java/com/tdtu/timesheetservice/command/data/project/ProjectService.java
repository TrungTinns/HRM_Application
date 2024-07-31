package com.tdtu.timesheetservice.command.data.project;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectService {
	@Autowired
	ProjectRepository repo;

	public String save(Project e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(Project e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Project findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Project> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
