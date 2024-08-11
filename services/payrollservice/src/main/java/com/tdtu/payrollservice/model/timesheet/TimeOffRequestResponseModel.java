package com.tdtu.payrollservice.model.timesheet;

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
public class TimeOffRequestResponseModel {
	private String id;
	private String empId;
	private String leaveType;
	 @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "EEE MMM dd HH:mm:ss zzz yyyy", timezone = "ICT")
	private Date applicationDate;
	 @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "EEE MMM dd HH:mm:ss zzz yyyy", timezone = "ICT")
	private Date startDate;
	private Date endDate;
	private String status;
}
