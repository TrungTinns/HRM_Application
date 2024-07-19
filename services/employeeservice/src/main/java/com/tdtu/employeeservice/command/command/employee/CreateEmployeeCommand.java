package com.tdtu.employeeservice.command.command.employee;

import java.util.Date;
import java.util.List;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

import com.google.cloud.firestore.DocumentReference;

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
public class CreateEmployeeCommand {

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
    private List<String> tags;
    private String managerId;
    private String coachId;
    private DocumentReference resume;
}
