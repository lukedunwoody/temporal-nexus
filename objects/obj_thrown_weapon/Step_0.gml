if check_pause_screen() exit

var _game_speed = global.game_speed

xspd = lengthdir_x(spd, dir)
yspd = lengthdir_y(spd, dir)

x += xspd * _game_speed
y += yspd * _game_speed

if destroy instance_destroy()

if place_meeting (x, y, obj_wall) {

	destroy = true
}