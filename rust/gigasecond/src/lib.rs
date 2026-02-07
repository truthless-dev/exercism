use time::{Duration, PrimitiveDateTime as DateTime};

// Returns a DateTime one billion seconds after start.
pub fn after(start: DateTime) -> DateTime {
    let duration = Duration::seconds(1_000_000_000);

    // We want to be careful here, since adding to an arbitrary DateTime
    // can fail. Usually, this sort of function should probably return
    // Option<DateTime> or do something special in the case of failure,
    // but as we're constrained by the function signature we're given,
    // we simply return `start` in the event of an error.
    if let Some(elapsed) = start.checked_add(duration) {
        return elapsed;
    }
    start
}
