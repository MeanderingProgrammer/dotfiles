use crate::weather::Forecast;
use chrono::{DateTime, Local};
use plotly::{
    common::Title,
    layout::{Axis, RangeSlider},
    Layout, Plot, Scatter,
};

pub fn create(city: &str, forecast: &Forecast) {
    let days: Vec<DateTime<Local>> = forecast.map(|period| period.start_time);
    let precipitation: Vec<u32> = forecast.map(|period| period.probability_of_precipitation.value);
    let temperature: Vec<u32> = forecast.map(|period| period.temperature);

    let mut plot = Plot::new();
    plot.add_trace(Scatter::new(days.clone(), precipitation).name("Rain"));
    plot.add_trace(Scatter::new(days.clone(), temperature).name("Temperature"));
    plot.set_layout(
        Layout::new()
            .height(800)
            .title(Title::new(&format!("Weather in {city}")))
            .x_axis(
                Axis::new()
                    .title(Title::new("Date"))
                    .range_slider(RangeSlider::new().visible(true)),
            )
            .y_axis(Axis::new().range(vec![0, 100])),
    );

    plot.show();
}
