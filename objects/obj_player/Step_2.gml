var _last_bullet_dist = 999
var _bullet_amnt = instance_number(obj_bullet)

for (var i = 0; i < _bullet_amnt; i++) {

	var _inst = instance_find(obj_bullet, i)
	
	if point_distance(x, y, _inst.x, _inst. y) < _last_bullet_dist
		_last_bullet_dist = point_distance(x, y, _inst.x, _inst. y)
}

if _last_bullet_dist < 100 {

	if !audio_is_playing(time_warp_isnt) and global.sfx_enabled time_warp_isnt = audio_play_sound(snd_time_warp, 0, 0, 0.3)
	
	var _pitch = map(_last_bullet_dist, 1, 100, 0.8, 1.2)
	
	if global.sfx_enabled audio_sound_pitch(time_warp_isnt, _pitch)
}