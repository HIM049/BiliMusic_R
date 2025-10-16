use bilibili::modules::Video;

use crate::{api::modules::BasicInfo, app_state::{self, APP_STATE}, query_handler::{query_bili_handler, query_parser}, task_modules::Task};


#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

// #[flutter_rust_bridge::frb(sync)] // Synchronous mode
// Query video info, set current item
pub async fn query_bili_info(input: String) -> Result<BasicInfo, String> {
    // parse and query info
    if let Err(e) = query_bili_handler(query_parser(input)?).await {
        return Err(e)
    }

    // get current item
    let app_state = APP_STATE.lock().await;
    match app_state.current_item.clone() {
        app_state::Items::Video(video) => Ok(BasicInfo::from_video(video)),
        app_state::Items::Collection(collection) => Ok(BasicInfo::from_collection(collection)),
        app_state::Items::None => Err("none item there".to_string()),
    }

}

#[flutter_rust_bridge::frb(mirror(VideoInfoFlutter))]
pub struct VideoInfoFlutter {
    pub aid: i64,
    pub bvid: String,
    pub cid: i64,
    pub title: String,
    pub cover: String,
    pub author: String,
    pub count: i64,      // Patrs count
    pub tname: String,    // 子分区名称
    pub tname_v2: String, // 子分区名称
    pub pubdate: i64,     // publish time (sec)
    pub desc: String,     // 简介
}

impl VideoInfoFlutter {
    fn from_video(video: Video) -> Self {
        let info = video.info;
        Self { aid: info.aid, bvid: info.bvid, cid: info.cid, title: info.title, cover: info.pic, 
            author: video.upper.name, count: info.videos, tname: info.tname, 
            tname_v2: info.tname_v2, pubdate: info.pubdate, desc: info.desc }
    }
}