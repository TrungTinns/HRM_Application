package com.tdtu.recruitmentservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;

import com.tdtu.recruitmentservice.config.AxonConfig;

@SpringBootApplication
@EnableDiscoveryClient
@Import({AxonConfig.class})
public class RecruitmentserviceApplication {

	public static void main(String[] args) {
		SpringApplication.run(RecruitmentserviceApplication.class, args);
	}

}
