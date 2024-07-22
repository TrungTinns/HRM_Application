package com.tdtu.departmentservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.thoughtworks.xstream.XStream;

@Configuration
public class AxonConfig {

    @Bean
    public XStream xStream() {
        XStream xStream = new XStream();
        xStream.allowTypesByWildcard(new String[] {
            "com.tdtu.employeeservice.**"
        });
//        xStream.processAnnotations(SkillCreatedEvent.class);
//        xStream.processAnnotations(LevelDetailed.class);
        return xStream;
    }
}
