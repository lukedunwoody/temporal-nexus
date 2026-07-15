depth = -bbox_top

spawn_timer = 5*60 // how long to wait before spawning first enemies + inst timer
total_enemies = 4 // how many total enemies will this spanwer make in total
wait_time = 5*60 // how much time in between each burst
spawn_burst = 2 // how many enemies to spawn per burst

enemies_spawned = 0

weapon_list = [

	global.weapon_list.pistol,
	global.weapon_list.shotgun,
]

_weapon_to_give = 0

if room == rm_level1 or room == rm_level2 or room == rm_level3 {

	image_index = 0
} else if room == rm_level4 or room == rm_level5 or room == rm_level6 {

	image_index = 1
} else if room == rm_level7 or room == rm_level8 or room == rm_level9 {

	image_index = 2
}