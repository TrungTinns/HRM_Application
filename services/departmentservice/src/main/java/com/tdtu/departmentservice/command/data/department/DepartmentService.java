package com.tdtu.departmentservice.command.data.department;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DepartmentService {
	@Autowired
	DepartmentRepository repo;

	public String save(Department e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(Department e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Department findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Department> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
