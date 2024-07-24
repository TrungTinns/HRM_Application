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
	private String schedule;
	private String salaryStructure;
	private String contractType;
	private Double cost;
	private Date startDate;
	private Date endDate;
}
