package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.department.Department;
import com.tdtu.employeeservice.command.data.department.DepartmentService;
import com.tdtu.employeeservice.query.model.DepartmentResponseModel;
import com.tdtu.employeeservice.query.queries.department.GetAllDepartmentsQuery;
import com.tdtu.employeeservice.query.queries.department.GetDepartmentQuery;


@Component
public class DepartmentProjection {
	@Autowired
	private DepartmentService empService;

	@QueryHandler
	public DepartmentResponseModel handle(GetDepartmentQuery getDepartmentQuery)
			throws InterruptedException, ExecutionException {
		DepartmentResponseModel model = new DepartmentResponseModel();
		Optional<Department> empOptional = Optional.ofNullable(empService.findById(getDepartmentQuery.getId()));
		if (empOptional.isPresent()) {
			Department Department = empOptional.get();
			BeanUtils.copyProperties(Department, model);
		}
		return model;
	}

	@QueryHandler
	public List<DepartmentResponseModel> handle(GetAllDepartmentsQuery getAllDepartmentsQuery)
			throws InterruptedException, ExecutionException {
		List<Department> lstEntity = empService.findAll();
		List<DepartmentResponseModel> lstEmp = new ArrayList<>();
		for (Department Department : lstEntity) {
			DepartmentResponseModel model = new DepartmentResponseModel();
			BeanUtils.copyProperties(Department, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
