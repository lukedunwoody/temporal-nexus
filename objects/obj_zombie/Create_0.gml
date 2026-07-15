#region Properties

spd = .5
dir = 0
xspd = 0
yspd = 0

chase_spd = 1
patrol_spd = .5

destroy = false

#endregion

#region Weapons

weapon = global.weapon_list.pistol

ammo = weapon.ammo
range = weapon.range

#endregion

#region States

// Setup
state = 0
alarm[0] = 1

// State 1
patrol_dir = 0 // * 90 = deg

// State 2
strafe_timer = 0
strafe_dir = 0 // 0 is left, 1 is right

// State 3
melee_range = sprite_get_width(spr_melee_attack)
melee_timer = 30
melee_cooldown = 30

// State
bullet_instance = noone
distance_to_last_bullet = 0
check_state4 = false

#endregion

#region Sprites

if room == rm_level1 or room == rm_level2 or room == rm_level3 {

	sprite_index = spr_zombie_1921
} else if room == rm_level4 or room == rm_level5 or room == rm_level6 {

	sprite_index = spr_zombie_1991
} else if room == rm_level7 or room == rm_level8 or room == rm_level9 {

	sprite_index = spr_zombie_2061
}

#endregion

pause_debounce = 0