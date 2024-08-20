package com.tdtu.employeeservice.query.model;

import java.util.Date;

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
public class ContractResponseModel {
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
