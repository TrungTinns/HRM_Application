package com.tdtu.employeeservice.command.model;

import java.util.Date;
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
public class EmployeeRequestModel {
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
    private List<String> tags;
    private String managerId;
    private String coachId;
    private ResumeRequestModel resume;
}
