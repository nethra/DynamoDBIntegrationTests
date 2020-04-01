package com.dynamodb.IntegrationTests;

import com.amazonaws.services.dynamodbv2.local.main.ServerRunner;
import com.amazonaws.services.dynamodbv2.local.server.DynamoDBProxyServer;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.event.annotation.BeforeTestClass;

@SpringBootTest
class IntegrationTestsApplicationTests {

	private static DynamoDBProxyServer server;

	@BeforeClass
	public static void setupClass() throws Exception {
		System.setProperty("sqlite4java.library.path", "native-libs");
		String port = "8000";
		server = ServerRunner.createServerFromCommandLineArgs(
				new String[]{"-inMemory", "-port", port});
		server.start();
		//...
	}

	@AfterClass
	public static void teardownClass() throws Exception {
		server.stop();
	}

	@Test
	void contextLoads() {
	}

}
