package com.tdtu.recruitmentservice.command.aggregate;

import java.util.Date;

import org.axonframework.commandhandling.CommandHandler;
import org.axonframework.eventsourcing.EventSourcingHandler;
import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.modelling.command.AggregateLifecycle;
import org.axonframework.spring.stereotype.Aggregate;
import org.springframework.beans.BeanUtils;

import com.tdtu.recruitmentservice.command.command.recruitment.CreateRecruitmentCommand;
import com.tdtu.recruitmentservice.command.command.recruitment.DeleteRecruitmentCommand;
import com.tdtu.recruitmentservice.command.command.recruitment.UpdateRecruitmentCommand;
import com.tdtu.recruitmentservice.command.event.recruitment.RecruitmentCreatedEvent;
import com.tdtu.recruitmentservice.command.event.recruitment.RecruitmentDeletedEvent;
import com.tdtu.recruitmentservice.command.event.recruitment.RecruitmentUpdatedEvent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Aggregate
@AllArgsConstructor
@NoArgsConstructor
public class RecruitmentAggregate {
	@AggregateIdentifier
	private String id;
	private String candidateId;
	private Date jobOfferDate; 
	// CREATE EVENT
		@CommandHandler
		public RecruitmentAggregate(CreateRecruitmentCommand createRecruitmentCommand) {
			RecruitmentCreatedEvent RecruitmentCreatedEvent = new RecruitmentCreatedEvent();
			BeanUtils.copyProperties(createRecruitmentCommand, RecruitmentCreatedEvent);
			AggregateLifecycle.apply(RecruitmentCreatedEvent);
		}

		@EventSourcingHandler
		public void on(RecruitmentCreatedEvent event) {
			this.id = event.getId();
	        this.candidateId = event.getCandidateId();
	        this.jobOfferDate = event.getOfferedDate();
		}

		// UPDATED EVENT
		@CommandHandler
		public void handle(UpdateRecruitmentCommand updateRecruitmentCommand) {
			RecruitmentUpdatedEvent RecruitmentUpdatedEvent = new RecruitmentUpdatedEvent();
			BeanUtils.copyProperties(updateRecruitmentCommand, RecruitmentUpdatedEvent);
			AggregateLifecycle.apply(RecruitmentUpdatedEvent);
		}

		@EventSourcingHandler
		public void on(RecruitmentUpdatedEvent event) {
			this.id = event.getId();
	        this.candidateId = event.getCandidateId();
	        this.jobOfferDate = event.getOfferedDate();
		}

		// DELETE EVENT
		@CommandHandler
		public void handle(DeleteRecruitmentCommand deleteRecruitmentCommand) {
			RecruitmentDeletedEvent RecruitmentDeletedEvent = new RecruitmentDeletedEvent();
			BeanUtils.copyProperties(deleteRecruitmentCommand, RecruitmentDeletedEvent);
			AggregateLifecycle.apply(RecruitmentDeletedEvent);
		}

		@EventSourcingHandler
		public void on(RecruitmentDeletedEvent event) {
			this.id = event.getId();
		}	
}
