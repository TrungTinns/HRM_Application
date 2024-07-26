package com.tdtu.recruitmentservice.query.controller;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.axonframework.messaging.responsetypes.ResponseTypes;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.recruitmentservice.command.data.candidate.Candidate;
import com.tdtu.recruitmentservice.command.data.candidate.CandidateService;
import com.tdtu.recruitmentservice.kafka.KafkaProducer;
import com.tdtu.recruitmentservice.query.model.RecruitmentResponseModel;
import com.tdtu.recruitmentservice.query.queries.recruitment.GetAllRecruitmentsQuery;
import com.tdtu.recruitmentservice.query.queries.recruitment.GetRecruitmentQuery;


@RestController
@RequestMapping("/api/v1/recruitment")
public class RecruitmentQueryController {
	@Autowired
	private QueryGateway queryGateway;
	
	@Autowired
    private KafkaProducer kafkaProducer;

	@Autowired
	private CandidateService candidateService;

	@GetMapping("/{id}")
	public RecruitmentResponseModel getRecruitmentDetail(@PathVariable String id) {
		GetRecruitmentQuery getRecruitmentQuery = new GetRecruitmentQuery();
		getRecruitmentQuery.setId(id);

		RecruitmentResponseModel empResponseModel = queryGateway
				.query(getRecruitmentQuery, ResponseTypes.instanceOf(RecruitmentResponseModel.class)).join();
		return empResponseModel;
	}

	@GetMapping
	public List<RecruitmentResponseModel> getAllRecruitments() {
		GetAllRecruitmentsQuery getAllRecruitmentsQuery = new GetAllRecruitmentsQuery();
		List<RecruitmentResponseModel> lstEmp = queryGateway
				.query(getAllRecruitmentsQuery, ResponseTypes.multipleInstancesOf(RecruitmentResponseModel.class)).join();
		return lstEmp;
	}
	
	@GetMapping("/offered/{candidateId}")
	public String offerCandidate(@PathVariable String candidateId) throws InterruptedException, ExecutionException {
		Candidate candidate = candidateService.findById(candidateId);
		if (candidate != null) {
			kafkaProducer.sendMessage(candidate);
			return "Candidate offered with ID: " + candidateId;
        }
		return "Not found candidate with ID: " + candidateId;
	}
}
