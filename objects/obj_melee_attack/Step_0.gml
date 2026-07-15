if check_pause_screen() exit

if place_meeting(x, y, target_obj) {

	var _target_inst = instance_place(x, y, target_obj)
	
	with _target_inst {
	
		destroy = true
	}
}