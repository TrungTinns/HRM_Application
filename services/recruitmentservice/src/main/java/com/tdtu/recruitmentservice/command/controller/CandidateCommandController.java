package com.tdtu.recruitmentservice.command.controller;

import java.util.UUID;

import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tdtu.recruitmentservice.command.command.candidate.CreateCandidateCommand;
import com.tdtu.recruitmentservice.command.command.candidate.DeleteCandidateCommand;
import com.tdtu.recruitmentservice.command.command.candidate.UpdateCandidateCommand;
import com.tdtu.recruitmentservice.command.model.CandidateRequestModel;

@RestController
@RequestMapping("/api/v1/recruitment/candidate")
public class CandidateCommandController {
    @Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addCandidate(@RequestBody CandidateRequestModel model) {
        CreateCandidateCommand command = new CreateCandidateCommand(
                UUID.randomUUID().toString(),
                model.getName(),
                model.getSubject(),
                model.getMail(),
                model.getPhone(),
                model.getMobile(),
                model.getProfileAddress(),
                model.getDegree(),
                model.getInterviewerId(),
                model.getRecruiterId(),
                model.getAppliedJob(),
                model.getDepartment(),
                model.getSource(),
                model.getMedium(),
                model.getAvailability(),
                model.getEvaluation(),
                model.getExpectedSalary(),
                model.getProposedSalary(),
                model.getApplicationSummary(),
                model.getJobPositionId(),
                model.getStage(),
                model.isHired()
        );
        commandGateway.sendAndWait(command);
        return command.getId();
    }

    @PutMapping
    public String updateCandidate(@RequestBody CandidateRequestModel model) {
        UpdateCandidateCommand command = new UpdateCandidateCommand(
                model.getId(),
                model.getName(),
                model.getSubject(),
                model.getMail(),
                model.getPhone(),
                model.getMobile(),
                model.getProfileAddress(),
                model.getDegree(),
                model.getInterviewerId(),
                model.getRecruiterId(),
                model.getAppliedJob(),
                model.getDepartment(),
                model.getSource(),
                model.getMedium(),
                model.getAvailability(),
                model.getEvaluation(),
                model.getExpectedSalary(),
                model.getProposedSalary(),
                model.getApplicationSummary(),
                model.getJobPositionId(),
                model.getStage(),
                model.isHired()
        );
        commandGateway.sendAndWait(command);
        return model.getId();
    }

    @DeleteMapping("/{id}")
    public String deleteCandidate(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteCandidateCommand(id));
        return "Deleted a Candidate with ID: " + id;
    }
}
