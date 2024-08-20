package com.tdtu.timesheetservice.query.queries.entry;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

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
public class GetEntryByEmpIdAndClockInDateQuery {
	private String empId;
	private String clockInDate;
}
