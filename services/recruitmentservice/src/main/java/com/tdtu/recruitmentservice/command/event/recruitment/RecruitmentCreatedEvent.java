package com.tdtu.recruitmentservice.command.event.recruitment;

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
public class RecruitmentCreatedEvent {
	private String id;
	private String candidateId;
	private Date offeredDate;
}
