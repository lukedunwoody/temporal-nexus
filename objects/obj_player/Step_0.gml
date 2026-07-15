#region Get Inputs

shoot_key = global.shoot_key
throw_key = global.throw_key
melee_key = global.melee_key

#endregion

#region Audio

#region Pause Screen

if !audio_is_playing(snd_time_warp) time_warp_isnt = noone

#endregion

if instance_exists(obj_pause_screen) {

	image_speed = 0
	global.game_speed = 0
	exit
} else {

	image_speed = 1
}

#endregion

#region Player Movement

var _horizMove = global.xaxis_left
var _vertMove = global.yaxis_left

// cool stuff ig

var _angle = point_direction(0, 0, _horizMove, _vertMove)
var _input_strength = sqrt(_horizMove*_horizMove + _vertMove*_vertMove) * 1.2
_input_strength = clamp(_input_strength, 0, 1)

global.game_speed = map(_input_strength, 0, 1, 0.1, 1)
global.move_speed = _input_strength

var _game_speed = global.game_speed

var _xspd = lengthdir_x(_input_strength, _angle)
var _yspd = lengthdir_y(_input_strength, _angle)

#endregion

#region Collisions
	
// Track leftover subpixel motion
var _move_x = _xspd * _game_speed * move_spd;
var _move_y = _yspd * _game_speed * move_spd;

if place_meeting(x + _move_x, y, obj_hole) {
	// Horizontal movement using 1-pixel sub-steps
	var move_remaining = abs(_move_x);
	var step_x = sign(_move_x);

	while (move_remaining >= 1) {
	    // Check if moving one pixel in the direction would cause a collision
	    if (place_meeting(x + step_x, y, obj_hole)) {
	        // Resolve collision: move pixel by pixel until colliding
	        // We already know that x + step_x collides, so we don't move further
	        break;
	    }
			
	    x += step_x;
	    move_remaining -= 1;
		}

    // Try moving the remaining fraction
	if (!place_meeting(x + move_remaining * step_x, y, obj_hole)) {
		x += move_remaining * step_x
	}
	
	_move_x = 0; // Done

} else {
	x += _move_x;
}

if place_meeting(x, y + _move_y, obj_hole) {
	// Vertical movement using 1-pixel sub-steps
	var move_remaining_y = abs(_move_y);
	var step_y = sign(_move_y);

	while (move_remaining_y >= 1) {
	    if (place_meeting(x, y + step_y, obj_hole)) {
	        break;
	    } else {
	        y += step_y;
	    }
	    move_remaining_y -= 1;
	}

	_move_y = 0;
} else {
	y += _move_y
}

#endregion

#region Aiming

if global.controller_enabled == 0 {
		
	aim_dir = point_direction(x, y, mouse_x, mouse_y)
}
	
if global.controller_enabled == 1 {
	
	if global.xaxis_right != 0 or global.yaxis_right != 0 {
			
		aim_dir = point_direction(0, 0, global.xaxis_right, global.yaxis_right)
	}
}

#endregion

#region Shoot Weapon

if shoot_timer > 0 shoot_timer -= _game_speed
if ammo == 0 shoot_timer = weapon.cooldown

if shoot_key and shoot_timer <= 0 and ammo > 0 {

	// audio

	if global.sfx_enabled audio_play_sound(snd_gun_shot, 0, 0)
	
	if global.sfx_enabled {
		if time_warp_isnt != noone and audio_stop_sound(time_warp_isnt)
		time_warp_isnt = audio_play_sound(snd_time_warp, 0, 0)
	}

	shoot_timer = weapon.cooldown
	
	ammo--

	var _xOffset = lengthdir_x(weapon.length, aim_dir)
	var _yOffset = lengthdir_y(weapon.length, aim_dir)
	
	var _weaponTipX = x + _xOffset
	var _weaponTipY = y + _yOffset
	
	var _spread = weapon.spread
	
	var _min_angle = other.aim_dir - _spread/2
	var _max_angle = other.aim_dir + _spread/2
	
	// create correct # of bullets
	for (var i = 0; i < weapon.bullet_num; i++) {

		var _bulletInst = instance_create_depth(_weaponTipX, _weaponTipY, depth - 100, weapon.bullet_obj)
	
		with _bulletInst {
			
			random_set_seed(current_time + current_hour + current_weekday + current_second + i)
			
			dir = irandom_range(_min_angle, _max_angle)
			
			image_angle = dir
		}
	}
	
	// create bullet vfx
	instance_create_depth(_weaponTipX, _weaponTipY, depth - 1, obj_shoot_burst)
	
	time_override = true
	time_override_timer = 15
}

