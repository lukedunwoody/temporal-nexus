if (global.replay_playing) {
    var frame = global.replay_data[global.replay_index];
    array_sort(frame, function(a, b) { return a.image_depth - b.image_depth; });

    for (var i = 0; i < array_length(frame); i++) {
        var inst = frame[i];
        if inst.sprite != -1 and (inst.is_visible) {
			depth = inst.image_depth
			if inst.sprite != -1 draw_sprite_ext(inst.sprite, floor(inst.image_frame), inst.xpos, inst.ypos, inst.x_scale, inst.y_scale, inst.angle, c_white, 1);
            if (inst.has_weapon) {
				depth = inst.image_depth - 1
                if inst.weapon_sprite != -1 draw_sprite_ext(inst.weapon_sprite, 0, inst.xpos, inst.ypos, 1, 1, inst.weapon_angle, c_white, 1);
            }
        }
    }
}