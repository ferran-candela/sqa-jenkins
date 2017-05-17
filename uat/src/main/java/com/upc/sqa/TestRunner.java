package com.upc.sqa;

import com.upc.sqa.test.GreetingTest;
import org.junit.internal.TextListener;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Main class for running all test cases. Based on information found in
 * http://www.programcreek.com/java-api-examples/index.php?api=org.junit.internal.TextListener
 * 
 * @author ferran
 *
 */
public class TestRunner {
	private static String formatDate(long millis) {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(new Date(millis));
	}

	private static Class<?>[] provideTestClasses() {
		Class<?>[] classes = new Class<?>[] {
				GreetingTest.class
		};
		System.out.println("Found " + classes.length + " test classes to run");
		return classes;
	}

	private static void printResults(Result result) {
		System.out.println("");
		System.out.println("Number of test failures: " + result.getFailureCount() + ", Runtime: "
				+ formatDate(result.getRunTime()));
		for (Failure failure : result.getFailures()) {
			System.out.println(failure.toString());
		}
	}

	public static void main(String[] args) throws Exception {
		JUnitCore junit = new JUnitCore();
		Result result = null;
		Class<?>[] classes = provideTestClasses();

		junit.addListener(new TextListener(System.out));

		result = junit.run(classes);

		printResults(result);

		System.exit(0);
	}
}
