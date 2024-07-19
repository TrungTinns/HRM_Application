package com.tdtu.employeeservice.command.command.experience;

import java.util.List;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

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
public class UpdateExperienceCommand {

	@TargetAggregateIdentifier
	private String id;
	private List<DetailedExperience> experiences;
}
