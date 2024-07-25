package com.tdtu.employeeservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.context.annotation.ComponentScan;

import com.tdtu.employeeservice.config.AxonConfig;

@SpringBootApplication
@EnableDiscoveryClient
@EnableKafka
@Import({ AxonConfig.class })
@ComponentScan(basePackages = "com.tdtu.employeeservice")
public class EmployeeserviceApplication {

    public static void main(String[] args) {
        SpringApplication.run(EmployeeserviceApplication.class, args);
    }
}
