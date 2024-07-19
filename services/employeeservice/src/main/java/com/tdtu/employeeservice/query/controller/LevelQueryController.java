package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.LevelResponseModel;
import com.tdtu.employeeservice.query.queries.level.GetAllLevelQuery;
import com.tdtu.employeeservice.query.queries.level.GetLevelQuery;

@RestController
@RequestMapping("/api/v1/level")
public class LevelQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public LevelResponseModel getLevelDetail(@PathVariable String id) {
		GetLevelQuery getLevelQuery = new GetLevelQuery();
		getLevelQuery.setId(id);

		LevelResponseModel LevelResponseModel = queryGateway
				.query(getLevelQuery, ResponseTypes.instanceOf(LevelResponseModel.class)).join();
		return LevelResponseModel;
	}

	@GetMapping
	public List<LevelResponseModel> getAllLevels() {
		GetAllLevelQuery getAllLevelsQuery = new GetAllLevelQuery();
		List<LevelResponseModel> lstEmp = queryGateway
				.query(getAllLevelsQuery, ResponseTypes.multipleInstancesOf(LevelResponseModel.class)).join();
		return lstEmp;
	}
}
