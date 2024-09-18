package com.example.testtaskcompany.entities.projections;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MaterialsOnStoreProjection {

    private String materialTitle;
    private long materialQuantityOnStore;

    public MaterialsOnStoreProjection(String materialTitle, long materialQuantityOnStore) {
        this.materialTitle = materialTitle;
        this.materialQuantityOnStore = materialQuantityOnStore;
    }
}
