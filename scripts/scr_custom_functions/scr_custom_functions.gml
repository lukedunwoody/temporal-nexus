function map(_value, _in_min, _in_max, _out_min, _out_max) {
    return (_value - _in_min) / (_in_max - _in_min) * (_out_max - _out_min) + _out_min;
}

function get_spr_length(_sprite) {

	return sprite_get_width(_sprite) - sprite_get_xoffset(_sprite)
}

function check_pause_screen() {

	if instance_exists(obj_pause_screen) {

		image_speed = 0
		return true
	} else {

		image_speed = 1
		return false
	}
}
	
function seconds(_frame) {

	return _frame * 60
}