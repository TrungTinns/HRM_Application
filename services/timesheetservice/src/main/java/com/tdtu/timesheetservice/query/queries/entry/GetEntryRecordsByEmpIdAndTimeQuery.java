package com.tdtu.timesheetservice.query.queries.entry;

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
public class GetEntryRecordsByEmpIdAndTimeQuery {
	private String empId;
	private Integer month;
	private Integer year;
}
