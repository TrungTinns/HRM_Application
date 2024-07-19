package com.tdtu.employeeservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.employeeservice.command.data.resume.Resume;
import com.tdtu.employeeservice.command.data.resume.ResumeService;
import com.tdtu.employeeservice.query.model.ResumeResponseModel;
import com.tdtu.employeeservice.query.queries.resume.GetAllResumeQuery;
import com.tdtu.employeeservice.query.queries.resume.GetResumeQuery;

@Component
public class ResumeProjection {

	@Autowired
	private ResumeService resumeService;

	@QueryHandler
	public ResumeResponseModel handle(GetResumeQuery getResumeQuery) throws InterruptedException, ExecutionException {
		ResumeResponseModel model = new ResumeResponseModel();
		Optional<Resume> resumeOptional = Optional.ofNullable(resumeService.findById(getResumeQuery.getId()));
		if (resumeOptional.isPresent()) {
			Resume resume = resumeOptional.get();
			BeanUtils.copyProperties(resume, model);
		}
		return model;
	}

	@QueryHandler
	public List<ResumeResponseModel> handle(GetAllResumeQuery getAllResumesQuery)
			throws InterruptedException, ExecutionException {
		List<Resume> lstEntity = resumeService.findAll();
		List<ResumeResponseModel> lstResume = new ArrayList<>();
		for (Resume resume : lstEntity) {
			ResumeResponseModel model = new ResumeResponseModel();
			BeanUtils.copyProperties(resume, model);
			lstResume.add(model);
		}
		return lstResume;
	}
}
