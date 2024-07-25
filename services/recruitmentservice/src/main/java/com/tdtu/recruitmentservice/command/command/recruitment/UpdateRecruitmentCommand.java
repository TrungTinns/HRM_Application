package com.tdtu.recruitmentservice.command.command.recruitment;

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
public class UpdateRecruitmentCommand {
	@TargetAggregateIdentifier
	private String id;
	private String candidateId;
	private Date offeredDate;
}
