#region Essential Code

if pause_debounce >= 0 pause_debounce--

// Exit step if paused
if check_pause_screen() {
	pause_debounce = 5
	exit
}

// Set game speed
var _game_speed = global.game_speed

#endregion

if state != 5 {

	#region Shadow Casting Check

	// Get strafe range
	var _range = weapon.range

	if enemy_in_shadow() == 0 {

		if point_distance(x, y, obj_player.x, obj_player.y) < melee_range {
			state = 3
		} else if point_distance(x, y, obj_player.x, obj_player.y) > _range {
			state = 0
		} else {
			state = 2
		}
	} else {

		state = 1
	}

	#endregion

	#region Find if Bullet Exists for Dodge State (4)

	// Check if a bullet exists
	bullet_instance = noone
	distance_to_last_bullet = room_width * room_height + 2

	check_state4 = false

	with obj_bullet {
    
		// Check if this bullet is closer than the last one
		if point_distance(x, y, other.x, other.y) < other.distance_to_last_bullet {
        
			other.bullet_instance = id
	    }
	
		other.check_state4 = true
	}

	with obj_thrown_weapon {
    
		// Check if this throwable is closer than the last one
		if point_distance(x, y, other.x, other.y) < other.distance_to_last_bullet {
        
			other.bullet_instance = id
	    }
	
		other.check_state4 = true
	}

	if check_state4 {
	
		var _bullet_dir = bullet_instance.dir
		var _relative_dir = point_direction(bullet_instance.x, bullet_instance.y, x, y)
		var _angle_diff = angle_difference(_bullet_dir, _relative_dir)
		var _distance_to_bullet = point_distance(x, y, bullet_instance.x, bullet_instance.y)
	
		// Define half widths:
		var _enemy_half_width = 8	// half of the 16x16 enemy
		var _bullet_half_width = 8	// half of an 8-pixel-wide bullet
	
		var _angle_buffer = 10		// how much extra angle so the enemy still dodges
	
		// Calculate each object's half-angle (in radians) as seen from the bullet:
		var _enemy_half_angle = arctan(_enemy_half_width / _distance_to_bullet);
		var _bullet_half_angle = arctan(_bullet_half_width / _distance_to_bullet);
	
		var _total_collision_angle_deg = radtodeg(_enemy_half_angle + _bullet_half_angle);

		if abs(_angle_diff) < _total_collision_angle_deg + _angle_buffer {

			state = 4
		}
	}

	#endregion
}

