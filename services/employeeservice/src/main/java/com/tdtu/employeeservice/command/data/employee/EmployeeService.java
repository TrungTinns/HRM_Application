package com.tdtu.employeeservice.command.data.employee;

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
}
