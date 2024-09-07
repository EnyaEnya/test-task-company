package com.example.testtaskcompany.gatling.steps;

import com.example.testtaskcompany.gatling.dto.GetOrderReportDto;
import com.example.testtaskcompany.gatling.dto.PostOrderDto;
import io.gatling.javaapi.core.ChainBuilder;
import io.gatling.javaapi.core.CoreDsl;
import io.gatling.javaapi.http.HttpDsl;

import static io.gatling.javaapi.core.CoreDsl.StringBody;

public class OrderSteps {


    public static ChainBuilder postOrdersRequests(PostOrderDto postOrderDto) {
        return CoreDsl.exec(
                HttpDsl.http("Post order request (" + postOrderDto.getProductTitle() + " " +
                                postOrderDto.getQuantity() + " шт." + ")")
                        .post("/order/products/manage")
                        .header("Content-Type", "application/json")
                        .body(StringBody("{\"productId\": " + postOrderDto.getProductId()
                                + ",\"quantity\": " + postOrderDto.getQuantity() +
                                ",\"companyId\": " + postOrderDto.getCompanyId() + "}"))
                        .check(HttpDsl.status().is(200))
        );
    }


    public static ChainBuilder getOrdersReportRequests(GetOrderReportDto getOrderReportDto)
    {
        return CoreDsl.exec(
                HttpDsl.http("Get orders report request")
                        .get("/report/info/orders")
                        .header("Content-Type", "application/json")
                        .queryParam("column", "id")
                        .queryParam("direction", getOrderReportDto.getDirection())
                        .queryParam("pageNumber", getOrderReportDto.getPageNumber())
                        .queryParam("pageSize", getOrderReportDto.getPageSize())
                        .queryParam("status", getOrderReportDto.getStatus())
                        .queryParam("productTitle", getOrderReportDto.getProductTitle())
                        .queryParam("companyId", getOrderReportDto.getCompanyId())
                        .check(HttpDsl.status().is(200))
        );
    }
}
