
use crate::{app_state::{self, APP_STATE}, queue_handler::{task_queue_filter, FilterOptions}, task_modules::Task};

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

// get length of temp queue
pub async fn get_temp_queue_length() -> i32 {
    let app_state = APP_STATE.lock().await;
    app_state.temp_task_queue.len().try_into().unwrap()
}

// get list of temp queue
pub async fn get_temp_queue(options: FilterOptions) -> Vec<TempItem> {
    let app_state = APP_STATE.lock().await;
    task_queue_filter(app_state.temp_task_queue.clone(), options).into_iter()
        .map(TempItem::from_task)
        .collect()
}

// add temp queue to download queue
pub async fn creat_tasks_from_temp(options: FilterOptions) {
    let mut app_state = APP_STATE.lock().await;

    print!("option: {:?}", options);
    print!("temp length: {}", app_state.temp_task_queue.len());
    let new_queue = task_queue_filter(app_state.temp_task_queue.clone(), options);
    print!("new_queue: {} ", new_queue.len());
    app_state.task_queue.extend(new_queue); 
    println!("task queue length: {}", app_state.task_queue.len());
}

// get task queue
pub async fn get_task_queue() -> Vec<TempItem> {
    let app_state = APP_STATE.lock().await;

    app_state.task_queue.iter()
        .map(|task| TempItem::from_task(task.clone()))
        .collect()
}

pub async fn delete_task_queue() {
    let mut app_state = APP_STATE.lock().await;
    app_state.task_queue = vec![];
}