package com.tdtu.departmentservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;

import com.tdtu.departmentservice.config.AxonConfig;

@SpringBootApplication
@EnableDiscoveryClient
@Import({ AxonConfig.class })
public class DepartmentserviceApplication {

	public static void main(String[] args) {
		SpringApplication.run(DepartmentserviceApplication.class, args);
	}

}
