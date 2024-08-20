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
public class ContractCreatedEvent {
	private String id;
	private String referenceName;
	private String department;
	private String empName;
	private String position;
	private String status;
	private String schedule;
	private String schedulePay;
	private String salaryStructure;
	private String contractType;
	private Double cost;
	private String note;
	private String wageType;
	private Date startDate;
	private Date endDate;
}
