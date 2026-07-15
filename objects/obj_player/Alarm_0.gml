var _num_spawners = instance_number(obj_enemy_spawner)

with obj_zombie {

	global.enemy_limit++
}

with obj_enemy_spawner {

	global.enemy_limit += total_enemies
}