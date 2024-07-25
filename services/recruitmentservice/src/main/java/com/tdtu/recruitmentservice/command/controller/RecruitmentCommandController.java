package com.tdtu.recruitmentservice.command.controller;

import java.util.UUID;
import java.util.concurrent.ExecutionException;

import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.recruitmentservice.command.command.recruitment.CreateRecruitmentCommand;
import com.tdtu.recruitmentservice.command.command.recruitment.DeleteRecruitmentCommand;
import com.tdtu.recruitmentservice.command.command.recruitment.UpdateRecruitmentCommand;
import com.tdtu.recruitmentservice.command.data.candidate.Candidate;
import com.tdtu.recruitmentservice.command.data.candidate.CandidateService;
import com.tdtu.recruitmentservice.command.model.RecruitmentRequestModel;
import com.tdtu.recruitmentservice.kafka.KafkaProducer;

@RestController
@RequestMapping("/api/v1/recruitment")
public class RecruitmentCommandController {
	@Autowired
	private CommandGateway commandGateway;
	
	@Autowired
    private KafkaProducer kafkaProducer;
	
	@Autowired
	private CandidateService candidateService;
	
	 @PostMapping
	 public String addRecruitment(@RequestBody RecruitmentRequestModel model) {
		 CreateRecruitmentCommand command = new CreateRecruitmentCommand(
				 UUID.randomUUID().toString(),
		         model.getCandidateId(),
		         model.getOfferedDate()
				 );
		 commandGateway.sendAndWait(command);
	     return command.getId();
	 }


	@PutMapping
	public String updateRecruitment(@RequestBody RecruitmentRequestModel model) {
		UpdateRecruitmentCommand command = new UpdateRecruitmentCommand(
			model.getId(),
			model.getCandidateId(),
		    model.getOfferedDate()
		);
		commandGateway.sendAndWait(command);
		return model.getId().toString();
	}

	@DeleteMapping("/{id}")
	public String deleteRecruitment(@PathVariable String id) {
		commandGateway.sendAndWait(new DeleteRecruitmentCommand(id));
		return "Deleted an Recruitment with ID: " + id;
	}
	
	@PostMapping("/{candidateId}")
	public String offerCandidate(@PathVariable String candidateId) throws InterruptedException, ExecutionException {
		Candidate candidate = candidateService.findById(candidateId);
		if (candidate != null) {
			kafkaProducer.sendMessage(candidate);
        }
		return "Not found candidate with ID: " + candidateId;
	}
	
	
}
