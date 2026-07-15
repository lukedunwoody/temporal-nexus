// fade in
alpha += alpha_spd
alpha = clamp(alpha, 0, 1)

// restart the room
if global.shoot_key and alpha >= 1 room_restart()