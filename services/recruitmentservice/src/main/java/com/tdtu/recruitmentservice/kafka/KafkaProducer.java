package com.tdtu.recruitmentservice.kafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import com.tdtu.recruitmentservice.command.data.candidate.Candidate;

@Service
public class KafkaProducer {
	@Autowired
    private KafkaTemplate<String, Candidate> kafkaTemplate;

    private static final String TOPIC = "recruitment";

    public void sendMessage(Candidate candidate) {
        kafkaTemplate.send(TOPIC, candidate);
    }
}
