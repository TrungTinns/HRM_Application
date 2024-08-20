package com.tdtu.employeeservice.query.controller;

import java.util.List;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.employeeservice.query.model.ContractResponseModel;
import com.tdtu.employeeservice.query.queries.contract.GetAllContractsQuery;
import com.tdtu.employeeservice.query.queries.contract.GetContractQuery;

@RestController
@RequestMapping("/api/v1/employee/contract")
public class ContractQueryController {
	@Autowired
	private QueryGateway queryGateway;

	@GetMapping("/{id}")
	public ContractResponseModel getContractDetail(@PathVariable String id) {
		GetContractQuery getContractQuery = new GetContractQuery();
		getContractQuery.setId(id);

		ContractResponseModel empResponseModel = queryGateway
				.query(getContractQuery, ResponseTypes.instanceOf(ContractResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<ContractResponseModel> getAllContracts() {
		GetAllContractsQuery getAllContractsQuery = new GetAllContractsQuery();
		List<ContractResponseModel> lstEmp = queryGateway
				.query(getAllContractsQuery, ResponseTypes.multipleInstancesOf(ContractResponseModel.class)).join();
		return lstEmp;
	}
}
