package com.tdtu.discoveryserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class DiscoveryserverApplication {
	
	public static void main(String[] args) {
		String firebaseConfigPath = System.getenv("AXON_SERVER_HOST");
		System.out.println(firebaseConfigPath);
		SpringApplication.run(DiscoveryserverApplication.class, args);
	}

}
