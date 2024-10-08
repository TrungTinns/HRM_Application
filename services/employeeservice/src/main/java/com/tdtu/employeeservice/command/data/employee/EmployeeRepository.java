package com.tdtu.employeeservice.command.data.employee;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;

import lombok.extern.slf4j.Slf4j;

@Repository
public class EmployeeRepository {
	
	private static final String COLLECTION_NAME = "Employee";
	
	public String save(Employee e) throws InterruptedException, ExecutionException {		
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
		
	    skillMap.put("name", e.getName());
	    skillMap.put("role", e.getRole());
	    skillMap.put("mail", e.getMail());
	    skillMap.put("mobile", e.getMobile());
	    skillMap.put("department", e.getDepartment());
	    skillMap.put("managerId", e.getManagerId());
	    skillMap.put("isManager", e.getIsManager());
	    skillMap.put("workLocation", e.getWorkLocation());
	    skillMap.put("personalAddress", e.getPersonalAddress());
	    skillMap.put("personalMail", e.getPersonalMail());
	    skillMap.put("personalMobile", e.getPersonalMobile());
	    skillMap.put("relativeName", e.getRelativeName());
	    skillMap.put("relativeMobile", e.getRelativeMobile());
	    skillMap.put("certification", e.getCertification());
	    skillMap.put("school", e.getSchool());
	    skillMap.put("maritalStatus", e.getMaritalStatus());
	    skillMap.put("child", e.getChild());
	    skillMap.put("nationality", e.getNationality());
	    skillMap.put("idNum", e.getIdNum());
	    skillMap.put("ssNum", e.getSsNum());
	    skillMap.put("passport", e.getPassport());
	    skillMap.put("sex", e.getSex());
	    skillMap.put("birthDate", e.getBirthDate());
	    skillMap.put("birthPlace", e.getBirthPlace());
	    skillMap.put("contract", e.getContractRef());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String update(Employee e) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		Map<String, Object> skillMap = new HashMap<>();
	    skillMap.put("name", e.getName());
	    skillMap.put("role", e.getRole());
	    skillMap.put("mail", e.getMail());
	    skillMap.put("mobile", e.getMobile());
	    skillMap.put("department", e.getDepartment());
	    skillMap.put("managerId", e.getManagerId());
	    skillMap.put("isManager", e.getIsManager());
	    skillMap.put("workLocation", e.getWorkLocation());;
	    skillMap.put("personalAddress", e.getPersonalAddress());
	    skillMap.put("personalMail", e.getPersonalMail());
	    skillMap.put("personalMobile", e.getPersonalMobile());
	    skillMap.put("relativeName", e.getRelativeName());
	    skillMap.put("relativeMobile", e.getRelativeMobile());
	    skillMap.put("certification", e.getCertification());
	    skillMap.put("school", e.getSchool());
	    skillMap.put("maritalStatus", e.getMaritalStatus());
	    skillMap.put("child", e.getChild());
	    skillMap.put("nationality", e.getNationality());
	    skillMap.put("idNum", e.getIdNum());
	    skillMap.put("ssNum", e.getSsNum());
	    skillMap.put("passport", e.getPassport());
	    skillMap.put("sex", e.getSex());
	    skillMap.put("birthDate", e.getBirthDate());
	    skillMap.put("birthPlace", e.getBirthPlace());
	    skillMap.put("contract", e.getContractRef());
		ApiFuture<WriteResult> collection = db.collection(COLLECTION_NAME).document(e.getId()).set(skillMap);

		return collection.get().getUpdateTime().toString();
	}

	public String deleteById(String id) {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection(COLLECTION_NAME).document(id).delete();

		return "Sucessfully Delete " + id;
	}

	public Employee findById(String id) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference reference = db.collection(COLLECTION_NAME).document(id);
		ApiFuture<DocumentSnapshot> future = reference.get();
		DocumentSnapshot document = future.get();

		Employee e;
		if (document.exists()) {
			e = document.toObject(Employee.class);
			e.setId(document.getId());
			return e;
		}
		return null;
	}

	public List<Employee> findAll() throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).get();

		List<Employee> employeeList = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Employee e = document.toObject(Employee.class);
			e.setId(document.getId());
			employeeList.add(e);
		}

		return employeeList;
	}
	
	public List<Employee> findByDepartmentName(String departmentName) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).whereEqualTo("department",departmentName).get();

		List<Employee> employeeList = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Employee e = document.toObject(Employee.class);
			e.setId(document.getId());
			employeeList.add(e);
		}

		return employeeList;
	}
	
	public List<Employee> findByRole(String role) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).whereEqualTo("role",role).get();

		List<Employee> employeeList = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Employee e = document.toObject(Employee.class);
			e.setId(document.getId());
			employeeList.add(e);
		}

		return employeeList;
	}
	
	public List<Employee> findManagers() throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> querySnapshot = db.collection(COLLECTION_NAME).whereEqualTo("isManager",true).get();

		List<Employee> employeeList = new ArrayList<>();
		for (DocumentSnapshot document : querySnapshot.get().getDocuments()) {
			Employee e = document.toObject(Employee.class);
			e.setId(document.getId());
			employeeList.add(e);
		}

		return employeeList;
	}
}

