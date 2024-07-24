package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.contract.Contract;
import com.tdtu.employeeservice.command.data.contract.ContractService;
import com.tdtu.employeeservice.query.model.ContractResponseModel;
import com.tdtu.employeeservice.query.queries.contract.GetAllContractsQuery;
import com.tdtu.employeeservice.query.queries.contract.GetContractQuery;

@Component
public class ContractProjection {
	@Autowired
	private ContractService empService;

	@QueryHandler
	public ContractResponseModel handle(GetContractQuery getContractQuery)
			throws InterruptedException, ExecutionException {
		ContractResponseModel model = new ContractResponseModel();
		Optional<Contract> empOptional = Optional.ofNullable(empService.findById(getContractQuery.getId()));
		if (empOptional.isPresent()) {
			Contract Contract = empOptional.get();
			BeanUtils.copyProperties(Contract, model);
		}
		return model;
	}

	@QueryHandler
	public List<ContractResponseModel> handle(GetAllContractsQuery getAllContractsQuery)
			throws InterruptedException, ExecutionException {
		List<Contract> lstEntity = empService.findAll();
		List<ContractResponseModel> lstEmp = new ArrayList<>();
		for (Contract Contract : lstEntity) {
			ContractResponseModel model = new ContractResponseModel();
			BeanUtils.copyProperties(Contract, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
