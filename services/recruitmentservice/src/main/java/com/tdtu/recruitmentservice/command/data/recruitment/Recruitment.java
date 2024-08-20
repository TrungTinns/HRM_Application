package com.tdtu.recruitmentservice.command.data.recruitment;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Recruitment {
	private String id;
	private String candidateId;
	private Date offeredDate;
}
