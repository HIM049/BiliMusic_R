pub fn format_unix_timestamp(timestamp: i64) -> String {
    match time_format::strftime_utc("%y-%m-%d %H:%M", timestamp) {
        Ok(formatted_time) => formatted_time,
        Err(e) => format!("Failed to format timestamp: {} Error: {}", timestamp, e.to_string()),
    }
}