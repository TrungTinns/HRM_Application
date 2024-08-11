package com.tdtu.payrollservice;

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
public class PayrollResponseModel {
	private String empId;
	private int totalDay;
	private double totalOverTimes;
	private double penaltyAmount;
	private double totalOfficalHours;
	private double salary;
}
