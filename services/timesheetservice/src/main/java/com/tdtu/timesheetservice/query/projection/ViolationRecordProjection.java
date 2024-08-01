package com.tdtu.timesheetservice.query.projection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import org.axonframework.queryhandling.QueryHandler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tdtu.timesheetservice.command.data.violationRecord.ViolationRecord;
import com.tdtu.timesheetservice.command.data.violationRecord.ViolationRecordService;
import com.tdtu.timesheetservice.query.model.ViolationRecordResponseModel;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetAllViolationRecordsQuery;
import com.tdtu.timesheetservice.query.queries.violationRecord.GetViolationRecordQuery;


@Component
public class ViolationRecordProjection {
	@Autowired
	private ViolationRecordService ViolationRecordService;

	@QueryHandler
	public ViolationRecordResponseModel handle(GetViolationRecordQuery getViolationRecordQuery)
			throws InterruptedException, ExecutionException {
		ViolationRecordResponseModel model = new ViolationRecordResponseModel();
		Optional<ViolationRecord> empOptional = Optional.ofNullable(ViolationRecordService.findById(getViolationRecordQuery.getId()));
		if (empOptional.isPresent()) {
			ViolationRecord ViolationRecord = empOptional.get();
			BeanUtils.copyProperties(ViolationRecord, model);
		}
		return model;
	}

	@QueryHandler
	public List<ViolationRecordResponseModel> handle(GetAllViolationRecordsQuery getAllViolationRecordsQuery)
			throws InterruptedException, ExecutionException {
		List<ViolationRecord> lstEntity = ViolationRecordService.findAll();
		List<ViolationRecordResponseModel> lstEmp = new ArrayList<>();
		for (ViolationRecord ViolationRecord : lstEntity) {
			ViolationRecordResponseModel model = new ViolationRecordResponseModel();
			BeanUtils.copyProperties(ViolationRecord, model);
	        lstEmp.add(model);
		}
		return lstEmp;
	}
}
