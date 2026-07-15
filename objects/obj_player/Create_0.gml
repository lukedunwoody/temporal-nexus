// inputs
shoot_key = 0
throw_key = 0
melee_key = 0

move_spd = 2

aim_dir = 0

// game speed
time_override = false
time_override_timer = 0

// death
destroy = false

// weapon info

shoot_timer = 120

weapon = global.weapon_list.pistol

ammo = weapon.ammo

// melee

melee_timer = 0
melee_cooldown = 60

// shadow casting

shadow_size = 20000
surface_blur = surface_create(room_width, room_height); // how the room should look in the shadow
surface_whatyoucansee = surface_create(room_width, room_height); // the mask of what the player can see

if (!layer_exists("ShadowLayer")) {
    var layer_id = layer_create(450, "ShadowLayer");
    layer_script_begin(layer_id, scr_shadow_draw);
}

alarm[0] = 1

// sound
audio_stop_all()
time_warp_isnt = noone

global.enemy_limit = 0
global.enemy_killed = 0

global.replay_data = []

global.lobby_previous_room = -1

global.current_objective = 0

// dialog box timer
dialog_box_timer = 0
played_dialog_boxes = false