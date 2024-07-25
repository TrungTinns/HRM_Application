package com.tdtu.recruitmentservice.kafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tdtu.recruitmentservice.command.data.candidate.Candidate;

@Service
public class KafkaProducer {
    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    private static final String TOPIC = "recruitment";

    public void sendMessage(Candidate candidate) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            String candidateJson = mapper.writeValueAsString(candidate);
            kafkaTemplate.send(TOPIC, candidateJson);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }
}
