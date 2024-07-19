package com.tdtu.employeeservice.command.data.experience;

import java.util.List;

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
public class Experience {
	private String id;
	private List<DetailedExperience> experiences;

}

