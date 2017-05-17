package com.upc.sqa.config;

public class Config {
	private String baseURL;
	private String[] browsers = null;
	
	public Config(String baseURL, String[] browsers) {
		this.baseURL = baseURL;
		this.browsers = browsers;
	}
	
	public String getBaseURL() {
		return baseURL;
	}
	public void setBaseURL(String baseURL) {
		this.baseURL = baseURL;
	}
	public String[] getBrowsers() {
		return browsers;
	}
	public void setBrowsers(String[] browsers) {
		this.browsers = browsers;
	}
}
