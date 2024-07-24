package com.tdtu.employeeservice.query.model;

import java.util.Date;

import com.tdtu.employeeservice.command.data.contract.Contract;

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
public class EmployeeResponseModel {
	private String id;
	private String name;
	private String role;
	private String mail;
	private String mobile;
	private String department;
	private String managerId;
	private boolean isManager;
	private String workLocation;
	private String personalAddress;
	private String personalMail;
	private String personalMobile;
	private String relativeName;
	private String relativeMobile;
	private String certification;
	private String school;
	private String maritalStatus;
	private int child;
	private String nationality;
	private String idNum;
	private String ssNum;
	private String passport;
	private String sex;
	private Date birthDate;
	private String birthPlace;
	private Contract contract;
}
