package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.Employee;
import com.tdtu.employeeservice.command.data.EmployeeService;
import com.tdtu.employeeservice.query.model.EmployeeResponseModel;
import com.tdtu.employeeservice.query.queries.GetAllEmployeesQuery;
import com.tdtu.employeeservice.query.queries.GetEmployeeQuery;

@Component
public class EmployeeProjection {

	@Autowired
	private EmployeeService empService;
	
	
	@QueryHandler
	public EmployeeResponseModel handle(GetEmployeeQuery getEmployeeQuery) throws InterruptedException, ExecutionException {
		EmployeeResponseModel model = new EmployeeResponseModel();
		Optional<Employee> empOptional = Optional.ofNullable(empService.findById(getEmployeeQuery.getId()));
		if (empOptional.isPresent()) {
			BeanUtils.copyProperties(empOptional.get(), model);
		}
		return model;
	}
	
	@QueryHandler
	public List<EmployeeResponseModel> handle(GetAllEmployeesQuery getAllEmployeesQuery) throws InterruptedException, ExecutionException {
		List<Employee> lstEntity = empService.findAll();
		List<EmployeeResponseModel> lstEmp = new ArrayList<>();
		lstEntity.forEach(s -> {
			EmployeeResponseModel model = new EmployeeResponseModel();
			BeanUtils.copyProperties(s, model);
			lstEmp.add(model);
		});
		return lstEmp;
	}
}