#region State Machine

	#region Reset State Vars
	
	if state != 2 strafe_timer = 0
	if state != 3 melee_timer = melee_cooldown
	
	#endregion

	switch(state) {

		case 0: // Chase the player
	
			#region Case 0 Code
		
			// Set speed
			spd = chase_spd
		
			// Go to player
			if instance_exists(obj_player) dir = point_direction(x, y, obj_player.x, obj_player.y)

			xspd = lengthdir_x(spd, dir)
			yspd = lengthdir_y(spd, dir)
		
			// Shoot code
			enemy_shooting()
	
			#endregion
	
		break

		case 1: // Patrol Mode
	
			#region Case 1 Code
	
			// Shoot timer doesn't go down
			shoot_timer = clamp(shoot_timer, 0, weapon.cooldown/3)
	
			// See if current direction is clear
			var _angles = enemy_angle_array_create_offset(patrol_dir * 90, 15, 3)
			var _current_dir_clear = enemy_loop_angles(_angles, 15)
	
			// Find alterive direction if current one is blocked
			if !_current_dir_clear {
	
				var _valid_dirs = []
	
				for (var i = 0; i < 4; i++) {
		
					_angles = enemy_angle_array_create_offset(i * 90, 15, 3)
					var _clear = enemy_loop_angles(_angles, 15)
			
					if _clear array_push(_valid_dirs, i)
				}
		
				// Get new patrol_dir
				if array_length(_valid_dirs) > 0 {
			
					patrol_dir = _valid_dirs[irandom(array_length(_valid_dirs) - 1)]
				} else {
		
					// Turn around if no directions work
					patrol_dir = (patrol_dir + 2) % 4
				}
			}
	
			dir = patrol_dir * 90
			spd = patrol_spd
	
			xspd = lengthdir_x(spd, dir)
			yspd = lengthdir_y(spd, dir)
	
			#endregion
	
		break
	
		case 2: // Player within range, strafe
	
			#region Case 2 Code
	
			// Set speed
			spd = chase_spd
	
			// Set max distance for strafing one way
			var _strafe_max = irandom_range(30, 70)
	
			// Find player dir
			var _player_dir = dir
			if instance_exists(obj_player) _player_dir = point_direction(x, y, obj_player.x, obj_player.y)
	
			// Strafe
			if strafe_dir == 0 {
	
				strafe_timer -= _game_speed
	
				if strafe_timer <= -_strafe_max strafe_dir = 1
				dir = (_player_dir + 270) % 360
		
			} else if strafe_dir == 1 {
	
				strafe_timer += _game_speed
	
				if strafe_timer >= _strafe_max strafe_dir = 0
				dir = (_player_dir + 90) % 360
			}
	
			xspd = lengthdir_x(spd, dir)
			yspd = lengthdir_y(spd, dir)
	
			// Shoot code
			enemy_shooting()
	
			#endregion
	
		break
	
		case 3: // Player within range, melee attack
	
			#region Case 3 Code
	
			// Stop moving when charging melee
			xspd = 0
			yspd = 0
	
			// Set dir to player postion
			dir = point_direction(x, y, obj_player.x, obj_player.y)

			// check if we should attack
			if melee_timer > 0 {

				melee_timer -= _game_speed
			} else {
	
				melee_timer = melee_cooldown
		
				var _xOffset = lengthdir_x(4, dir)
				var _yOffset = lengthdir_y(3, dir)
		
				var _melee_inst = instance_create_depth(x + _xOffset, y + _yOffset, depth - 20, obj_melee_attack)
		
				with _melee_inst {
		
					target_obj = obj_player
		
					image_angle = other.dir
				}
			}
	
			#endregion
	
		break
	
		case 4: // Dodge Bullet
	
		#region Case 4 Code
	
		// Set speed
		spd = chase_spd
	
		// If relative dir is greater, we want to travel right realtive to facing the bullet
		var _relative_dir_from_enemy = point_direction(x, y, bullet_instance.x, bullet_instance.y)
	
		var _bullet_dir = bullet_instance.dir
		var _angle_offset = angle_difference(_bullet_dir, _relative_dir_from_enemy)
		var dodge_dir = (_bullet_dir + (sign(_angle_offset) * 90) + 360) % 360
	
		xspd = lengthdir_x(spd, dodge_dir)
		yspd = lengthdir_y(spd, dodge_dir)
	
		// Shoot code
		enemy_shooting()
	
		#endregion
	
		break
		
		case 5:
		
		enemy_shooting(.5)
		
		break
	}

#endregion

#region Collisions

	#region Wall Collisions

	// Horizontal
	if xspd != 0 and place_meeting(x + xspd, y, obj_hole) {

		var _pixel = sign(xspd)
		var _x = (_pixel > 0) ? floor(x) : ceil(x)
	
		while !place_meeting(_x + _pixel, y, obj_hole) _x += _pixel
	
		x = _x
		xspd = 0
	}

	// Vertical
	if yspd != 0 and place_meeting(x, y + yspd, obj_hole) {

		var _pixel = sign(yspd)
		var _y = (_pixel > 0) ? floor(y) : ceil(y)
	
		while !place_meeting(x, _y + _pixel, obj_hole) _y += _pixel
	
		y = _y
		yspd = 0
	}
	
	#endregion

	#region Enemy Collisions

	if xspd != 0 and place_meeting(x + xspd, y, obj_zombie) xspd = 0
	if yspd != 0 and place_meeting(x, y + yspd, obj_zombie) yspd = 0

	#endregion

// Commit to movement

x += xspd * _game_speed
y += yspd * _game_speed

#endregion

#region Death

// Destroy if true
if destroy {

	global.enemy_killed++
	
	// Create a weapon pickup
	var _pickup = instance_create_depth(x, y, 50, obj_weapon_pickup)
	
	with _pickup {
	
		weapon = other.weapon
		ammo = other.ammo
	}

	// Create effects
	effect_create_depth(depth, ef_ring, x, y, 0.3, c_aqua)
	if global.sfx_enabled audio_play_sound_at(snd_explosion, x, y, 0, 32, 512, 1.5, 0, 0, 0.8)
	
	instance_destroy()
}

if place_meeting(x, y, obj_kill_enemy) {

	// Destroy bullet
	var _inst = instance_place(x, y, obj_kill_enemy)
	_inst.destroy = true

	// Set destroy to true
	destroy = true
}

#endregion