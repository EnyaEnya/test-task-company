package com.example.testtaskcompany.dto.report;

import com.example.testtaskcompany.dto.report.ISortable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
public abstract class PageRequest implements ISortable {

    private int pageSize = 5;
    private int pageNumber;
}
