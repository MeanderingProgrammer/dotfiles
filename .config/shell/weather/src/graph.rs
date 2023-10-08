use crate::weather::ForecastPeriod;
use textplots::{Chart, Plot, Shape};

pub fn create(periods: &Vec<ForecastPeriod>) {
    let points: Vec<(f32, f32)> = periods
        .iter()
        .enumerate()
        .map(|(i, period)| (i as f32, period.probability_of_precipitation.value as f32))
        .collect();
    let mut chart = Chart::new_with_y_range(200, 80, 0.0, points.len() as f32, 0.0, 100.0);
    chart.lineplot(&Shape::Points(&points)).display();
}
