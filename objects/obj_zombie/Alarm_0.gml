if state = 5 {
	var _seed_val = floor(id) + floor(current_time)
	random_set_seed(_seed_val)
	shoot_timer = irandom_range(30, 480)
} else shoot_timer = 60