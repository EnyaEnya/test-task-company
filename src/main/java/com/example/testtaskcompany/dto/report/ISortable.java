package com.example.testtaskcompany.dto.report;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.data.domain.Sort;

public interface ISortable {

    @JsonIgnore
    Sort getSort();
}
