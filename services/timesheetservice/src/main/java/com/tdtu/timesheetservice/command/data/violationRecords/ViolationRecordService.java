package com.tdtu.timesheetservice.command.data.violationRecords;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


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
}
