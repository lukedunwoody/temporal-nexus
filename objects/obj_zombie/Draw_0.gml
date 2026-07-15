if enemy_in_shadow() == 0 and pause_debounce <= 0 {

	// Draw zombie if not in shadow
	depth = -y
	draw_self()
		
	depth = -y - weapon.length
	draw_sprite_ext(weapon.sprite, 0, x, y, 1, 1, point_direction(x, y, obj_player.x, obj_player.y), c_white, 1)
} else if enemy_in_shadow() == -1 and pause_debounce <= 0 {

	// Draw zombie if player doesn't exist
	draw_self()
	
	depth = -y - weapon.length
	draw_sprite_ext(weapon.sprite, 0, x, y, 1, 1, dir, c_white, 1)
}