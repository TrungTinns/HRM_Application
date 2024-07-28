package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.employee.Employee;
import com.tdtu.employeeservice.command.data.employee.EmployeeService;
import com.tdtu.employeeservice.query.model.EmployeeResponseModel;
import com.tdtu.employeeservice.query.queries.employee.GetAllEmployeesQuery;
import com.tdtu.employeeservice.query.queries.employee.GetEmployeeQuery;
import com.tdtu.employeeservice.query.queries.employee.GetEmployeesByDepartmentQuery;
import com.tdtu.employeeservice.query.queries.employee.GetEmployeesByRoleQuery;
import com.tdtu.employeeservice.query.queries.employee.GetManagersQuery;

@Component
public class EmployeeProjection {

	@Autowired
	private EmployeeService empService;

	@QueryHandler
	public EmployeeResponseModel handle(GetEmployeeQuery getEmployeeQuery)
			throws InterruptedException, ExecutionException {
		EmployeeResponseModel model = new EmployeeResponseModel();
		Optional<Employee> empOptional = Optional.ofNullable(empService.findById(getEmployeeQuery.getId()));
		if (empOptional.isPresent()) {
			Employee employee = empOptional.get();
			BeanUtils.copyProperties(employee, model);
		}
		return model;
	}

	@QueryHandler
	public List<EmployeeResponseModel> handle(GetAllEmployeesQuery getAllEmployeesQuery)
			throws InterruptedException, ExecutionException {
		List<Employee> lstEntity = empService.findAll();
		List<EmployeeResponseModel> lstEmp = new ArrayList<>();
		for (Employee employee : lstEntity) {
			EmployeeResponseModel model = new EmployeeResponseModel();
			BeanUtils.copyProperties(employee, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
	
	@QueryHandler
	public List<EmployeeResponseModel> handle(GetEmployeesByDepartmentQuery getEmployeesByDepartmentQuery)
			throws InterruptedException, ExecutionException {
		List<Employee> lstEntity = empService.findByDepartmentName(getEmployeesByDepartmentQuery.getDepartment());
		List<EmployeeResponseModel> lstEmp = new ArrayList<>();
		for (Employee employee : lstEntity) {
			EmployeeResponseModel model = new EmployeeResponseModel();
			BeanUtils.copyProperties(employee, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
	
	@QueryHandler
	public List<EmployeeResponseModel> handle(GetEmployeesByRoleQuery getEmployeesByRoleQuery)
			throws InterruptedException, ExecutionException {
		List<Employee> lstEntity = empService.findByRole(getEmployeesByRoleQuery.getRole());
		List<EmployeeResponseModel> lstEmp = new ArrayList<>();
		for (Employee employee : lstEntity) {
			EmployeeResponseModel model = new EmployeeResponseModel();
			BeanUtils.copyProperties(employee, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
	
	@QueryHandler
	public List<EmployeeResponseModel> handle(GetManagersQuery getManagersQuery)
			throws InterruptedException, ExecutionException {
		List<Employee> lstEntity = empService.findManagers();
		List<EmployeeResponseModel> lstEmp = new ArrayList<>();
		for (Employee employee : lstEntity) {
			EmployeeResponseModel model = new EmployeeResponseModel();
			BeanUtils.copyProperties(employee, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
