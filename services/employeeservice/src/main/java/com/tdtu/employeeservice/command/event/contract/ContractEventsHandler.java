package com.tdtu.employeeservice.command.event.contract;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.contract.Contract;
import com.tdtu.employeeservice.command.data.contract.ContractService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ContractEventsHandler {
	@Autowired
	private ContractService contractService;

	@EventHandler
	public void on(ContractCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ContractCreatedEvent for: " + event.getId());
		Contract Contract = new Contract();
		BeanUtils.copyProperties(event, Contract);
		contractService.save(Contract);
		log.info("Contract created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(ContractUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling ContractUpdatedEvent for: " + event.getId());
		Optional<Contract> contractOptional = Optional.ofNullable(contractService.findById(event.getId()));
		if (contractOptional.isPresent()) {
			Contract emp = contractOptional.get();
			BeanUtils.copyProperties(event, emp);
			contractService.update(emp);
			log.info("Contract updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("Contract not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(ContractDeletedEvent event) {
		log.info("Handling ContractDeletedEvent for: " + event.getId());
		contractService.deleteById(event.getId());
		log.info("Contract deleted from Firestore: " + event.getId());
	}
}
