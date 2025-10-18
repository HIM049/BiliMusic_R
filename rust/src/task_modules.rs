use anyhow::Error;
use bilibili::modules::{Collection, CollectionMedia, Video, VideoPart};
use serde::{Deserialize, Serialize};


// #[derive(Debug, Serialize, Deserialize, Clone)]
#[derive(Debug, Clone)]
pub enum Task {
    Video(VideoTask),
    Audio
}

// #[derive(Debug, Serialize, Deserialize, Clone)]
// #[derive(Debug, Clone)]
// pub struct Task {
//     pub task_type: MediaType,
//     pub video: Video,
//     pub item: MediaItems,
//     pub part_id: usize,
//     pub part_data: VideoPart,
// }

#[derive(Debug, Clone)]
pub struct VideoTask {
    pub video: Video,
    pub part_id: usize,
    pub part_data: VideoPart,
}

impl Task {
    pub fn from_video(video: Video) -> Vec<Self> {
        let mut task_list: Vec<Self> = vec![];
        // create jobs for every part
        for (index, part) in video.parts.clone().iter().enumerate() {
            task_list.push( 
                Self::Video(VideoTask { 
                    video: video.clone(), 
                    part_id: index, 
                    part_data: part.clone(), 
                })
            );
        }
        task_list
    }

    pub async fn from_collection(collect: Collection) -> Result<Vec<Self>, anyhow::Error> {
        let mut task_list: Vec<Self> = vec![];
        let mut failed_list: Vec<(CollectionMedia, Error)> = vec![];

        // get complete collect
        let result = collect.get_complete_collection().await;
        match result {
            Ok(c) => {
                // range the collect, get 
                if let Some(medias) = c.medias {
                    for media in medias {
                        match media.media_type {
                            bilibili::modules::MediaType::Video => {
                                match Video::from_bvid(media.bvid.clone()).await {
                                    Ok(v) => {
                                        let video_queue = Task::from_video(v);
                                        task_list.extend(video_queue);
                                    },
                                    Err(e) => {
                                        failed_list.push((media, e));
                                        continue;
                                    },
                                };
                            },
                            bilibili::modules::MediaType::Audio => todo!(),
                            bilibili::modules::MediaType::Playlist => todo!(),
                        }
                    }
                }
            },
            Err(_) => todo!(),
        }

        Ok(task_list)
    }
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Meta {
    pub song_name: String,
    pub cover_url: String, // Turn to cover image?
    pub author: String,
    pub lyrics_path: String, // data.subtitle.list[0]. id / lan字幕语言 / lan_doc字幕语言名称 / is_lock / author_mid / subtitle_url
    // singer, from ...
}

// impl Meta {
//     pub fn from_video(video: Video) -> Option<Self> {
//         None
//     }
// }

// impl Meta {
//     pub fn from_json(json: Value) -> Option<Self> {
//         Some(
//             //TODO: Waiting for refactor
//             Meta {
//                 title: json["title"].as_str()?.to_string(),
//                 cover_url: json["pic"].as_str()?.to_string(),
//                 author: json["title"].as_str()?.to_string(),
//                 lyrics_path: "".to_string(),
//             }
//         )
//     }
// }