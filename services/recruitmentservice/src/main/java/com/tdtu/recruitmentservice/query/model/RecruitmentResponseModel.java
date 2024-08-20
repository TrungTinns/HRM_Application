package com.tdtu.recruitmentservice.query.model;

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
public class RecruitmentResponseModel {
	private String id;
	private String candidateId;
	private Date offeredDate;
}
