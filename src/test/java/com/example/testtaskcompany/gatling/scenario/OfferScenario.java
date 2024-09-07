package com.example.testtaskcompany.gatling.scenario;

import com.example.testtaskcompany.gatling.dto.GetOfferReportDto;
import com.example.testtaskcompany.gatling.dto.PostOfferDto;
import com.example.testtaskcompany.gatling.steps.OfferSteps;
import io.gatling.javaapi.core.CoreDsl;
import io.gatling.javaapi.core.ScenarioBuilder;

import java.util.UUID;

public class OfferScenario {

    public static ScenarioBuilder postOfferScenarioRequests(PostOfferDto postOfferDto) {
        return CoreDsl.scenario("Post offer request (" + postOfferDto.getMaterialTitle() + " " +
                        postOfferDto.getQuantity() + " " + postOfferDto.getUnits() + ")")
                .exec(OfferSteps.postOffersRequests(postOfferDto));
    }

    public static ScenarioBuilder getOfferScenarioRequests(GetOfferReportDto getOfferReportDto) {

        return CoreDsl.scenario("Get offer report request (" + getOfferReportDto.getMaterialTitle() + " " + UUID.randomUUID() + ")")
                .exec(OfferSteps.getOffersReportRequests(getOfferReportDto));
    }

}
