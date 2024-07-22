package com.tdtu.departmentservice.command.event.department;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.eventhandling.EventHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.departmentservice.command.data.department.Department;
import com.tdtu.departmentservice.command.data.department.DepartmentService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class DepartmentEventsHandler {
	@Autowired
	private DepartmentService departmentService;

	@EventHandler
	public void on(DepartmentCreatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling DepartmentCreatedEvent for: " + event.getId());
		Department department = new Department();
		BeanUtils.copyProperties(event, department);
		departmentService.save(department);
		log.info("Department created and saved to Firestore: " + event.getId());
	}

	@EventHandler
	public void on(DepartmentUpdatedEvent event) throws InterruptedException, ExecutionException {
		log.info("Handling DepartmentUpdatedEvent for: " + event.getId());
		Optional<Department> empOptional = Optional.ofNullable(departmentService.findById(event.getId()));
		if (empOptional.isPresent()) {
			Department emp = empOptional.get();
			BeanUtils.copyProperties(event, emp);
			departmentService.update(emp);
			log.info("Department updated and saved to Firestore: " + event.getId());
		} else {
			throw new IllegalArgumentException("Department not found for update: " + event.getId());
		}
	}

	@EventHandler
	public void on(DepartmentDeletedEvent event) {
		log.info("Handling DepartmentDeletedEvent for: " + event.getId());
		departmentService.deleteById(event.getId());
		log.info("Department deleted from Firestore: " + event.getId());
	}
}
