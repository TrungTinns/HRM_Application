package com.tdtu.employeeservice.command.command.contract;

import java.util.Date;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class CreateContractCommand {
	@TargetAggregateIdentifier
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
