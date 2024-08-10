package com.tdtu.timesheetservice.command.data.timeOffRequest;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tdtu.timesheetservice.command.data.violationRecord.ViolationRecord;

@Service
public class TimeOffRequestService {
	@Autowired
	TimeOffRequestRepository repo;

	public String save(TimeOffRequest e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(TimeOffRequest e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public TimeOffRequest findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<TimeOffRequest> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
	
	public List<TimeOffRequest> findByEmpId(String empId) throws InterruptedException, ExecutionException {
		return repo.findByEmpId(empId);
	}
	
	public List<TimeOffRequest> findByEmpIdAndTime(String empId, Integer month, Integer year) throws InterruptedException, ExecutionException {
        return repo.findByEmpIdAndTime(empId, month, year);
	}
}
