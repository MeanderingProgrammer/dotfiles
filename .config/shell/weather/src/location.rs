use anyhow::Result;
use ipgeolocate::{Locator, Service};
use simple_error::SimpleError;

pub async fn get(target_city: &str) -> Result<(String, String)> {
    for _ in 0..10 {
        let ip = external_ip::get_ip().await.unwrap();
        let ip_info = Locator::get_ipaddr(ip, Service::IpApi).await?;
        if ip_info.city == target_city {
            return Ok((ip_info.latitude, ip_info.longitude));
        }
    }
    Err(SimpleError::new("Could not find IP address in 10 attempts").into())
}
