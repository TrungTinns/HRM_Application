package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.DepartmentResponseModel;
import com.tdtu.employeeservice.query.queries.department.GetAllDepartmentsQuery;
import com.tdtu.employeeservice.query.queries.department.GetDepartmentQuery;

@RestController
@RequestMapping("/api/v1/department")
public class DepartmentQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public DepartmentResponseModel getDepartmentDetail(@PathVariable String id) {
		GetDepartmentQuery getDepartmentQuery = new GetDepartmentQuery();
		getDepartmentQuery.setId(id);

		DepartmentResponseModel empResponseModel = queryGateway
				.query(getDepartmentQuery, ResponseTypes.instanceOf(DepartmentResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<DepartmentResponseModel> getAllDepartments() {
		GetAllDepartmentsQuery getAllDepartmentsQuery = new GetAllDepartmentsQuery();
		List<DepartmentResponseModel> lstEmp = queryGateway
				.query(getAllDepartmentsQuery, ResponseTypes.multipleInstancesOf(DepartmentResponseModel.class)).join();
		return lstEmp;
	}
}
