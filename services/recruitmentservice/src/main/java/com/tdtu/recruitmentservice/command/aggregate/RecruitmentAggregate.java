package com.tdtu.recruitmentservice.command.aggregate;

import java.util.Date;

import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.spring.stereotype.Aggregate;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class RecruitmentAggregate {
	@AggregateIdentifier
	private String id;
	private String candidateId;
	private Date jobOfferDate; 
}
