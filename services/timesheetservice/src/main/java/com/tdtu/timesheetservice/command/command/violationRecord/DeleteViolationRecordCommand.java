package com.tdtu.timesheetservice.command.command.violationRecord;

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
public class DeleteViolationRecordCommand {
	@TargetAggregateIdentifier
	private String id;
}
