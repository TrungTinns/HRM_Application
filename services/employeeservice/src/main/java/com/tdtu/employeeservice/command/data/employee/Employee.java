package com.tdtu.employeeservice.command.data.employee;

import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutionException;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.employeeservice.command.data.resume.Resume;
import com.tdtu.employeeservice.util.FirestoreUtil;

import jakarta.persistence.Column;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Employee {
	private String id;

	@NotBlank(message = "First name is mandatory")
	@Size(max = 50)
	private String firstName;

	@NotBlank(message = "Last name is mandatory")
	@Size(max = 50)
	private String lastName;

	@NotBlank(message = "Email is mandatory")
	@Column(unique = true)
	private String email;

	@NotNull(message = "Date of birth is mandatory")
	@Temporal(TemporalType.DATE)
	private Date dateOfBirth;

	@NotBlank(message = "Position is mandatory")
	@Size(max = 100)
	private String position;

	@NotNull(message = "Salary is mandatory")
	private Double salary;

	@NotBlank(message = "Department is mandatory")
	@Size(max = 100)
	private String department;

	@NotBlank(message = "Phone is mandatory")
	@Pattern(regexp = "^\\+?[0-9. ()-]{7,25}$", message = "Phone number is invalid")
	private String phone;

	private String img;

	private List<String> tags;

	private String managerId;

	private String coachId;

	private DocumentReference resume;

	public Resume getResume() throws InterruptedException, ExecutionException{
		return FirestoreUtil.getResume(resume);
	}
	
	public DocumentReference getResumeRef() {
		return this.resume;
	}

}