#endregion

#region Throw Weapon

if throw_key and weapon != global.weapon_list.nothing {

	if global.sfx_enabled {
		if instance_exists(time_warp_isnt) instance_destroy(time_warp_isnt)
		time_warp_isnt = audio_play_sound(snd_time_warp, 0, 0, 0.6)
	}

	var _throwInst = instance_create_depth(x, y, depth - 100, obj_thrown_weapon)
	
	with _throwInst {
			
		sprite_index = other.weapon.sprite
			
		dir = other.aim_dir
		
		image_angle = dir
	}
	
	weapon = global.weapon_list.nothing
	
	ammo = 0
	
	// override time for 30s
	time_override = true
	time_override_timer = 30
}

#endregion

#region Melee Attack

if melee_timer > 0 {

	melee_timer -= _game_speed
} else {

	if melee_key {
	
		if global.sfx_enabled {
			if instance_exists(time_warp_isnt) instance_destroy(time_warp_isnt)
			time_warp_isnt = audio_play_sound(snd_time_warp, 0, 0, 0.4)
		}
	
		melee_timer = melee_cooldown
		
		var _xOffset = lengthdir_x(4, aim_dir)
		var _yOffset = lengthdir_y(3, aim_dir)
		
		var _melee_inst = instance_create_depth(x + _xOffset, y + _yOffset, depth - 20, obj_melee_attack)
		
		with _melee_inst {
		
			target_obj = obj_zombie
		
			image_angle = other.aim_dir
		}
		
		time_override = true
		time_override_timer = 15
	}
}

#endregion

#region Death

if place_meeting(x, y, obj_kill) {

	var _inst = instance_place(x, y, obj_kill)
	
	_inst.destroy = true
	
	global.game_speed = .1
	
	effect_create_depth(depth, ef_ring, x, y, 0.3, c_aqua)
	
	instance_create_depth(0, 0, 0, obj_gameover_screen)
	
	if global.sfx_enabled audio_play_sound(snd_explosion, 1, 0)

	instance_destroy()
}

if destroy {

	global.game_speed = .1
	
	instance_create_depth(0, 0, 0, obj_gameover_screen)

	effect_create_depth(depth, ef_ring, x, y, 0.3, c_aqua)

	instance_destroy()
}

#endregion

#region Time Override

if time_override_timer > 0 {

	time_override_timer -= _game_speed
} else {

	time_override = false
}

if time_override global.game_speed = 1

#endregion

#region Time Warp Audio

var _warp_pitch = map(_game_speed, 0.1, 1, 0.9, 1.1)

if time_warp_isnt != noone && global.sfx_enabled && audio_is_playing(time_warp_isnt) {
    audio_sound_pitch(time_warp_isnt, _warp_pitch);
} else {
    time_warp_isnt = noone;
}

#endregion

#region Dialog Box

