#Controls

def on_press(key, pr) = $gb_var[:event_handler].on_press(key, pr);

def on_single_press(key, pr) = $gb_var[:event_handler].on_single_press(key, pr);

def on_release(key, pr) = $gb_var[:event_handler].on_release(key, pr);

def on_right_click(pr) = $gb_var[:event_handler].on_click(1, pr);

def on_left_click(pr) = $gb_var[:event_handler].on_click(3, pr);

def on_middle_click(pr) = $gb_var[:event_handler].on_click(2, pr);

def on_wheel(pr) = $gb_var[:event_handler].on_wheel(pr);
