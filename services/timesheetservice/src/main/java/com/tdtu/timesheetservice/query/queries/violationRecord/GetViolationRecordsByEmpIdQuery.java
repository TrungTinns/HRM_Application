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
public class GetViolationRecordsByEmpIdQuery {
	private String empId;
}
