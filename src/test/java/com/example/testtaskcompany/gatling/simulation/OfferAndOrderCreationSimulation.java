package com.example.testtaskcompany.gatling.simulation;

import com.example.testtaskcompany.gatling.dto.GetOfferReportDto;
import com.example.testtaskcompany.gatling.dto.GetOrderReportDto;
import com.example.testtaskcompany.gatling.dto.PostOfferDto;
import com.example.testtaskcompany.gatling.dto.PostOrderDto;
import com.example.testtaskcompany.gatling.scenario.OfferScenario;
import com.example.testtaskcompany.gatling.scenario.OrderScenario;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.gatling.javaapi.core.CoreDsl;
import io.gatling.javaapi.core.PopulationBuilder;
import io.gatling.javaapi.core.Simulation;
import io.gatling.javaapi.http.HttpProtocolBuilder;
import org.apache.commons.rng.sampling.CollectionSampler;
import org.apache.commons.rng.simple.RandomSource;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

import static io.gatling.javaapi.http.HttpDsl.http;
import static org.apache.commons.lang3.RandomUtils.nextInt;

public class OfferAndOrderCreationSimulation extends Simulation {


    private static final int MAX_PAGE_NUMBER = 10;

    private static final int RATE_FOR_POST_REQUEST = 5;
    private static final int DURATION_SEC_FOR_POST_REQUEST = 30;

    private static final int RATE_FOR_GET_REQUEST = 5;
    private static final int DURATION_SEC_FOR_GET_REQUEST = 30;

    private static final HttpProtocolBuilder HTTP_PROTOCOL_BUILDER = http.baseUrl("http://10.5.0.3:8181");
    private static final String DATABASE_URL = "jdbc:postgresql://10.5.0.4:5432/test_task_db";
    private static final String USER = "user";
    private static final String PASSWORD = "password";
    private static final String GET_ACCESS_TOKEN_URL = "http://10.5.0.7:8080/realms/TestCompanyRealm/protocol/openid-connect/token";
    public static String USER_TOKEN;

    private final static List<PostOfferDto> OFFERS = new ArrayList<>();
    private final static List<PostOrderDto> ORDERS = new ArrayList<>();
    private final static List<GetOfferReportDto> REPORT_OFFERS = new ArrayList<>();
    private final static List<GetOrderReportDto> REPORT_ORDERS = new ArrayList<>();

    static {
        getInfoFromDatabaseBeforeTest();
        generateGetOffersBeforeTest();
        generateGetOrdersBeforeTest();
        USER_TOKEN = getUserAccessTokenBeforeTest();
    }

    public OfferAndOrderCreationSimulation() {
        List<PopulationBuilder> steps = new ArrayList<>();

        OFFERS.forEach(postOfferDto -> steps.add(OfferScenario.postOfferScenarioRequests(postOfferDto).injectOpen(
                CoreDsl.constantUsersPerSec(RATE_FOR_POST_REQUEST).during(DURATION_SEC_FOR_POST_REQUEST))));

        ORDERS.forEach(postOrderDto -> steps.add(OrderScenario.postOrderScenarioRequests(postOrderDto).injectOpen(
                CoreDsl.constantUsersPerSec(RATE_FOR_POST_REQUEST).during(DURATION_SEC_FOR_POST_REQUEST))));

        REPORT_OFFERS.forEach(offerReportDto -> steps.add(OfferScenario.getOfferScenarioRequests(offerReportDto)
                .injectOpen(CoreDsl.constantUsersPerSec(RATE_FOR_GET_REQUEST).during(DURATION_SEC_FOR_GET_REQUEST))));

        REPORT_ORDERS.forEach(orderReportDto -> steps.add(OrderScenario.getOrderScenarioRequests(orderReportDto)
                .injectOpen(CoreDsl.constantUsersPerSec(RATE_FOR_GET_REQUEST).during(DURATION_SEC_FOR_GET_REQUEST))));

        this.setUp(steps).protocols(HTTP_PROTOCOL_BUILDER);
    }

