package com.upc.sqa.test;

import com.upc.sqa.config.Config;
import com.upc.sqa.config.ConfigLoader;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

@RunWith(Parameterized.class)
public class GreetingTest {
    private static Config config = null;
    protected WebDriver driver = null;

    @Parameterized.Parameter
    public String browser = null;

    private static void loadConfig() throws IOException {
        config = ConfigLoader.loadConfig();
    }

    private WebDriver createDriver(String browser) throws Exception {
        WebDriver driver = null;
        ArrayList<String> optionsList = new ArrayList<>();

        switch (browser) {
            case "chrome":
                ChromeOptions chromeOptions = new ChromeOptions();
                optionsList.add("--start-maximized");
                optionsList.add("--incognito");
                chromeOptions.addArguments(optionsList);
                driver = new ChromeDriver(chromeOptions);
                break;
            case "firefox":
                driver = new FirefoxDriver();
                break;
            default:
                throw new Exception("The browser type " + browser + " is not supported.");
        }

        return driver;
    };

    @Parameterized.Parameters
    public static Collection<String> data() throws Exception {
        System.out.println("Loading parameters");
        loadConfig();
        return Arrays.asList(config.getBrowsers());
    }

    @Before
    public void setUp() throws Exception {
        System.out.println("Setting up the test for browser -> " + browser);
        String url = config.getBaseURL();

        driver = createDriver(browser);

        driver.get(url);
    }

    @After
    public void tearDown() throws Exception {
        driver.quit();
    }

    private By button = By.id("greetButton");
    private By label = By.id("greetMessage");

    /**
     * Wait at maximum 10 seconds to locate the element located by {@code locator} and is finally visible
     * @param locator
     * @return The WebElement located
     */
    protected WebElement waitForElementVisible(By locator){
        WebDriverWait wait = new WebDriverWait(driver, 10);
        return wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
    }

    @Test
    public void greet(){
        waitForElementVisible(button).click();
        String greetingMessage = waitForElementVisible(label).getText();
        Assert.assertEquals("Greetings!", greetingMessage);
    }
}
