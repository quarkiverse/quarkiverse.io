package io.quarkiverse.site;

import static org.hamcrest.Matchers.containsString;

import org.junit.jupiter.api.Test;

import io.quarkiverse.roq.testing.RoqAndRoll;
import io.quarkus.test.junit.QuarkusTest;
import io.restassured.RestAssured;

@QuarkusTest
@RoqAndRoll
public class RoqAndRollTest {

    @Test
    public void testFrontPageHasButton() {
        RestAssured.when().get("/").then()
                .statusCode(200)
                .body(containsString("class=\"button-cta\""));
    }
}
