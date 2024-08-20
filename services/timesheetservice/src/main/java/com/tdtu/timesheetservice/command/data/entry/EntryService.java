package com.tdtu.timesheetservice.command.data.entry;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;

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
	
	public List<Entry> findByEmpId(String id) throws InterruptedException, ExecutionException {
		return repo.findByEmpId(id);
	}
	
    public List<Entry> findByLockInDate(String date) throws InterruptedException, ExecutionException, ParseException {
        return repo.findByLockInDate(date);
    }
    
    public List<Entry> findByLockOutDate(String date)  throws InterruptedException, ExecutionException, ParseException {
        return repo.findByLockOutDate(date);
    }
    
    public Entry findByEmpIdAndClockInDate(String id, String date) throws InterruptedException, ExecutionException, ParseException {
		return repo.findByEmpIdAndClockInDate(id,date);
	}
    
    public Entry findByEmpIdAndClockOutDate(String id, String date) throws InterruptedException, ExecutionException, ParseException {
		return repo.findByEmpIdAndClockOutDate(id,date);
	}
  
    public List<Entry> findByEmpIdAndTime(String empId, Integer month, Integer year) throws InterruptedException, ExecutionException {
    	return repo.findByEmpIdAndTime(empId,month,year);
    }
}
