use crate::weather::ForecastPeriod;
use itertools::Itertools;

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

pub fn write(periods: &Vec<ForecastPeriod>, days: u8) {
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
