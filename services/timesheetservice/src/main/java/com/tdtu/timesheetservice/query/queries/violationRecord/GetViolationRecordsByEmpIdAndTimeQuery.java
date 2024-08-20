package com.tdtu.timesheetservice.query.queries.violationRecord;

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
public class GetViolationRecordsByEmpIdAndTimeQuery {
	private String empId;
	private Integer month;
	private Integer year;
}
