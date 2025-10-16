use bilibili::modules::{Collection, Video};
use regex::Regex;

use crate::app_state::{self, APP_STATE};

#[derive(Debug, Clone)]
pub enum QueryType {
    Video(String),
    Collection(i64),
    Playlist(i64),
    Audio(i64)
}

/// parser query input
pub fn query_parser(input: String) -> Result<QueryType, String> {
    // videos
    let re_video = Regex::new(r#"https?://www\.bilibili\.com/video/(BV\w+)"#).unwrap();
    if let Some(cap) = re_video.captures(input.as_str()) {
        return Ok(QueryType::Video(cap[1].to_string()))
    }

    // collection
    let re_collection = Regex::new(r#"favlist\?fid=(\d+)&ftype=create"#).unwrap();
    if let Some(cap) = re_collection.captures(input.as_str()) {
        return Ok(QueryType::Collection(cap[1].parse::<i64>().ok().unwrap()))
    }

    // Playlist
    let re_playlist = Regex::new(r#"favlist\?fid=(\d+)&ftype=collect"#).unwrap();
    if let Some(cap) = re_playlist.captures(input.as_str()) {
        return Ok(QueryType::Playlist(cap[1].parse::<i64>().ok().unwrap()))
    }

    // Audio
    let re_music = Regex::new(r#"https?://www\.bilibili\.com/audio/au(\d+)"#).unwrap();
    if let Some(cap) = re_music.captures(input.as_str()) {
        return Ok(QueryType::Audio(cap[1].parse::<i64>().ok().unwrap()))
    }

    // Unknow type
    Err("Unknow input".to_string())
}

/// handle query request and write to state
pub async fn query_bili_handler(query: QueryType) -> Result<(), String> {
    let mut app_state = APP_STATE.lock().await;
    match query {
        QueryType::Video(bvid) => {
            let video = Video::from_bvid(bvid).await;
            match video {
                Ok(v) => {
                    app_state.current_item = app_state::Items::Video(v); 
                    Ok(())
                },
                Err(e) => Err(e.to_string()),
            }
        },
        QueryType::Collection(mid) => {
            let collect = Collection::from_mid(mid).await;
            match collect {
                Ok(c) => {
                    app_state.current_item = app_state::Items::Collection(c);
                    Ok(())
                },
                Err(e) => Err(e.to_string()),
            }
        },
        QueryType::Playlist(_) => todo!(),
        QueryType::Audio(_) => todo!(),
    }
}