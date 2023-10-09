use crate::weather::Forecast;
use chrono::{naive::Days, DateTime, Local};
use plotly::{
    common::{Mode, Title, Visible},
    layout::{Axis, RangeSlider},
    Layout, Plot, Scatter,
};

pub fn create(city: &str, forecast: &Forecast) {
    let days: Vec<DateTime<Local>> = forecast.map(|period| period.start_time);
    let precipitation: Vec<u32> = forecast.map(|period| period.probability_of_precipitation.value);
    let temperature: Vec<u32> = forecast.map(|period| period.temperature);

    let mut plot = Plot::new();
    plot.add_trace(
        Scatter::new(days.clone(), precipitation)
            .name("Rain")
            .mode(Mode::LinesMarkers),
    );
    plot.add_trace(
        Scatter::new(days.clone(), temperature)
            .name("Temperature")
            .visible(Visible::LegendOnly),
    );
    plot.set_layout(
        Layout::new()
            .height(800)
            .title(Title::new(&format!("Weather in {city}")))
            .x_axis(
                Axis::new()
                    .title(Title::new("Date"))
                    .range_slider(RangeSlider::new().visible(true))
                    .range(vec![
                        format_date(forecast.start()),
                        format_date(forecast.start() + Days::new(1)),
                    ]),
            )
            .y_axis(Axis::new().range(vec![0, 100])),
    );

    plot.show();
}

fn format_date(date: DateTime<Local>) -> String {
    date.format("%Y-%m-%d %H:%M:%S").to_string()
}
