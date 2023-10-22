use crate::weather::Forecast;
use chrono::{naive::Days, DateTime, Local};
use plotly::{
    common::{color::NamedColor, Marker, Mode, Title, Visible},
    layout::{Axis, RangeSlider},
    Layout, Plot, Scatter,
};

pub fn create(city: &str, forecast: &Forecast) {
    let days: Vec<DateTime<Local>> = forecast.map(|period| period.start_time);
    let precipitations: Vec<u32> = forecast.map(|period| period.probability_of_precipitation.value);
    let temperatures: Vec<u32> = forecast.map(|period| period.temperature);
    let descriptions: Vec<String> = forecast.map(|period| period.short_forecast.clone());
    let colors: Vec<NamedColor> = forecast.map(|period| color(&period.short_forecast));

    let mut plot = Plot::new();
    plot.add_trace(
        Scatter::new(days.clone(), precipitations)
            .name("Rain")
            .text_array(descriptions)
            .marker(Marker::new().size(12).color_array(colors))
            .mode(Mode::LinesMarkers),
    );
    plot.add_trace(
        Scatter::new(days.clone(), temperatures)
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

fn color(description: &str) -> NamedColor {
    // Colors: https://www.w3schools.com/cssref/css_colors.php
    match description {
        "Sunny" | "Mostly Sunny" => NamedColor::Gold,
        "Partly Sunny" => NamedColor::Goldenrod,
        "Clear" | "Mostly Clear" => NamedColor::DarkBlue,
        "Partly Cloudy" => NamedColor::Blue,
        "Cloudy" | "Mostly Cloudy" => NamedColor::LightBlue,
        "Patchy Fog" | "Slight Chance Light Rain" | "Chance Light Rain" => NamedColor::LightGray,
        "Chance Rain Showers" | "Light Rain" | "Light Rain Likely" => NamedColor::DarkGray,
        "Rain Showers Likely" | "Rain Showers" | "Rain" => NamedColor::Red,
        _ => panic!("No color matches: {description}"),
    }
}

fn format_date(date: DateTime<Local>) -> String {
    date.format("%Y-%m-%d %H:%M:%S").to_string()
}
