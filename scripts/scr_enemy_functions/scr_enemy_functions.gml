function enemy_shooting(_gain = 0.75) {

	// Find game speed
	var _game_speed = global.game_speed

	// Get the player's direction
	var _player_dir = dir
	if instance_exists(obj_player) then _player_dir = point_direction(x, y, obj_player.x, obj_player.y)
	
	// Count down timer
	if shoot_timer > 0 then shoot_timer -= _game_speed
	
	if shoot_timer <= 0 and ammo > 0 {
	
		if global.sfx_enabled audio_play_sound(snd_gun_shot, 0, 0, _gain)	
	
		// Reset timer and remove ammo
		shoot_timer = weapon.cooldown
		ammo--
		
		// Find weapon tip
		var _x_offset = lengthdir_x(weapon.length, _player_dir)
		var _y_offset = lengthdir_y(weapon.length, _player_dir)
	
		var _weapon_tip_x = x + _x_offset
		var _weapon_tip_y = y + _y_offset
		
		// Calculate spread
		var _spread = weapon.spread
	
		var _min_angle = _player_dir - _spread/2
		var _max_angle = _player_dir + _spread/2
		
		// Create bullets
		for (var i = 0; i < weapon.bullet_num; i++) {
		
			// Create bullet instance
			var _bullet_inst = instance_create_depth(_weapon_tip_x, _weapon_tip_y, depth - 100, weapon.bullet_obj)
		
			with _bullet_inst {
			
				// Set random direction
				random_set_seed(current_time + current_hour + current_weekday + current_second + i)
				dir = irandom_range(_min_angle, _max_angle)
				
				image_angle = dir
			}
		}
	}
}
	
function enemy_in_shadow() {

	// Check if player and surface exists
	if instance_exists(obj_player) and surface_exists(obj_player.surface_whatyoucansee) {
	
		// Check colour of pixel
		var _col = surface_getpixel_ext(obj_player.surface_whatyoucansee, x, y)
		
		// Return true if in shadow
		if _col != 0 {
			return 0
		} else {
			return 1
		}
	} else {
	
		// Return -1 if player does not exist
		return -1
	}
}

function enemy_angle_array_create_offset(_angle, _offset, _angles_amnt) {

	// Starting and ending angles of the sweep
	var _start_angle = (_angle - _offset + 360) % 360
	var _end_angle = (_angle + _offset) % 360

	// Make array
	var _angle_array = []
	
	// Sweep from start to end (account for wrap-around)
	for (var i = 0; i < _angles_amnt; i++) {
	
		var t = i / (_angles_amnt - 1)
		var _interp_angle = (_start_angle + angle_difference(_start_angle, _end_angle) * t + 360) % 360
		array_push(_angle_array, _interp_angle)
	}

	return _angle_array
}

function enemy_loop_angles(_angle_array, _check_dist) {
	
	// Loop through angles in array
	for (var i = 0; i < array_length(_angle_array); i++) {
	
		var _dx = lengthdir_x(_check_dist, _angle_array[i])
		var _dy = lengthdir_y(_check_dist, _angle_array[i])
		
		// Return false if colliding with wall or zombie
		if place_meeting(x + _dx, y + _dy, obj_hole) or place_meeting(x + _dx, y + _dy, obj_zombie) {
		
			return false
		}
	}
	
	// Return true if all checks pass
	return true
}