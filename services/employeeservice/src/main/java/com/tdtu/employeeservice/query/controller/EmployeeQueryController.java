package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.EmployeeResponseModel;
import com.tdtu.employeeservice.query.queries.GetAllEmployeesQuery;
import com.tdtu.employeeservice.query.queries.GetEmployeeQuery;

@RestController
@RequestMapping("/api/v1/employee")
public class EmployeeQueryController {

	@Autowired
	private QueryGateway queryGateway;
	
	@GetMapping("/{id}")
	public EmployeeResponseModel getEmployeeDetail(@PathVariable String id) {
		GetEmployeeQuery getEmployeeQuery = new GetEmployeeQuery();
		getEmployeeQuery.setId(id);
		
		EmployeeResponseModel empResponseModel = 
				queryGateway.query(getEmployeeQuery,
						ResponseTypes.instanceOf(EmployeeResponseModel.class))
						.join();
		return empResponseModel;
	}
	
	@GetMapping
	public List<EmployeeResponseModel> getAllEmployees() {
		GetAllEmployeesQuery getAllEmployeesQuery = new GetAllEmployeesQuery();
		List<EmployeeResponseModel> lstEmp = queryGateway.query(
				getAllEmployeesQuery,
				ResponseTypes.multipleInstancesOf(EmployeeResponseModel.class))
				.join();
		return lstEmp;
	}
}
