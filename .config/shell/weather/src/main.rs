mod graph;
mod printer;
mod util;
mod weather;

use anyhow::Result;
use clap::Parser;
use weather::WeatherClient;

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

    printer::write(&periods, args.days);
    graph::create(&periods);
    Ok(())
}
