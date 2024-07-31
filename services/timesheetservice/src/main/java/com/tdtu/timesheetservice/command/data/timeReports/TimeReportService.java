package com.tdtu.timesheetservice.command.data.timeReports;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class TimeReportService {
	@Autowired
	TimeReportRepository repo;

	public String save(TimeReport e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(TimeReport e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public TimeReport findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<TimeReport> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
