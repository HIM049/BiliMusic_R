use crate::task_modules::Task;

#[flutter_rust_bridge::frb(mirror(FilterOptions))]
#[derive(Debug, Clone)]
pub struct FilterOptions {
    pub is_with_parts: bool,
    pub from: i32,
    pub to: i32,
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