mod graph;
mod util;
mod weather;

use anyhow::Result;
use clap::Parser;
use itertools::Itertools;
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

    let loc = util::location().await?;
    println!("Weather in {}", loc.city);

    let user_agent = util::user_agent()?;
    let client = WeatherClient::new(&user_agent)?;
    let endpoint = client.get_endpoint(&loc).await?;
    let periods = client.get_forecast(&endpoint).await?;

    write_out(&periods, args.days);
    graph::create(&periods);
    Ok(())
}

fn write_out(periods: &Vec<ForecastPeriod>, days: u8) {
    let groups: Vec<(String, Vec<&ForecastPeriod>)> = periods
        .iter()
        .group_by(|period| period.get_day())
        .into_iter()
        .map(|(day, group)| (day, group.collect()))
        .collect();

    for (day, periods) in groups.iter().take(days.into()) {
        println!("{}", day);
        for period in periods.iter() {
            println!("{}", period);
        }
    }
}
