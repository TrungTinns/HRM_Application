package com.tdtu.recruitmentservice.command.controller;

import java.util.UUID;

import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.beans.BeanUtils;
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
import com.tdtu.recruitmentservice.command.model.CandidateRequestModel;
import com.tdtu.recruitmentservice.command.model.RecruitmentRequestModel;
import com.tdtu.recruitmentservice.kafka.KafkaProducer;
import com.tdtu.recruitmentservice.query.controller.CandidateQueryController;
import com.tdtu.recruitmentservice.query.model.CandidateResponseModel;

@RestController
@RequestMapping("/api/v1/recruitment")
public class RecruitmentCommandController {
	@Autowired
	private CommandGateway commandGateway;
	
	
	@Autowired
    private KafkaProducer kafkaProducer;

	@Autowired
	private CandidateCommandController candidateCommandController;
	
	@Autowired
	private CandidateQueryController candidateQueryController;
	
	 @PostMapping
	 public String addRecruitment(@RequestBody RecruitmentRequestModel model) {
		CandidateResponseModel respModel = candidateQueryController.getCandidateDetail(model.getCandidateId());
		if (respModel.getId() == null) {
			return "Not found candidate with ID: " + model.getCandidateId();
	    }
		
		if (respModel.getIsOffered()) {
			return "Candidate with ID " + model.getCandidateId() + " was hired";
		}
		respModel.setIsOffered(true);
		
		CandidateRequestModel reqModel= new CandidateRequestModel();
		BeanUtils.copyProperties(respModel, reqModel);
		
		candidateCommandController.updateCandidate(reqModel);
		kafkaProducer.sendMessage(respModel);
			
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
}
