package com.tdtu.timesheetservice.command.data.projectAllocation;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ProjectAllocationService {
	@Autowired
	ProjectAllocationRepository repo;

	public String save(ProjectAllocation e) throws InterruptedException, ExecutionException {
		return repo.save(e);
	}

	public String update(ProjectAllocation e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public ProjectAllocation findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<ProjectAllocation> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
