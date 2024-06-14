package com.tdtu.employeeservice.command.event;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EmployeeUpdatedEvent {
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