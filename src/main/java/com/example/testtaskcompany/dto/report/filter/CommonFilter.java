package com.example.testtaskcompany.dto.report.filter;

import com.example.testtaskcompany.dto.report.PageRequest;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Sort;

@Getter
@Setter
@EqualsAndHashCode(callSuper = true)
public class CommonFilter extends PageRequest {
    private Sort.Direction direction;
    private String column;

    @Override
    public Sort getSort() {
        if (direction != null && column != null) {
            return Sort.by(new Sort.Order(direction, column, Sort.NullHandling.NULLS_LAST));
        }
        return Sort.by(Sort.Direction.ASC);
    }
}
