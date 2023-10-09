mod graph;
mod util;
mod weather;

use anyhow::Result;
use weather::WeatherClient;

#[tokio::main]
async fn main() -> Result<()> {
    let user_agent = util::user_agent()?;
    let client = WeatherClient::new(&user_agent)?;

    let loc = util::location().await?;
    let endpoint = client.get_endpoint(&loc).await?;
    let forecast = client.get_forecast(&endpoint).await?;

    graph::create(&loc.city, &forecast);
    Ok(())
}
