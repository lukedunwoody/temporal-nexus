function create_weapon(_sprite, _bullet_obj,  _length, _cooldown, _ammo, _pick_up_sprite, _range, _spread = 0, _bullet_num = 1) constructor {

	sprite = _sprite
	length = _length
	bullet_obj = _bullet_obj
	cooldown = _cooldown
	ammo = _ammo
	pick_up_sprite = _pick_up_sprite
	range = _range
	bullet_num = _bullet_num
	spread = _spread
}

global.weapon_list = {
	
	pistol: new create_weapon(spr_pistol, obj_bullet, get_spr_length(spr_pistol), 180, 4, spr_pistol_pickup, 70),
	shotgun: new create_weapon(spr_shotgun, obj_bullet, get_spr_length(spr_shotgun), 240, 2, spr_shotgun_pickup, 30, 30, 4),
	throwable: new create_weapon(spr_throwable, noone, get_spr_length(spr_throwable), 0, 0, spr_throwable_pickup, 50, 10),
	nothing: new create_weapon(spr_nothing, 0, get_spr_length(spr_nothing), 0, 0, noone, 10),
}