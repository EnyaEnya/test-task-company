package com.example.testtaskcompany.dto.report;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PageDto<T> {
    private int totalPages;
    private long totalElements;
    private List<T> content;
    private int pageSize;
    private int pageNumber;

    public PageDto(List<T> content, int totalElements, int pageSize, int pageNumber) {
        this(content, totalElements, pageSize, pageNumber, totalElements / pageSize + (totalElements % pageSize == 0 ? 0 : 1));
    }

    public PageDto(List<T> content, long totalElements, int pageSize, int pageNumber, int totalPages) {
        this.content = content;
        this.totalElements = totalElements;
        this.pageSize = pageSize;
        this.pageNumber = pageNumber;
        this.totalPages = totalPages;
    }

    public static <T> PageDto<T> of(Page<T> page) {
        Pageable pageable = page.getPageable();
        return new PageDto<T>(page.getContent(), page.getTotalElements(), pageable.getPageSize(), pageable.getPageNumber(), page.getTotalPages());
    }
}
