package com.tdtu.employeeservice.command.data.skill;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SkillService {
	@Autowired
	private SkillRepository repo;

	public String save(Skill e) throws InterruptedException, ExecutionException {
		return repo.save(e);
	}

	public String update(Skill e) throws InterruptedException, ExecutionException {
		return repo.update(e);
	}

	public String deleteById(String id) throws InterruptedException, ExecutionException {
		return repo.deleteById(id);
	}

	public Skill findById(String id) throws InterruptedException, ExecutionException {
		return repo.findById(id);
	}

	public List<Skill> findAll() throws InterruptedException, ExecutionException {
		return repo.findAll();
	}
}
