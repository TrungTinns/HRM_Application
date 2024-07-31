package com.tdtu.timesheetservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.timesheetservice.query.model.EntryResponseModel;
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.entry.GetEntryQuery;

@RestController
@RequestMapping("/api/v1/timesheet/entry")
public class EntryQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public EntryResponseModel getCandidateDetail(@PathVariable String id) {
		GetEntryQuery getCandidateQuery = new GetEntryQuery();
		getCandidateQuery.setId(id);

		EntryResponseModel empResponseModel = queryGateway
				.query(getCandidateQuery, ResponseTypes.instanceOf(EntryResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<EntryResponseModel> getAllCandidates() {
		GetAllEntriesQuery getAllCandidatesQuery = new GetAllEntriesQuery();
		List<EntryResponseModel> lstEmp = queryGateway
				.query(getAllCandidatesQuery, ResponseTypes.multipleInstancesOf(EntryResponseModel.class)).join();
		return lstEmp;
	}
}
