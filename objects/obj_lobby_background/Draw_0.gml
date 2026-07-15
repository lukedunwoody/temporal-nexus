// Rotate once per loop (0 to 1 normalized time)
var _time_normalized = animcurve_channel_evaluate(
    animcurve_get_channel(ac_c_lobby_gradient, "curve1"),
    (current_time % 200000) / 200000
);

// Vertex setup
var vb = vertex_create_buffer();
vertex_begin(vb, vf_color);

// Room center
var centerX = display_get_width() / 2;
var centerY = display_get_height() / 2;

// Radius large enough to cover the whole screen
var radius = point_distance(0, 0, display_get_width(), display_get_height());

// Number of segments in the circle
var segments = 8;

// Get rotation angle (0–360)
var angleDeg = lerp(0, 360, _time_normalized);

// Convert to radians
var angleRad = degtorad(angleDeg);

// Move the center point onto the edge of the circle
var pivotX = centerX + lengthdir_x(radius, angleDeg);
var pivotY = centerY + lengthdir_y(radius, angleDeg);

// Triangle fan starting at the pivot
vertex_position(vb, pivotX, pivotY);
vertex_color(vb, #0B0233, 1);

var _colors = [

	c_blue, c_purple, #32004C, c_navy, c_green
]

// Loop through circle vertices
for (var i = 0; i <= segments; i++) {
    var segAngleDeg = i * (360 / segments);
    var segX = centerX + lengthdir_x(radius, segAngleDeg);
    var segY = centerY + lengthdir_y(radius, segAngleDeg);

    // Optional: rainbow gradient
    //var seg_color = make_color_hsv((segAngleDeg + angleDeg) mod 360, 255, 255);

	var seg_color = _colors[i % array_length(_colors)]

    vertex_position(vb, segX, segY);
    vertex_color(vb, seg_color, 1);
}

// Submit and destroy buffer
vertex_end(vb);
vertex_submit(vb, pr_trianglefan, -1);
vertex_delete_buffer(vb);