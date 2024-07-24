package com.tdtu.recruitmentservice.comand.data.contract;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractService {

	@Autowired
	ContractRepository repo;

	public String save(Contract e) throws InterruptedException, ExecutionException {	
		return repo.save(e);
	}

	public String update(Contract e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) {
		return repo.deleteById(id);
	}

	public Contract findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Contract> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
