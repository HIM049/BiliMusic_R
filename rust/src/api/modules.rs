use bilibili::modules::{Collection, Video};

use crate::utils::format_unix_timestamp;

#[derive(Debug, Clone)]
pub struct BasicInfo {
    pub id: String,
    pub title: String,
    pub cover_url: String,
    pub author: String,
    pub count: i64,         // Patrs count
    pub tname: String,      // 子分区名称
    pub pubdate: String,    // publish time (sec)
    pub desc: String,       // 简介
}

impl BasicInfo {
    pub fn from_video(video: Video) -> Self {
        Self { 
            id: video.info.bvid, 
            title: video.info.title, 
            cover_url: video.info.pic, 
            author: video.upper.name, 
            count: video.info.videos, 
            tname: video.info.tname, 
            pubdate: format_unix_timestamp(video.info.pubdate), 
            desc: video.info.desc 
        }
    }

    pub fn from_collection(collect: Collection) -> Self {
        Self { 
            id: collect.info.mid.to_string(), 
            title: collect.info.title, 
            cover_url: collect.info.cover, 
            author: collect.upper.name, 
            count: collect.info.count, 
            tname: "".to_string(), 
            pubdate: format_unix_timestamp(collect.info.ctime), 
            desc: collect.info.desc
        }
    }
}

