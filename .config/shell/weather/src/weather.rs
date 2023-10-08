use crate::util::Location;
use anyhow::Result;
use chrono::{DateTime, Local};
use reqwest::Client;
use serde::{de::DeserializeOwned, Deserialize};

#[derive(Deserialize, Debug, Clone)]
#[serde(rename_all = "camelCase")]
struct EndpointsProperties {
    forecast_hourly: String,
}

#[derive(Deserialize, Debug, Clone)]
struct Endpoints {
    properties: EndpointsProperties,
}

#[derive(Deserialize, Debug, Clone)]
pub struct ForecastPrecipitation {
    pub value: u32,
}

#[derive(Deserialize, Debug, Clone)]
#[serde(rename_all = "camelCase")]
pub struct ForecastPeriod {
    pub start_time: DateTime<Local>,
    pub end_time: DateTime<Local>,
    pub temperature: u32,
    pub probability_of_precipitation: ForecastPrecipitation,
}

#[derive(Deserialize, Debug, Clone)]
struct ForecastProperties {
    periods: Vec<ForecastPeriod>,
}

#[derive(Deserialize, Debug, Clone)]
struct Forecast {
    properties: ForecastProperties,
}

pub struct WeatherClient {
    client: Client,
}

impl WeatherClient {
    pub fn new(user_agent: &str) -> Result<Self> {
        let client = Client::builder().user_agent(user_agent).build()?;
        let weather_client = Self { client };
        Ok(weather_client)
    }

    pub async fn get_endpoint(&self, loc: &Location) -> Result<String> {
        let endpoint = format!("https://api.weather.gov/points/{},{}", loc.lat, loc.lon);
        let endpoints: Endpoints = self.get(&endpoint).await?;
        Ok(endpoints.properties.forecast_hourly)
    }

    pub async fn get_forecast(&self, endpoint: &str) -> Result<Vec<ForecastPeriod>> {
        let forecast: Forecast = self.get(endpoint).await?;
        Ok(forecast.properties.periods)
    }

    async fn get<T: DeserializeOwned>(&self, endpoint: &str) -> Result<T> {
        let result = self.client.get(endpoint).send().await?.json::<T>().await?;
        Ok(result)
    }
}
