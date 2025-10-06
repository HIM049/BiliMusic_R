use bilibili::{modules::Video};

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

// #[flutter_rust_bridge::frb(sync = false)]
pub async fn query_bili_info(input: String) -> Option<VideoInfoFlutter> {
    if let Ok(video) = Video::from_bvid(input).await {
        Some(VideoInfoFlutter::from_video(video))
    } else {
        None
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