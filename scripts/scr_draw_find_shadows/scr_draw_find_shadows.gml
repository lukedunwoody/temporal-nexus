function draw_find_shadows(_x, _y, _shadow_size) {

    draw_vertex(bbox_left, bbox_top)
    var _dir = point_direction(_x, _y, bbox_left, bbox_top)
    draw_vertex(x + lengthdir_x(_shadow_size, _dir), y + lengthdir_y(_shadow_size, _dir))

    draw_vertex(bbox_left, bbox_bottom)
    _dir = point_direction(_x, _y, bbox_left, bbox_bottom)
    draw_vertex(x + lengthdir_x(_shadow_size, _dir), y + lengthdir_y(_shadow_size, _dir))

    draw_vertex(bbox_right, bbox_top)
    _dir = point_direction(_x, _y, bbox_right, bbox_top)
    draw_vertex(x + lengthdir_x(_shadow_size, _dir), y + lengthdir_y(_shadow_size, _dir))

    draw_vertex(bbox_right, bbox_bottom)
    _dir = point_direction(_x, _y, bbox_right, bbox_bottom)
    draw_vertex(x + lengthdir_x(_shadow_size, _dir), y + lengthdir_y(_shadow_size, _dir))
}