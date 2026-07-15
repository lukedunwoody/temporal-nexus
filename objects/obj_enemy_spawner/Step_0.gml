if check_pause_screen() exit

if enemies_spawned >= total_enemies instance_destroy()
	
if spawn_timer <= 0 {

	spawn_timer = wait_time
	
	var _width = (sprite_get_width(spr_enemy_spawner) + 16)
	var _increment = (1 / (spawn_burst + 1)) * _width
	
	for (var i = 0; i < spawn_burst; i++) {
	
		if enemies_spawned <= total_enemies {
			
			// Local spawn position
			var local_x = (_increment * (i + 1)) - (_width / 2) // centered horizontally
			var local_y = 0 // vertical offset (in spawner's local space)
			
			// Rotate the local offset by image_angle
			var new_x = local_x * dcos(image_angle) - local_y * dsin(image_angle); // Rotate X
			var new_y = local_x * dsin(image_angle) + local_y * dcos(image_angle); // Rotate Y

			// Spawn at rotated position
			var spawn_x = x + new_x;
			var spawn_y = y + new_y;
			
			// Create the zombie
			var _inst = instance_create_depth(spawn_x, spawn_y, depth - 1, obj_zombie)
			
			_weapon_to_give = i % array_length(weapon_list)
			with _inst weapon = other.weapon_list[other._weapon_to_give]
			
			enemies_spawned++
		}
	}
}

if !place_meeting(x, y, obj_zombie) spawn_timer -= global.game_speed