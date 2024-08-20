package com.tdtu.timesheetservice.command.aggregate;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.timesheetservice.command.command.projectAllocation.CreateProjectAllocationCommand;
import com.tdtu.timesheetservice.command.command.projectAllocation.DeleteProjectAllocationCommand;
import com.tdtu.timesheetservice.command.command.projectAllocation.UpdateProjectAllocationCommand;
import com.tdtu.timesheetservice.command.event.projectAllocation.ProjectAllocationCreatedEvent;
import com.tdtu.timesheetservice.command.event.projectAllocation.ProjectAllocationDeletedEvent;
import com.tdtu.timesheetservice.command.event.projectAllocation.ProjectAllocationUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class ProjectAllocationAggregate {
	@AggregateIdentifier
	private String id;
	private String empId;
	private String projectId;
	private String taskId;
	private Double timeSpent;

	
	// CREATE EVENT
	@CommandHandler
	public ProjectAllocationAggregate(CreateProjectAllocationCommand createProjectAllocationCommand) {
		ProjectAllocationCreatedEvent ProjectAllocationCreatedEvent = new ProjectAllocationCreatedEvent();
		BeanUtils.copyProperties(createProjectAllocationCommand, ProjectAllocationCreatedEvent);
		AggregateLifecycle.apply(ProjectAllocationCreatedEvent);
	}

	@EventSourcingHandler
	public void on(ProjectAllocationCreatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.projectId = event.getProjectId();
        this.taskId = event.getTaskId();
        this.timeSpent = event.getTimeSpent();
	}

	// UPDATED EVENT
	@CommandHandler
	public void handle(UpdateProjectAllocationCommand updateProjectAllocationCommand) {
		ProjectAllocationUpdatedEvent ProjectAllocationUpdatedEvent = new ProjectAllocationUpdatedEvent();
		BeanUtils.copyProperties(updateProjectAllocationCommand, ProjectAllocationUpdatedEvent);
		AggregateLifecycle.apply(ProjectAllocationUpdatedEvent);
	}

	@EventSourcingHandler
	public void on(ProjectAllocationUpdatedEvent event) {
		this.id = event.getId();
        this.empId = event.getEmpId();
        this.projectId = event.getProjectId();
        this.taskId = event.getTaskId();
        this.timeSpent = event.getTimeSpent();
	}

	// DELETE EVENT
	@CommandHandler
	public void handle(DeleteProjectAllocationCommand deleteProjectAllocationCommand) {
		ProjectAllocationDeletedEvent ProjectAllocationDeletedEvent = new ProjectAllocationDeletedEvent();
		BeanUtils.copyProperties(deleteProjectAllocationCommand, ProjectAllocationDeletedEvent);
		AggregateLifecycle.apply(ProjectAllocationDeletedEvent);
	}

	@EventSourcingHandler
	public void on(ProjectAllocationDeletedEvent event) {
		this.id = event.getId();
	}
}
