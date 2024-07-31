package com.tdtu.timesheetservice.command.data.entries;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EntryService {
	@Autowired
	EntryRepository repo;

	public String save(Entry e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(Entry e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Entry findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Entry> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
