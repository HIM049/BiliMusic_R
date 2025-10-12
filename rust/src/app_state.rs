use bilibili::{modules::Collection, modules::Video};
use tokio::sync::Mutex;
use once_cell::sync::Lazy;

use crate::task_modules::Task;

pub static APP_STATE: Lazy<Mutex<AppState>> = Lazy::new(|| {
    Mutex::new(AppState {
        current_item: Items::None,
        task_queue: vec![],
        temp_task_queue: vec![],
    })
});

#[derive(Debug, Clone)]
pub struct AppState {
    pub current_item: Items,
    pub task_queue: Vec<Task>,
    pub temp_task_queue: Vec<Task>,
}

#[derive(Debug, Clone)]
pub enum Items {
    Video(Video),
    Collection(Collection),
    None
}