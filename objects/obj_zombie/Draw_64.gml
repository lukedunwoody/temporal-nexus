// Minimal safe draw event for objects without one
draw_set_alpha(1);

if enemy_in_shadow() == 0 and state == 3 {

			// Convert world to GUI space
		var _camx = camera_get_view_x(view_camera[0])
		var _camy = camera_get_view_y(view_camera[0])
		var _camw = camera_get_view_width(view_camera[0])
		var _camh = camera_get_view_height(view_camera[0])

		var _guiw = display_get_gui_width()
		var _guih = display_get_gui_height()

        // Convert position
        var _gx = ((x - _camx) / _camw) * _guiw
        var _gy = ((y - _camy) / _camh) * _guih

        // Convert size (scale world size to GUI size)
        var _scalex = _guiw / _camw
        var _scaley = _guih / _camh

        // Scaled rectangle dimensions
        var _bar_w = 10 * _scalex
        var _bar_h = 3 * _scaley

		// Y offset from zombie
		var y_offset = 10 * _scaley

		// Box Bottom
		draw_set_alpha(.7)
		draw_rectangle(_gx - _bar_w, _gy - y_offset - _bar_h, _gx + _bar_w, _gy - y_offset, 0)
		draw_set_alpha(1)
		
		// Top Box
		var _charge_percentage = 1 - (melee_timer / melee_cooldown)
		draw_rectangle(_gx - (_bar_w * _charge_percentage), _gy - y_offset - _bar_h, _gx + (_bar_w * _charge_percentage), _gy - y_offset, 0)
}