package com.tdtu.employeeservice.query.model;

import java.util.List;

import com.tdtu.employeeservice.command.data.experience.DetailedExperience;

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
public class ExperienceResponseModel {
	private String id;
	private List<DetailedExperience> experiences;
}
