package com.upc.sqa.config;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
	public static Config loadConfig() throws IOException {
		Properties prop = new Properties();
		String propFileName = "config.properties";

		InputStream inputStream = ConfigLoader.class.getClassLoader().getResourceAsStream(propFileName);

		if (inputStream != null) {
			prop.load(inputStream);
		} else {
			throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
		}
		
		// get the property values
		String base_url = prop.getProperty("base_url").toString();
		String browsers_to_test = prop.getProperty("browsers_to_test");
		String[] browsers = browsers_to_test.toString().split(",");
		
		System.out.println("Configuration loaded:");
		System.out.println("base_url = " + base_url);
		System.out.println("browsers = " + browsers_to_test);
		
		return new Config(base_url, browsers);
	}
}
