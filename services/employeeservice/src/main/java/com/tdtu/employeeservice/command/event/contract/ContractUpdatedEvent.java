package com.tdtu.employeeservice.command.event.contract;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ContractUpdatedEvent {
	private String id;
	private String schedule;
	private String salaryStructure;
	private String contractType;
	private Double cost;
	private Date startDate;
	private Date endDate;
}
