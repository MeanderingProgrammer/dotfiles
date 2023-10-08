use anyhow::Result;
use serde::{de::DeserializeOwned, Deserialize};

#[derive(Deserialize, Debug, Clone)]
struct Ip {
    origin: String,
}

#[derive(Deserialize, Debug, Clone)]
pub struct Location {
    pub city: String,
    pub lat: f64,
    pub lon: f64,
}

pub async fn location() -> Result<Location> {
    let ip: Ip = get("http://httpbin.org/ip").await?;
    let loc: Location = get(&format!("http://ip-api.com/json/{}", &ip.origin)).await?;
    return Ok(loc);
}

async fn get<T: DeserializeOwned>(endpoint: &str) -> Result<T> {
    let result = reqwest::get(endpoint).await?.json::<T>().await?;
    Ok(result)
}
