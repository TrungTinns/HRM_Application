package com.tdtu.recruitmentservice.command.event.jobPosition;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class JobPositionDeletedEvent {
	private String id;
}
