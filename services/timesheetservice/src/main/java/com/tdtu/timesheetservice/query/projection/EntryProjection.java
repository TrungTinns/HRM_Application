package com.tdtu.timesheetservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.entrie.Entry;
import com.tdtu.timesheetservice.command.data.entrie.EntryService;
import com.tdtu.timesheetservice.query.model.EntryResponseModel;
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryQuery;


@Component
public class EntryProjection {
	@Autowired
	private EntryService EntryService;

	@QueryHandler
	public EntryResponseModel handle(GetEntryQuery getEntryQuery)
			throws InterruptedException, ExecutionException {
		EntryResponseModel model = new EntryResponseModel();
		Optional<Entry> empOptional = Optional.ofNullable(EntryService.findById(getEntryQuery.getId()));
		if (empOptional.isPresent()) {
			Entry Entry = empOptional.get();
			BeanUtils.copyProperties(Entry, model);
		}
		return model;
	}

	@QueryHandler
	public List<EntryResponseModel> handle(GetAllEntriesQuery getAllEntrysQuery)
			throws InterruptedException, ExecutionException {
		List<Entry> lstEntity = EntryService.findAll();
		List<EntryResponseModel> lstEmp = new ArrayList<>();
		for (Entry Entry : lstEntity) {
			EntryResponseModel model = new EntryResponseModel();
			BeanUtils.copyProperties(Entry, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
