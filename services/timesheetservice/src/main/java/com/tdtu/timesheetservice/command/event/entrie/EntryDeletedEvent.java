package com.tdtu.timesheetservice.command.event.entrie;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EntryDeletedEvent {
	private String id;
}
