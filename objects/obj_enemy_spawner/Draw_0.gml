var _alpha = (150 - clamp(spawn_timer, 0, 150)) / 150
draw_sprite_ext(spr_enemy_spawner, -1, x, y, 1, 1, image_angle, c_white, _alpha)