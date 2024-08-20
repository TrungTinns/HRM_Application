package com.tdtu.timesheetservice.command.command.timeOffRequest;

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
public class CreateTimeOffRequestCommand {
	@TargetAggregateIdentifier
	private String id;
	private String empId;
	private String leaveType;
	private Date applicationDate;
	private Date startDate;
	private Date endDate;
	private String status;
}
