if !global.replay_playing {

    accumulated_time += global.game_speed
    if (accumulated_time >= 1) {
        var frame = [];
        with (all) {
            if (object_index != obj_replay_controller and object_index != obj_camera and persistent == false and sprite_index != -1) or object_index == obj_camera {
                var inst_data = {
                    obj_name: object_get_name(object_index),
                    xpos: x,
                    ypos: y,
                    angle: image_angle,
                    sprite: sprite_index,
                    image_frame: image_index,
                    image_depth: depth,
                    x_scale: image_xscale,
                    y_scale: image_yscale,
                    is_visible: visible,
                    has_weapon: (instance_exists(obj_player) and object_index == obj_player) or object_index == obj_zombie,
                    weapon_sprite: (instance_exists(obj_player) and object_index == obj_player) or object_index == obj_zombie ? weapon.sprite : -1,
                    weapon_angle: (instance_exists(obj_player) and object_index == obj_player) or object_index == obj_zombie ? (instance_exists(obj_player) ? (object_index == obj_player ? aim_dir : point_direction(x, y, obj_player.x, obj_player.y)) : dir) : -1,
                };
                
                array_push(frame, inst_data);
            }
        }
        
        with obj_camera {
            var _inst_data = {
                obj_name: object_index,
                xpos: x,
                ypos: y,
                sprite: sprite_index,
                image_depth: depth,
            }
            array_push(frame, _inst_data);
        }

        array_push(global.replay_data, frame);
        accumulated_time--
    }

    if global.enemy_killed >= global.enemy_limit {
        if instance_exists(obj_player) and global.current_objective == 0 {
            global.current_objective = 1

            var _x1 = global.location_1[0]
            var _y1 = global.location_1[1]
            var _x2 = global.location_2[0]
            var _y2 = global.location_2[1]

            if point_distance(obj_player.x, obj_player.y, _x1, _y1) < point_distance(obj_player.x, obj_player.y, _x2, _y2) {
                instance_create_layer(_x1, _y1, "Objects", obj_plutomium)
            } else {
                instance_create_layer(_x2, _y2, "Objects", obj_plutomium)
            }
        }
    }

} else {
    // instead of turning replay_playing off, just wrap the index
    if global.shoot_key {
        global.replay_data = [];
        global.replay_playing = false;
        global.replay_index = 0;
        global.replay_timer_started = false;
        accumulated_time = 0;
        replay_timer = 0;
		global.current_level = room_next(room)
		global.play_dialog_boxes = true
        room_goto_next();
        exit;
    }
    var total = array_length(global.replay_data);
    global.replay_index = (global.replay_index + 1) mod total;
}

// restart-timer block (unchanged wait & destroy)

if (global.replay_timer_started) {
    if (instance_exists(obj_player)) {
        if !instance_exists(obj_pause_screen) replay_timer++;
    } else {
        global.replay_timer_started = false;
    }

    if (replay_timer >= 180) {
        // destroy all non‑camera, non‑controller, non‑persistent instances
        with (all) {
            if (object_index != obj_camera
             && object_index != obj_replay_controller
             && !persistent) {
                instance_destroy();
            }
        }

        // now outside the with() call we reset our globals
        global.replay_playing       = true;
        global.replay_timer_started = false;
        global.replay_index         = 0;
        replay_timer                = 0;
    }
}