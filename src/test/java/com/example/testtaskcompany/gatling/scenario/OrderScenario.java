package com.example.testtaskcompany.gatling.scenario;

import com.example.testtaskcompany.gatling.dto.GetOrderReportDto;
import com.example.testtaskcompany.gatling.dto.PostOrderDto;
import com.example.testtaskcompany.gatling.steps.OrderSteps;
import io.gatling.javaapi.core.CoreDsl;
import io.gatling.javaapi.core.ScenarioBuilder;

import java.util.UUID;

public class OrderScenario {

    public static ScenarioBuilder postOrderScenarioRequests(PostOrderDto postOrderDto) {
        return CoreDsl.scenario("Post order request (" + postOrderDto.getProductTitle() + " " +
                        postOrderDto.getQuantity() + " шт." + ")")
                .exec(OrderSteps.postOrdersRequests(postOrderDto));
    }

    public static ScenarioBuilder getOrderScenarioRequests(GetOrderReportDto getOrderReportDto) {

        return CoreDsl.scenario("Get order report request (" + getOrderReportDto.getProductTitle() + " " + UUID.randomUUID() + ")")
                .exec(OrderSteps.getOrdersReportRequests(getOrderReportDto));
    }


}
