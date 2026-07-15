if !audio_is_playing(snd_lobby_music) and global.music_enabled audio_play_sound(snd_lobby_music, 1, 1)

var _rm_prev = global.lobby_previous_room

if _rm_prev == -1 selected = 0
	else if _rm_prev == "level_select" selected = 1
	else if _rm_prev == "settings" selected = 2
	else selected = 0

option[0] = "Play"
option[1] = "Levels"
option[2] = "Settings"
option[3] = "Quit"

op_amnt = array_length(option)