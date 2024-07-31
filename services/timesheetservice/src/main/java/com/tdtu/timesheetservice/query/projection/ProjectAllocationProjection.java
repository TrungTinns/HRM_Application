package com.tdtu.timesheetservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.projectAllocation.ProjectAllocation;
import com.tdtu.timesheetservice.command.data.projectAllocation.ProjectAllocationService;
import com.tdtu.timesheetservice.query.model.ProjectAllocationResponseModel;
import com.tdtu.timesheetservice.query.queries.entry.GetAllEntriesQuery;
import com.tdtu.timesheetservice.query.queries.projectAllocation.GetProjectAllocationQuery;


@Component
public class ProjectAllocationProjection {
	@Autowired
	private ProjectAllocationService ProjectAllocationService;

	@QueryHandler
	public ProjectAllocationResponseModel handle(GetProjectAllocationQuery getProjectAllocationQuery)
			throws InterruptedException, ExecutionException {
		ProjectAllocationResponseModel model = new ProjectAllocationResponseModel();
		Optional<ProjectAllocation> empOptional = Optional.ofNullable(ProjectAllocationService.findById(getProjectAllocationQuery.getId()));
		if (empOptional.isPresent()) {
			ProjectAllocation ProjectAllocation = empOptional.get();
			BeanUtils.copyProperties(ProjectAllocation, model);
		}
		return model;
	}

	@QueryHandler
	public List<ProjectAllocationResponseModel> handle(GetAllEntriesQuery getAllProjectAllocationsQuery)
			throws InterruptedException, ExecutionException {
		List<ProjectAllocation> lstEntity = ProjectAllocationService.findAll();
		List<ProjectAllocationResponseModel> lstEmp = new ArrayList<>();
		for (ProjectAllocation ProjectAllocation : lstEntity) {
			ProjectAllocationResponseModel model = new ProjectAllocationResponseModel();
			BeanUtils.copyProperties(ProjectAllocation, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
