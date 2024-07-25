package com.tdtu.recruitmentservice.command.event.candidate;

import java.util.Date;
import java.util.List;

import com.google.cloud.firestore.DocumentReference;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CandidateCreatedEvent {
	private String id;
	private String name;
	private String subject;
	private String mail;
	private String phone;
	private String mobile;
	private String profileAddress;
	private String degree;
	private String interviewerId;
	private String recruiterId;
	private String appliedJob;
	private String department;
	private String source;
	private String medium;
	private Date availability;
	private int evaluation;
	private Double expectedSalary;
	private Double proposedSalary;
	private String applicationSummary;
	private String jobPositionId;
	private int stage;
	private boolean isHired;
	private boolean isOffered;
}
