package com.tdtu.employeeservice.command.data.experience;

import java.util.Date;

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
public class DetailedExperience {
	private String description;
	private String displayType;
	private Date startDate;
	private Date endDate;
	private String title;
	private String type;
}
