use chrono::{DateTime, Local};
use clap::Parser;
use ipgeolocate::{Locator, Service};
use itertools::Itertools;
use serde::Deserialize;
use simple_error::SimpleError;
use textplots::{Chart, Plot, Shape};

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
struct ForecastPrecipitation {
    value: u32,
}

#[derive(Deserialize, Debug, Clone)]
#[serde(rename_all = "camelCase")]
struct ForecastPeriod {
    start_time: DateTime<Local>,
    end_time: DateTime<Local>,
    temperature: u32,
    probability_of_precipitation: ForecastPrecipitation,
}

impl ForecastPeriod {
    fn get_day(&self) -> String {
        self.start_time.format("%F").to_string()
    }
}

impl std::fmt::Display for ForecastPeriod {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let date_format = "%l%P";
        write!(
            f,
            "{} -> {}: {}°F, {}% Rain",
            self.start_time.format(date_format),
            self.end_time.format(date_format),
            self.temperature,
            self.probability_of_precipitation.value,
        )
    }
}

#[derive(Deserialize, Debug, Clone)]
struct ForecastProperties {
    periods: Vec<ForecastPeriod>,
}

#[derive(Deserialize, Debug, Clone)]
struct Forecast {
    properties: ForecastProperties,
}

#[derive(Parser, Debug, Clone)]
struct Cli {
    /// Number of days to print results for
    #[clap(short, long, default_value_t = 1)]
    days: u8,
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let args = Cli::parse();
    let location = get_location("Seattle").await?;
    let forecast = get_forecast(location).await?;
    write_out(&forecast, args.days);
    graph_out(&forecast);
    Ok(())
}

async fn get_location(target_city: &str) -> anyhow::Result<(String, String)> {
    for _ in 0..10 {
        let ip = external_ip::get_ip().await.unwrap();
        let ip_info = Locator::get_ipaddr(ip, Service::IpApi).await?;
        if ip_info.city == target_city {
            return Ok((ip_info.latitude, ip_info.longitude));
        }
    }
    Err(SimpleError::new("Could not find IP address in 10 attempts").into())
}

async fn get_forecast(location: (String, String)) -> anyhow::Result<Forecast> {
    let client = reqwest::Client::builder()
        .user_agent("meanderingprogrammer@gmail.com")
        .build()?;
    let endpoints = client
        .get(format!(
            "https://api.weather.gov/points/{},{}",
            location.0, location.1
        ))
        .send()
        .await?
        .json::<Endpoints>()
        .await?;
    let forecast = client
        .get(endpoints.properties.forecast_hourly)
        .send()
        .await?
        .json::<Forecast>()
        .await?;
    Ok(forecast)
}

fn write_out(forecast: &Forecast, days: u8) {
    let periods = forecast.properties.periods.iter();
    let groups = periods
        .group_by(|period| period.get_day())
        .into_iter()
        .map(|(day, group)| (day, group.cloned().collect()))
        .collect::<Vec<(String, Vec<ForecastPeriod>)>>();
    for (day, periods) in groups.iter().take(days.into()) {
        println!("{}", day);
        for period in periods.iter() {
            println!("{}", period);
        }
    }
}

fn graph_out(forecast: &Forecast) {
    let periods = forecast.properties.periods.iter();
    let points = periods
        .enumerate()
        .map(|(i, period)| (i as f32, period.probability_of_precipitation.value as f32))
        .collect::<Vec<(f32, f32)>>();
    let mut chart = Chart::new_with_y_range(200, 80, 0.0, points.len() as f32, 0.0, 100.0);
    chart.lineplot(&Shape::Points(&points)).display();
}
