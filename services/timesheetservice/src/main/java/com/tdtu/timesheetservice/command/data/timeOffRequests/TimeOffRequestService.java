package com.tdtu.timesheetservice.command.data.timeOffRequests;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
