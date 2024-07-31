package com.tdtu.timesheetservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;

import com.tdtu.timesheetservice.config.AxonConfig;

@SpringBootApplication
@EnableDiscoveryClient
@Import({AxonConfig.class})
public class TimesheetserviceApplication {

	public static void main(String[] args) {
		SpringApplication.run(TimesheetserviceApplication.class, args);
	}

}
