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
public class EntryResponseModel {
	private String id;
	private String empId;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "EEE MMM dd HH:mm:ss zzz yyyy", timezone = "ICT")
	private Date clockIn;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "EEE MMM dd HH:mm:ss zzz yyyy", timezone = "ICT")
	private Date clockOut;
	private Date breakStart;
	private Date breakEnd;
	private Double overTimeHours;
}
