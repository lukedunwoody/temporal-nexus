if check_pause_screen() exit

// set sprite
sprite_index = weapon.pick_up_sprite

// float in place
float_dir += float_spd
y = ystart + dsin(float_dir)

// get collected
if (place_meeting(x, y, obj_player)) {
	obj_player.weapon = weapon
	obj_player.shoot_timer = 0
	
	if obj_player.weapon == weapon {
	
		obj_player.ammo += ammo
	} else {
	
		obj_player.ammo = ammo
	}

	var _smoke_colour = c_black
	
	if weapon == global.weapon_list.pistol then _smoke_colour = c_red else
	if weapon == global.weapon_list.shotgun then _smoke_colour = c_green else
	if weapon == global.weapon_list.throwable then _smoke_colour = c_aqua

    effect_create_depth(depth, ef_smoke, x, y, 0.3, _smoke_colour)

    instance_destroy()
}