package com.tdtu.employeeservice.command.command.employee;

import java.util.Date;
import java.util.List;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

import com.google.cloud.firestore.DocumentReference;

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
public class CreateEmployeeCommand {

    @TargetAggregateIdentifier
    private String id;
	private String name;
	private String role;
	private String mail;
	private String mobile;
	private String department;
	private String managerId;
	private boolean isManager;
	private String workLocation;
	private String schedule;
	private String salaryStructure;
	private String contractType;
	private Double cost;
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
}
