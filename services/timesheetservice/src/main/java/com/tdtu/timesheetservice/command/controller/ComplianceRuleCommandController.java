package com.tdtu.timesheetservice.command.controller;

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

import com.tdtu.timesheetservice.command.command.complianceRule.CreateComplianceRuleCommand;
import com.tdtu.timesheetservice.command.command.complianceRule.DeleteComplianceRuleCommand;
import com.tdtu.timesheetservice.command.command.complianceRule.UpdateComplianceRuleCommand;
import com.tdtu.timesheetservice.command.model.ComplianceRuleRequestModel;

@RestController
@RequestMapping("/api/v1/timesheet/complianceRule")
public class ComplianceRuleCommandController {
    @Autowired
    private CommandGateway commandGateway;

    @PostMapping
    public String addComplianceRule(@RequestBody ComplianceRuleRequestModel model) {
        CreateComplianceRuleCommand command = new CreateComplianceRuleCommand(
                UUID.randomUUID().toString(),
                model.getRuleDescription(),
                model.getPenaltyDescription(),
                model.getPenaltyAmount(),
                model.getEffectiveDate()
        );
        commandGateway.sendAndWait(command);
        return command.getId();
    }

    @PutMapping
    public String updateComplianceRule(@RequestBody ComplianceRuleRequestModel model) {
        UpdateComplianceRuleCommand command = new UpdateComplianceRuleCommand(
                model.getId(),
                model.getRuleDescription(),
                model.getPenaltyDescription(),
                model.getPenaltyAmount(),
                model.getEffectiveDate()
        );
        commandGateway.sendAndWait(command);
        return model.getId();
    }

    @DeleteMapping("/{id}")
    public String deleteComplianceRule(@PathVariable String id) {
        commandGateway.sendAndWait(new DeleteComplianceRuleCommand(id));
        return "Deleted a ComplianceRule with ID: " + id;
    }
}
