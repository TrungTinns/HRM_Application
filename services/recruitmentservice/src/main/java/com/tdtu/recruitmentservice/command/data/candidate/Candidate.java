package com.tdtu.recruitmentservice.command.data.candidate;

import java.util.Date;
import java.util.concurrent.ExecutionException;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.recruitmentservice.command.data.contract.Contract;
import com.tdtu.recruitmentservice.ulti.FirestoreUtil;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Candidate {
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
	private DocumentReference contract;
	
	public Contract getContract() throws InterruptedException, ExecutionException {
		return FirestoreUtil.getContract(contract);
	}
	
	public DocumentReference getContractRef() {
		return this.contract;
	}
	
}
