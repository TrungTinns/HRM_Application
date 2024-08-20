package com.tdtu.recruitmentservice.command.event.recruitment;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RecruitmentDeletedEvent {
	private String id;
}
