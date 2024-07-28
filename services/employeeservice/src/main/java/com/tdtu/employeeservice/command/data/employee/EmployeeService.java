package com.tdtu.employeeservice.command.data.employee;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

	@Autowired
	EmployeeRepository repo;

	public String save(Employee e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(Employee e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Employee findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Employee> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
	
	public List<Employee> findByDepartmentName(String departmentName) throws InterruptedException, ExecutionException {
		return repo.findByDepartmentName(departmentName);
	}
	
	public List<Employee> findByRole(String role) throws InterruptedException, ExecutionException {
		return repo.findByRole(role);
	}

	public List<Employee> findManagers() throws InterruptedException, ExecutionException {
		return repo.findManagers();
	}
}