if global.play_dialog_boxes {
	dialog_box_timer++;

	if room == rm_level1 {

		if dialog_box_timer == 1 create_dialog_box("Oh no! After researching a simulation from the 1920s, a glitch has teleported you in.")
		if dialog_box_timer == 2 create_dialog_box("Thankfully, your advanced armoured vehicle from the future was already there for testing.")
		if dialog_box_timer == 3 create_dialog_box("Even though it doesn't have any ammo, it was designed to thrive independently in previous years.")
		if dialog_box_timer == 4 create_dialog_box("This means you can use the weapons and ammo from the time you're in.")
		if dialog_box_timer == 5 create_dialog_box("Your vehicle is capable of traveling through time, but it needs fuel.")
		if dialog_box_timer == 6 create_dialog_box("Thankfully, plutonium has been scattered around each time period just in case.")
		if dialog_box_timer == 7 create_dialog_box("Each plutonium piece is capable of sending you forward 20 years in time, so find 9 to make it back home to 2322.")
		if dialog_box_timer == 8 create_dialog_box("But be careful. People from the past don't trust time travelers and are trying to kill you at all costs.")
		if dialog_box_timer == 9 create_dialog_box("If you kill one of them, they'll drop their weapon and ammo with it.")
		if dialog_box_timer == 10 create_dialog_box("If you're feeling lost, look at the top left of your screen to see the current objective.")
		if dialog_box_timer == 11 create_dialog_box("Use WASD to move. Aim with your mouse and click to shoot. Press E to perform a melee attack.")
		if dialog_box_timer == 12 create_dialog_box("Thanks to the vehicle's advanced pressurized weapon eject system, you can right-click to throw your weapon.")
		if dialog_box_timer == 13 create_dialog_box("The bottom left corner is your HUD. It displays useful information to help you fight.")
		if dialog_box_timer == 14 create_dialog_box("The number indicates your ammo, the top bar shows your weapon cooldown, and the bottom bar shows your melee cooldown.")

		if dialog_box_timer == 120 create_dialog_box("Oh yeah, I almost forgot to mention,")
		if dialog_box_timer == 121 create_dialog_box("Your high-tech vehicle slows down time when it's moving using situational time dilation technology.")
		if dialog_box_timer == 122 {
			create_dialog_box("You can always return to level 1 to see the tutorial again. Good luck.")
			global.play_dialog_boxes = false;
		}
	}

	if room == rm_level4 {

		if dialog_box_timer == 1 create_dialog_box("Nice! You've collected three plutonium pieces and traveled 60 years into the future. It's 1991, baby!")
		if dialog_box_timer == 2 create_dialog_box("But don't get too excited yet. These guys have made the shotgun, indicated by a green weapon.")
		if dialog_box_timer == 3 create_dialog_box("It shoots multiple bullets at the same time. It's extremely powerful. Be careful around them.")
		if dialog_box_timer == 4 {
			create_dialog_box("However, kill one of them, and it's yours. Good luck.")
			global.play_dialog_boxes = false;
		}
	}

	if room == rm_level7 {

		if dialog_box_timer == 1 create_dialog_box("Wow! You've collected six plutonium pieces! Only three more to go and you're back home.")
		if dialog_box_timer == 2 create_dialog_box("However, global warming has gotten a lot worse since 1991, so you can't see nearly as far.")
		if dialog_box_timer == 3 create_dialog_box("These guys realized you were coming after the last time, so they took all the weapons away.")
		if dialog_box_timer == 4 {
			create_dialog_box("You are currently equipped with a throwable. It doesn't shoot bullets, but you can still throw it. Good luck.")
			global.play_dialog_boxes = false;
		}
	}

	if room == rm_level10 {

		if dialog_box_timer == 60 create_dialog_box("Where am I?")
		if dialog_box_timer == 300 create_dialog_box("Hello.")
		if dialog_box_timer == 420 create_dialog_box("By meddling with time, even in a simulated environment, you unknowingly rewrote history.")
		if dialog_box_timer == 540 create_dialog_box("The small, seemingly inconsequential changes in the past created a butterfly effect, altering the timeline.")
		if dialog_box_timer == 660 create_dialog_box("The simulation wasn't just a game, it was a digital reconstruction of real history,")
		if dialog_box_timer == 720 create_dialog_box("and by manipulating it, you erased the very foundation of your own existence.")
		if dialog_box_timer == 780 create_dialog_box("Goodbye soldier.")
		if dialog_box_timer == 1000 room_goto(rm_lobby)
	}
}

#endregion