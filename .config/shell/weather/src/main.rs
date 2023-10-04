mod weather;

use anyhow::Result;
use clap::Parser;
use ipgeolocate::{Locator, Service};
use itertools::Itertools;
use simple_error::SimpleError;
use textplots::{Chart, Plot, Shape};
use weather::{ForecastPeriod, WeatherClient};

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

#[derive(Parser, Debug, Clone)]
struct Cli {
    /// Number of days to print results for
    #[clap(short, long, default_value_t = 1)]
    days: u8,
}

#[tokio::main]
async fn main() -> Result<()> {
    let args = Cli::parse();
    let location = get_location("Seattle").await?;
    let periods = get_forecast(&location.0, &location.1).await?;
    write_out(&periods, args.days);
    graph_out(&periods);
    Ok(())
}

async fn get_location(target_city: &str) -> Result<(String, String)> {
    for _ in 0..10 {
        let ip = external_ip::get_ip().await.unwrap();
        let ip_info = Locator::get_ipaddr(ip, Service::IpApi).await?;
        if ip_info.city == target_city {
            return Ok((ip_info.latitude, ip_info.longitude));
        }
    }
    Err(SimpleError::new("Could not find IP address in 10 attempts").into())
}

async fn get_forecast(long: &str, lat: &str) -> Result<Vec<ForecastPeriod>> {
    let client = WeatherClient::new("meanderingprogrammer@gmail.com")?;
    let endpoint = client.get_endpoint(long, lat).await?;
    client.get_forecast(&endpoint).await
}

fn write_out(periods: &Vec<ForecastPeriod>, days: u8) {
    let groups = periods
        .iter()
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

fn graph_out(periods: &Vec<ForecastPeriod>) {
    let points = periods
        .iter()
        .enumerate()
        .map(|(i, period)| (i as f32, period.probability_of_precipitation.value as f32))
        .collect::<Vec<(f32, f32)>>();
    let mut chart = Chart::new_with_y_range(200, 80, 0.0, points.len() as f32, 0.0, 100.0);
    chart.lineplot(&Shape::Points(&points)).display();
}
