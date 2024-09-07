package com.example.testtaskcompany.gatling.steps;

import com.example.testtaskcompany.gatling.dto.GetOfferReportDto;
import com.example.testtaskcompany.gatling.dto.PostOfferDto;
import io.gatling.javaapi.core.ChainBuilder;
import io.gatling.javaapi.core.CoreDsl;
import io.gatling.javaapi.http.HttpDsl;

import static io.gatling.javaapi.core.CoreDsl.StringBody;

public class OfferSteps {

    public static ChainBuilder postOffersRequests(PostOfferDto postOfferDto) {
        return CoreDsl.exec(
                HttpDsl.http("Post offer request (" + postOfferDto.getMaterialTitle() + " " +
                                postOfferDto.getQuantity() + " " + postOfferDto.getUnits() + ")")
                        .post("/offer/materials/manage")
                        .header("Content-Type", "application/json")
                        .body(StringBody("{\"materialId\": " + postOfferDto.getMaterialId()
                                + ",\"quantity\": " + postOfferDto.getQuantity() +
                                ",\"companyId\": " + postOfferDto.getCompanyId() +
                                ",\"providerId\": " + postOfferDto.getProviderId() + "}"))
                        .check(HttpDsl.status().is(200))
        );
    }

    public static ChainBuilder getOffersReportRequests(GetOfferReportDto getOfferReportDto)
    {
        return CoreDsl.exec(
                HttpDsl.http("Get offers report request")
                        .get("/report/info/offers")
                        .header("Content-Type", "application/json")
                        .queryParam("column", "id")
                        .queryParam("direction", getOfferReportDto.getDirection())
                        .queryParam("pageNumber", getOfferReportDto.getPageNumber())
                        .queryParam("pageSize", getOfferReportDto.getPageSize())
                        .queryParam("status", getOfferReportDto.getStatus())
                        .queryParam("materialTitle", getOfferReportDto.getMaterialTitle())
                        .queryParam("companyId", getOfferReportDto.getCompanyId())
                        .queryParam("providerId", getOfferReportDto.getProviderId())
                        .check(HttpDsl.status().is(200))
        );
    }
}
