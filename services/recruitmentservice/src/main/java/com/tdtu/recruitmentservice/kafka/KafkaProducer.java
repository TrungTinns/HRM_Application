package com.tdtu.recruitmentservice.kafka;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import com.tdtu.recruitmentservice.query.model.CandidateResponseModel;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KafkaProducer {
    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    private static final String TOPIC = "recruitment";

    public void sendMessage(CandidateResponseModel candidate) {
    	JSONObject jsonObject = new JSONObject(candidate);
        String candidateJson = jsonObject.toString();

        log.info(candidateJson);
        kafkaTemplate.send(TOPIC, candidateJson);
    }
}
