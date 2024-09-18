package com.example.testtaskcompany.entities.projections;

import com.example.testtaskcompany.dto.report.json.CompanyInfo;
import com.example.testtaskcompany.entities.AbstractIdEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.math.BigDecimal;

@Getter
@Setter
@Immutable
@Entity
@Table(schema = "public", name = "company")
public class CompanyInfoProjectionEntity extends AbstractIdEntity {

    private String title;

    private BigDecimal financialAccount;

    @JdbcTypeCode(SqlTypes.JSON)
    @Formula("""
            (select json_build_object('statOrderInfo',
                         (select json_build_object('approvedOrders', count(*) filter (where ord.status = 'APPROVED'),
                                                   'allOrders', count(*))
                          from order_table ord
                          where ord.company_id = id),
                         'productOrderInfoList',
                         array_to_json(array(select json_build_object('productTitle', alias_.title, 'productQuantity',
                                                                      alias_.sum)
                                             from (select p.title, SUM(o.quantity) sum
                                                   from order_table o
                                                            join product p on o.product_id = p.id
                                                   where o.company_id = id
                                                   group by p.title) as alias_)),
                         'materialStoreInfoList',
                         array_to_json(array(select json_build_object('materialTitle', alias_.title, 'materialQuantity',
                                                                      alias_.quantity)
                                             from (select m.title, cms.quantity
                                                   from material m
                                                            join company_material_store cms on m.id = cms.material_id
                                                   where cms.company_id = id) as alias_))))
            """)
    private CompanyInfo companyInfo;


}
