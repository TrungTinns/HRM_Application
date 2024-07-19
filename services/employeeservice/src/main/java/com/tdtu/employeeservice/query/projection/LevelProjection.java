package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.level.Level;
import com.tdtu.employeeservice.command.data.level.LevelService;
import com.tdtu.employeeservice.query.model.LevelResponseModel;
import com.tdtu.employeeservice.query.queries.level.GetAllLevelQuery;
import com.tdtu.employeeservice.query.queries.level.GetLevelQuery;

@Component
public class LevelProjection {
	@Autowired
	private LevelService levelService;

	@QueryHandler
	public LevelResponseModel handle(GetLevelQuery getLevelQuery)
			throws InterruptedException, ExecutionException {
		LevelResponseModel model = new LevelResponseModel();
		Optional<Level> empOptional = Optional.ofNullable(levelService.findById(getLevelQuery.getId()));
		if (empOptional.isPresent()) {
			Level Level = empOptional.get();
			BeanUtils.copyProperties(Level, model);
		}
		return model;
	}

	@QueryHandler
	public List<LevelResponseModel> handle(GetAllLevelQuery getAllLevelsQuery)
			throws InterruptedException, ExecutionException {
		List<Level> lstEntity = levelService.findAll();
		List<LevelResponseModel> lstEmp = new ArrayList<>();
		for (Level Level : lstEntity) {
			LevelResponseModel model = new LevelResponseModel();
			BeanUtils.copyProperties(Level, model);
			lstEmp.add(model);
		}
		return lstEmp;
	}
}