    private static void getInfoFromDatabaseBeforeTest() {
        long companyId = 1L;
        long providerId = 1L;

        try (Connection conn = DriverManager.getConnection(
                DATABASE_URL, USER, PASSWORD);
        ) {
            processSql(conn, "select * from material", materialResultSet -> {
                try {
                    long materialId = materialResultSet.getLong("id");
                    String materialTitle = materialResultSet.getString("title");
                    String materialUnits = materialResultSet.getString("units");
                    PostOfferDto postOfferDto = new PostOfferDto(materialId,
                            nextInt(20, 40),
                            materialTitle,
                            companyId, providerId,
                            materialUnits);

                    OFFERS.add(postOfferDto);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            });
            processSql(conn, "select * from product", productResultSet -> {
                try {
                    long productId = productResultSet.getLong("id");
                    String productTitle = productResultSet.getString("title");
                    PostOrderDto postOrderDto = new PostOrderDto(productId,
                            nextInt(1, 10),
                            productTitle,
                            companyId);

                    ORDERS.add(postOrderDto);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            });
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void generateGetOffersBeforeTest() {
        CollectionSampler<String> titleSampler = new CollectionSampler<>(RandomSource.MWC_256.create(),
                OFFERS.stream().map(PostOfferDto::getMaterialTitle).toList());
        CollectionSampler<String> directionsSampler = new CollectionSampler<>(RandomSource.MWC_256.create(),
                List.of("ASC", "DESC"));
        CollectionSampler<String> statusesSampler = new CollectionSampler<>(RandomSource.MWC_256.create(),
                List.of("APPROVED", "REJECTED"));

        for (int pageNumber = 0; pageNumber < MAX_PAGE_NUMBER; pageNumber++) {

            GetOfferReportDto getOfferReportDto = new GetOfferReportDto();
            getOfferReportDto.setColumn("id");
            getOfferReportDto.setDirection(directionsSampler.sample());
            getOfferReportDto.setStatus(statusesSampler.sample());
            getOfferReportDto.setMaterialTitle(titleSampler.sample());
            getOfferReportDto.setPageNumber(pageNumber);
            getOfferReportDto.setPageSize(20);
            getOfferReportDto.setCompanyId(1L);
            getOfferReportDto.setProviderId(1L);

            REPORT_OFFERS.add(getOfferReportDto);
        }
    }

    private static void generateGetOrdersBeforeTest() {
        CollectionSampler<String> titleSampler = new CollectionSampler<>(RandomSource.MWC_256.create(),
                ORDERS.stream().map(PostOrderDto::getProductTitle).toList());
        CollectionSampler<String> directionsSampler = new CollectionSampler<>(RandomSource.MWC_256.create(),
                List.of("ASC", "DESC"));
        CollectionSampler<String> statusesSampler = new CollectionSampler<>(RandomSource.MWC_256.create(),
                List.of("APPROVED", "REJECTED"));

        for (int pageNumber = 0; pageNumber < MAX_PAGE_NUMBER; pageNumber++) {

            GetOrderReportDto getOrderReportDto = new GetOrderReportDto();
            getOrderReportDto.setColumn("id");
            getOrderReportDto.setDirection(directionsSampler.sample());
            getOrderReportDto.setStatus(statusesSampler.sample());
            getOrderReportDto.setProductTitle(titleSampler.sample());
            getOrderReportDto.setPageNumber(pageNumber);
            getOrderReportDto.setPageSize(20);
            getOrderReportDto.setCompanyId(1L);

            REPORT_ORDERS.add(getOrderReportDto);
        }
    }

    private static String getUserAccessTokenBeforeTest() {
        ObjectMapper mapper = new ObjectMapper();
        String result;
        HttpPost post = new HttpPost(GET_ACCESS_TOKEN_URL);

        List<NameValuePair> urlParameters = new ArrayList<>();
        urlParameters.add(new BasicNameValuePair("client_id", "company"));
        urlParameters.add(new BasicNameValuePair("username", "ivanov"));
        urlParameters.add(new BasicNameValuePair("password", "password"));
        urlParameters.add(new BasicNameValuePair("grant_type", "password"));

        try {
            post.setEntity(new UrlEncodedFormEntity(urlParameters));
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }

        try (CloseableHttpClient httpClient = HttpClients.createDefault();
             CloseableHttpResponse response = httpClient.execute(post)) {
            JsonNode actualObj = mapper.readTree(EntityUtils.toString(response.getEntity()));
            result = actualObj.get("access_token") != null ? actualObj.get("access_token").asText() : "";
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return result;
    }


    private static void processSql(Connection connection, String sql, Consumer<ResultSet> consumer) {
        try (PreparedStatement materialPreparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = materialPreparedStatement.executeQuery();
            while (resultSet.next()) {
                consumer.accept(resultSet);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
