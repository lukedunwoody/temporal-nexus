depth = -bbox_top

spawn_timer = 10*60 // how long to wait before spawning first enemies + inst timer
total_enemies = 8 // how many total enemies will this spanwer make in total
wait_time = 7*60 // how much time in between each burst
spawn_burst = 3 // how many enemies to spawn per burst

enemies_spawned = 0

weapon_list = [

	global.weapon_list.pistol,
	global.weapon_list.shotgun,
]

_weapon_to_give = 0