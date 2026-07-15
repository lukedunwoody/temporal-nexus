if check_pause_screen() exit

// float in place
float_dir += float_spd
y = ystart + dsin(float_dir)

// get collected
if (place_meeting(x, y, obj_player)) {

	global.replay_timer_started = true

    effect_create_depth(depth, ef_smoke, x, y, 0.3, c_aqua)

    instance_destroy()
}