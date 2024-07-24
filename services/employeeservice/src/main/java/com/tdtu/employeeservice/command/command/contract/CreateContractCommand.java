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
	private String schedule;
	private String salaryStructure;
	private String contractType;
	private Double cost;
	private Date startDate;
	private Date endDate;

}
