use anyhow::Result;
use ipgeolocate::{Locator, Service};
use std::process::Command;

pub async fn get() -> Result<(String, String)> {
    let ip_result = Command::new("curl")
        .args(["-4", "icanhazip.com"])
        .output()?;
    let ip = String::from_utf8(ip_result.stdout)?;
    let ip_info = Locator::get(&ip, Service::IpApi).await?;
    return Ok((ip_info.latitude, ip_info.longitude));
}
