package com.tdtu.recruitmentservice.command.command.candidate;

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
public class UpdateCandidateCommand {
	@TargetAggregateIdentifier
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
	
	public void setIsHired(boolean isHired) {
        this.isHired = isHired;
    }
    
    public boolean getIsHired() {
        return this.isHired;
    }
    
    public void setIsOffered(boolean isOffered) {
        this.isOffered = isOffered;
    }
    
    public boolean getIsOffered() {
        return this.isOffered;
    }
}
