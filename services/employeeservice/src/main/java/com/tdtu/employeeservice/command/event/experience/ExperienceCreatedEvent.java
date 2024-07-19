package com.tdtu.employeeservice.command.event.experience;

import java.util.List;

import com.tdtu.employeeservice.command.data.experience.DetailedExperience;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ExperienceCreatedEvent {
	private String id;
	private List<DetailedExperience> experiences;
}
