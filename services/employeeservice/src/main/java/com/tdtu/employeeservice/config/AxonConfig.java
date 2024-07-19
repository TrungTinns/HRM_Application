package com.tdtu.employeeservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.tdtu.employeeservice.command.data.level.LevelDetailed;
import com.tdtu.employeeservice.command.event.skill.SkillCreatedEvent;
import com.tdtu.employeeservice.converter.DocumentReferenceConverter;
import com.thoughtworks.xstream.XStream;

@Configuration
public class AxonConfig {

    @Bean
    public XStream xStream() {
        XStream xStream = new XStream();
        xStream.allowTypesByWildcard(new String[] {
            "com.tdtu.employeeservice.**"
        });
        xStream.registerConverter(new DocumentReferenceConverter());
        xStream.processAnnotations(SkillCreatedEvent.class);
        xStream.processAnnotations(LevelDetailed.class);
        return xStream;
    }
}


