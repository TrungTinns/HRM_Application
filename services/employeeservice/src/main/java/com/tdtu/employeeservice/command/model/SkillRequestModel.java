package com.tdtu.employeeservice.command.model;

import java.util.List;

import com.tdtu.employeeservice.command.data.level.LevelDetailed;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SkillRequestModel {
    private String id;
    private String skillType;
    private List<String> name;
    private List<LevelDetailed> levels;
}
