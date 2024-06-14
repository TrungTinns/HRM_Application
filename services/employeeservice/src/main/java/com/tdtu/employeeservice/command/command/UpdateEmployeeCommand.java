package com.tdtu.employeeservice.command.command;

import java.util.Date;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

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
public class UpdateEmployeeCommand {
	@TargetAggregateIdentifier
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private Date dateOfBirth;
    private String position;
    private Double salary;
    private String department;
    private String phone;
    private String img;
}
