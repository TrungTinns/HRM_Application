package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.EmployeeResponseModel;
import com.tdtu.employeeservice.query.queries.employee.GetAllEmployeesQuery;
import com.tdtu.employeeservice.query.queries.employee.GetEmployeeQuery;
import com.tdtu.employeeservice.query.queries.employee.GetEmployeesByDepartmentQuery;
import com.tdtu.employeeservice.query.queries.employee.GetEmployeesByRoleQuery;
import com.tdtu.employeeservice.query.queries.employee.GetManagersQuery;

@RestController
@RequestMapping("/api/v1/employee")
public class EmployeeQueryController {

	@Autowired
	private QueryGateway queryGateway;
	

	@GetMapping("/{id}")
	public EmployeeResponseModel getEmployeeDetail(@PathVariable String id) {
		GetEmployeeQuery getEmployeeQuery = new GetEmployeeQuery();
		getEmployeeQuery.setId(id);

		EmployeeResponseModel empResponseModel = queryGateway
				.query(getEmployeeQuery, ResponseTypes.instanceOf(EmployeeResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<EmployeeResponseModel> getAllEmployees() {
		GetAllEmployeesQuery getAllEmployeesQuery = new GetAllEmployeesQuery();
		List<EmployeeResponseModel> lstEmp = queryGateway
				.query(getAllEmployeesQuery, ResponseTypes.multipleInstancesOf(EmployeeResponseModel.class)).join();
		return lstEmp;
	}
	
	@GetMapping(params = "department")
	public List<EmployeeResponseModel> getEmployeesByDepartment(@RequestParam String department) {
		 GetEmployeesByDepartmentQuery getEmployeesByDepartmentQuery = new GetEmployeesByDepartmentQuery(department);
	     List<EmployeeResponseModel> lstEmp = queryGateway.query(getEmployeesByDepartmentQuery, ResponseTypes.multipleInstancesOf(EmployeeResponseModel.class)).join();
	        return lstEmp;
	}
	
	@GetMapping(params = "role")
	public List<EmployeeResponseModel> getEmployeesByPosition(@RequestParam String role) {
		 GetEmployeesByRoleQuery getEmployeesByDepartmentQuery = new GetEmployeesByRoleQuery(role);
	     List<EmployeeResponseModel> lstEmp = queryGateway.query(getEmployeesByDepartmentQuery, ResponseTypes.multipleInstancesOf(EmployeeResponseModel.class)).join();
	        return lstEmp;
	}
	
	@GetMapping("/managers")
	public List<EmployeeResponseModel> getManagers() {
		 GetManagersQuery getManagersQuery = new GetManagersQuery();
	     List<EmployeeResponseModel> lstEmp = queryGateway.query(getManagersQuery, ResponseTypes.multipleInstancesOf(EmployeeResponseModel.class)).join();
	     return lstEmp;
	}
}
