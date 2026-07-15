// Get camera width and height
var _camw = camera_get_view_width(view_camera[0])
var _camh = camera_get_view_height(view_camera[0])

if !global.replay_playing {

		// Centre on player

		if instance_exists(obj_player) {

			x = obj_player.x - _camw/2
			y = obj_player.y - _camh/2
		}

		x = clamp(x, 0, room_width - _camw)
		y = clamp(y, 0, room_height - _camh)

		// Set camera pos
		camera_set_view_pos(view_camera[0], x, y)
} else {

	var frame = global.replay_data[global.replay_index];
	for (var i = 0; i < array_length(frame); i++) {
		if frame[i].obj_name == object_index {
			camera_set_view_pos(view_camera[0], frame[i].xpos, frame[i].ypos);
		}
	}
}