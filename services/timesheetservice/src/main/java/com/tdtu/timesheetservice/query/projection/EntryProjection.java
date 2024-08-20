package com.tdtu.timesheetservice.query.projection;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.entry.Entry;
import com.tdtu.timesheetservice.command.data.entry.EntryService;
import com.tdtu.timesheetservice.command.data.violationRecord.ViolationRecord;
import com.tdtu.timesheetservice.query.model.EntryResponseModel;
import com.tdtu.timesheetservice.query.model.ViolationRecordResponseModel;
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntriesByEmpIdQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByClockInDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByClockOutDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByEmpIdAndClockInDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryByEmpIdAndClockOutDateQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryRecordsByEmpIdAndTimeQuery;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetViolationRecordsByEmpIdAndTimeQuery;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Component
public class EntryProjection {
	@Autowired
	private EntryService EntryService;

	@QueryHandler
	public EntryResponseModel handle(GetEntryQuery query)
			throws InterruptedException, ExecutionException {
		EntryResponseModel model = new EntryResponseModel();
		Optional<Entry> empOptional = Optional.ofNullable(EntryService.findById(query.getId()));
		if (empOptional.isPresent()) {
			Entry Entry = empOptional.get();
			BeanUtils.copyProperties(Entry, model);
		}
		return model;
	}

	@QueryHandler
	public List<EntryResponseModel> handle(GetAllEntriesQuery query)
			throws InterruptedException, ExecutionException {
		List<Entry> lstEntity = EntryService.findAll();
		List<EntryResponseModel> lstEntry = new ArrayList<>();
		for (Entry Entry : lstEntity) {
			EntryResponseModel model = new EntryResponseModel();
			BeanUtils.copyProperties(Entry, model);
	        lstEntry.add(model);
		}
		return lstEntry;
	}
	
	@QueryHandler
	public List<EntryResponseModel> handle(GetEntriesByEmpIdQuery query)
			throws InterruptedException, ExecutionException {
		List<Entry> lstEntity = EntryService.findByEmpId(query.getEmpId());
		List<EntryResponseModel> lstEntry = new ArrayList<>();
		for (Entry Entry : lstEntity) {
			EntryResponseModel model = new EntryResponseModel();
			BeanUtils.copyProperties(Entry, model);
	        lstEntry.add(model);
		}
		return lstEntry;
	}
	
	@QueryHandler
	public EntryResponseModel handle(GetEntryByEmpIdAndClockInDateQuery query)
			throws InterruptedException, ExecutionException, ParseException {
		Entry entry = EntryService.findByEmpIdAndClockInDate(query.getEmpId(), query.getClockInDate());
		EntryResponseModel model = new EntryResponseModel();
		if (entry != null) {
			BeanUtils.copyProperties(entry, model);
		}
		return model;
	}
	
	@QueryHandler
	public EntryResponseModel handle(GetEntryByEmpIdAndClockOutDateQuery query)
			throws InterruptedException, ExecutionException, ParseException {
		Entry entry = EntryService.findByEmpIdAndClockOutDate(query.getEmpId(), query.getClockOutDate());
		EntryResponseModel model = new EntryResponseModel();
		if (entry != null) {
			BeanUtils.copyProperties(entry, model);
		}
		return model;
	}
	
	@QueryHandler
	public List<EntryResponseModel> handle(GetEntryByClockInDateQuery query)
			throws InterruptedException, ExecutionException, ParseException {
		List<Entry> lstEntity = EntryService.findByLockInDate(query.getClockInDate());
		List<EntryResponseModel> lstEntry = new ArrayList<>();
		for (Entry Entry : lstEntity) {
			EntryResponseModel model = new EntryResponseModel();
			BeanUtils.copyProperties(Entry, model);
	        lstEntry.add(model);
		}
		return lstEntry;
	}
	
	@QueryHandler
	public List<EntryResponseModel> handle(GetEntryByClockOutDateQuery query)
			throws InterruptedException, ExecutionException, ParseException {
		List<Entry> lstEntity = EntryService.findByLockOutDate(query.getClockOutDate());
		List<EntryResponseModel> lstEntry = new ArrayList<>();
		for (Entry Entry : lstEntity) {
			EntryResponseModel model = new EntryResponseModel();
			BeanUtils.copyProperties(Entry, model);
	        lstEntry.add(model);
		}
		return lstEntry;
	}
	
	@QueryHandler
	public List<EntryResponseModel> handle(GetEntryRecordsByEmpIdAndTimeQuery query)
			throws InterruptedException, ExecutionException {
		List<Entry> lstRecord = EntryService.findByEmpIdAndTime(query.getEmpId(), query.getMonth(), query.getYear());
		List<EntryResponseModel> lst = new ArrayList<>();
		for (Entry record : lstRecord) {
			EntryResponseModel model = new EntryResponseModel();
			BeanUtils.copyProperties(record, model);
			lst.add(model);
		}
		return lst;
	}
}
