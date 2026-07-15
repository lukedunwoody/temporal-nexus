var _pause_screen = noone;

for (var i = 0; i < instance_number(obj_pause_screen); i++) {
    var _inst = instance_find(obj_pause_screen, i);
    if (_inst.object_index == obj_pause_screen) {
        _pause_screen = _inst;
        break;
    }
}

if (_pause_screen != noone) {
    alpha = 1 - _pause_screen.alpha;
} else if instance_exists(obj_gameover_screen) {
    alpha = 1 - obj_gameover_screen.alpha;
} else {
    alpha = 1;
}

draw_set_alpha(alpha)
	
if room == rm_level1 or room == rm_level2 or room == rm_level3 {

	draw_set_color(#cccccc)
} else if room == rm_level4 or room == rm_level5 or room == rm_level6 {

	draw_set_color(c_black)
} else if room == rm_level7 or room == rm_level8 or room == rm_level9 {

	draw_set_color(c_aqua)
}

#region Universal Vars

var _window_height = window_get_height()

#endregion

#region Draw Ammo Number

draw_set_font(fnt_rubik_ammo)

var _ammo = 0
if instance_exists(obj_player) _ammo = obj_player.ammo

var _ammo_string = string_length(_ammo) <= 1 ? "0" + string(_ammo) : string(_ammo)

draw_set_halign(fa_right)
draw_text(237, _window_height - 238, _ammo_string)
draw_set_halign(fa_left)

#endregion

#region Bottom Layer Boxes

draw_set_alpha(.7 * alpha)

// melee box
draw_rectangle(20, _window_height - 40, 230, _window_height - 20, 0)

// weapon box
draw_rectangle(20, _window_height - 70, 230, _window_height - 50, 0)

draw_set_alpha(1 * alpha)

#endregion

#region Melee Cooldown

var _melee_percantage = 0

if instance_exists(obj_player) _melee_percantage = 1 - (obj_player.melee_timer / obj_player.melee_cooldown)
_melee_percantage = clamp(_melee_percantage, 0, 1)

draw_rectangle(20, _window_height - 40, 20 + (_melee_percantage * 210), _window_height - 20, 0)

#endregion

#region Weapon Cooldown

var _weapon_percentage = 0

if instance_exists(obj_player) _weapon_percentage = 1 - (obj_player.shoot_timer / obj_player.weapon.cooldown)
_weapon_percentage = clamp(_weapon_percentage, 0, 1)

draw_rectangle(20, _window_height - 70, 20 + (_weapon_percentage * 210), _window_height - 50, 0)

#endregion

#region Enemy Limit Text

draw_set_font(fnt_rubik)
if global.current_objective == 0 {
	draw_text(20, 20, "Current Objective: Kill Enemies " + string(global.enemy_killed) + "/" + string(global.enemy_limit))
} else if global.current_objective == 1 {

	draw_text(20, 20, "Current Objective: Obtain Plutonium")
} else if global.current_objective == 2 {

	draw_text(20, 20, "Current Objective: Cross the battle field and obtain Plutonium")
}

#endregion

draw_set_alpha(1)