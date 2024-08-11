package com.tdtu.timesheetservice;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.messaging.handler.annotation.Payload;

import com.tdtu.timesheetservice.config.AxonConfig;
import com.tdtu.timesheetservice.query.controller.ComplianceRuleQueryController;
import com.tdtu.timesheetservice.query.controller.EntryQueryController;
import com.tdtu.timesheetservice.query.controller.TimeOffRequestQueryController;
import com.tdtu.timesheetservice.query.controller.ViolationRecordQueryController;
import com.tdtu.timesheetservice.query.model.EntryResponseModel;
import com.tdtu.timesheetservice.query.model.TimeOffRequestResponseModel;
import com.tdtu.timesheetservice.query.model.TimeSheetResponseModel;
import com.tdtu.timesheetservice.query.model.ViolationRecordResponseModel;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootApplication
@EnableDiscoveryClient
@EnableKafka
@Import({AxonConfig.class})
public class TimesheetserviceApplication {
	@Autowired
    private KafkaTemplate<String, String> kafkaTemplate;
	
	@Autowired
	private EntryQueryController entryController;
	
	@Autowired
	private ViolationRecordQueryController violationRecordController;
	
	@Autowired
	private TimeOffRequestQueryController timeOffRequestController;
	
	@Autowired
	private ComplianceRuleQueryController complianceController;
	
	@KafkaListener(topics = "timesheet-request", groupId = "timesheet-group")
    public void consumeEmployeeRequest(@Payload String message, Acknowledgment acknowledgment) throws Exception {
		log.info(message);
		String empId = message.split(",")[0];
		String month= message.split(",")[1];
		String year = message.split(",")[2];
		List<EntryResponseModel> entries = entryController.getEntryByEmpIdAndTime(empId, month, year);
		List<ViolationRecordResponseModel> violations = violationRecordController.getViolationRecordsByEmpIdAndTime(empId, month, year);
		List<TimeOffRequestResponseModel> timeOff = timeOffRequestController.getTimeOffRequestsByEmpIdAndTime(empId, month, year);
		double totalOverTimes = 0;
		double penaltyAmount = 0;
		double totalOfficalHours = 0;
		
		for (EntryResponseModel entry : entries) {
			if (entry.getClockIn() != null && entry.getClockOut() != null) {
				LocalDateTime startTime = convertToLocalDateTime(entry.getClockIn());
				LocalDateTime endTime = convertToLocalDateTime(entry.getClockOut());
				
				Duration duration = Duration.between(startTime, endTime);
				long hours = duration.toHours();
				long minutes = duration.toMinutes() % 60;
				totalOfficalHours += hours + minutes / 60.0;
			}
			
			if (entry.getOverTimeHours() != null) totalOverTimes += entry.getOverTimeHours();
			
		}
		
		 Set<String> distinctRuleIds = violations.stream()
		            .map(ViolationRecordResponseModel::getRuleId)
		            .collect(Collectors.toSet());
		
		for (String rule: distinctRuleIds) {
			long times = violations.stream().filter(violation -> rule.equals(violation.getRuleId())).count();
			penaltyAmount += (times * complianceController.getComplianceruleDetail(rule).getPenaltyAmount());
		}
		
		TimeSheetResponseModel resp = new TimeSheetResponseModel();
		resp.setEntries(entries);
		resp.setTimeOff(timeOff);
		resp.setViolation(violations);
		resp.setTotalOfficalHours(totalOfficalHours);
		resp.setTotalOverTimes(totalOverTimes);
		resp.setPenaltyAmount(penaltyAmount);
		
    	JSONObject jsonObject = new JSONObject(resp);
    	String timeSheetJson = jsonObject.toString();
    	
        kafkaTemplate.send("timesheet-response", timeSheetJson);
        acknowledgment.acknowledge();
    }
	
	private LocalDateTime convertToLocalDateTime(Date date) {
		return date.toInstant()
		          .atZone(ZoneId.systemDefault())
		          .toLocalDateTime();
	}
	
	public static void main(String[] args) {
		SpringApplication.run(TimesheetserviceApplication.class, args);
	}

}
