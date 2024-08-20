package com.tdtu.timesheetservice.command.data.violationRecord;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;


@Service
public class ViolationRecordService {
	@Autowired
	ViolationRecordRepository repo;

	public String save(ViolationRecord e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(ViolationRecord e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public ViolationRecord findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<ViolationRecord> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
	
	public List<ViolationRecord> findByEmpId(String empId) throws InterruptedException, ExecutionException {
		return repo.findByEmpId(empId);
	}
	
	public List<ViolationRecord> findByEmpIdAndTime(String empId, Integer month, Integer year) throws InterruptedException, ExecutionException {
        return repo.findByEmpIdAndTime(empId, month, year);
	}
}
