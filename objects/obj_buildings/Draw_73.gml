if room == rm_level4 {
	
	draw_sprite(spr_short_full_view, 0, 112, -16)
	draw_sprite(spr_short_full_view, 0, 112, 272)
	
	draw_sprite(spr_long_full_view, 0, 320, -16)
	draw_sprite(spr_long_full_view, 0, 320, 272)
} else if room == rm_level5 {
	
	draw_sprite(spr_long_full_view, 0, 16, 256)
	draw_sprite(spr_long_full_view, 0, 256, 256)
	draw_sprite(spr_long_full_view, 0, 496, 256)
	draw_sprite(spr_long_full_view, 0, 736, 256)
} else if room == rm_level6 {

	draw_sprite(spr_long_full_view, 0, 144, 80)
	draw_sprite(spr_long_full_view, 0, 480, 80)
	draw_sprite(spr_long_full_view, 0, 144, 240)
	draw_sprite(spr_long_full_view, 0, 480, 240)
} else if room == rm_level7 {

	draw_sprite(spr_2061_buildings, 0, 16, -16)
	draw_sprite(spr_2061_buildings, 1, 80, 32)
	draw_sprite(spr_2061_buildings, 2, 208, -48)
	draw_sprite(spr_2061_buildings, 3, 288, 16)
	draw_sprite(spr_2061_buildings, 4, 352, 32)
} else if room == rm_level8 {

	draw_sprite(spr_2061_buildings, 0, -16, 128)
	draw_sprite(spr_2061_buildings, 4, 80, 176)
	draw_sprite(spr_2061_buildings, 2, 208, 96)
	draw_sprite(spr_2061_buildings, 8, 320, 160)
} else if room == rm_level9 {

	/* draw_sprite(spr_2061_buildings, 3, 16, 64)
	draw_sprite(spr_2061_buildings, 6, 72, 32)
	draw_sprite(spr_2061_buildings, 4, 136, 80)
	draw_sprite(spr_2061_buildings, 9, 256, 48)
	draw_sprite(spr_2061_buildings, 0, 312, 32) */
	draw_sprite(spr_lobby_background_1, 0, 448, 0)
}