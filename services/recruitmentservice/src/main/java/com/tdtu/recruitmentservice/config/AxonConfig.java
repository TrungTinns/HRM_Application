package com.tdtu.recruitmentservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.tdtu.recruitmentservice.converter.DocumentReferenceConverter;
import com.thoughtworks.xstream.XStream;

@Configuration
public class AxonConfig {
	
	 @Bean
	    public XStream xStream() {
	        XStream xStream = new XStream();
	        xStream.allowTypesByWildcard(new String[] {
	            "com.tdtu.recruitmentservice.**"
	        });
	        xStream.registerConverter(new DocumentReferenceConverter());
	        return xStream;
	    }
}
