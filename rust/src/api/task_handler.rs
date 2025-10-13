
use crate::{app_state::{APP_STATE}, task_modules::Task};

// convert current item to temp queue
pub async fn create_temp_queue_from_current() -> Result<(), String> {
    let mut app_state = APP_STATE.lock().await;
    match app_state.current_item.clone() {
        crate::app_state::Items::Video(video) => {
            let queue = Task::from_video(video);
            app_state.temp_task_queue = queue;
            Ok(())
        },
        crate::app_state::Items::Collection(collection) => {
            todo!()
        },
        crate::app_state::Items::None => Err("No target".to_string()),
    }
}

#[flutter_rust_bridge::frb(mirror(TempItem))]
pub struct TempItem {
    pub title: String,
    pub part_title: String,
    pub cover_url: String,
}

impl TempItem {
    fn from_task(task: Task) -> Self {
        Self { 
            title: task.video.info.title, 
            part_title: task.part_data.title, 
            cover_url: task.video.info.pic 
        }
    }
}

pub async fn get_temp_queue_length() -> i32 {
    let app_state = APP_STATE.lock().await;
    app_state.temp_task_queue.len().try_into().unwrap()
}

pub async fn get_temp_queue(options: FilterOptions) -> Vec<TempItem> {
    let app_state = APP_STATE.lock().await;
    task_queue_filter(app_state.temp_task_queue.clone(), options).into_iter()
        .map(TempItem::from_task)
        .collect()
}

#[flutter_rust_bridge::frb(mirror(FilterOptions))]
#[derive(Debug, Clone)]
pub struct FilterOptions {
    pub is_with_parts: bool,
    pub from: i32,
    pub to: i32,
}

// add temp queue to download queue
pub async fn creat_tasks_from_temp(options: FilterOptions) {
    let mut app_state = APP_STATE.lock().await;

    let new_queue = task_queue_filter(app_state.temp_task_queue.clone(), options);
    app_state.task_queue.extend(new_queue); 
}

// queue filter
pub fn task_queue_filter(queue: Vec<Task>, options: FilterOptions) -> Vec<Task> {
    let mut filtered = queue;
    if !options.is_with_parts {
        filtered = filter_by_parts(filtered.clone())
    }

    filter_by_range(filtered, options.from.try_into().unwrap(), options.to.try_into().unwrap())

}

pub fn filter_by_parts(queue: Vec<Task>) -> Vec<Task> {
    queue.iter()
        .filter(|task| task.part_id == 0)
        .cloned()
        .collect()
}

pub fn filter_by_range(queue: Vec<Task>, from: usize, to: usize) -> Vec<Task> {
    queue.iter()
        .enumerate()
        .filter(|(index, _)| *index >= from && *index <= to )
        .map(|(_, task)| task.clone())
        .collect()
}