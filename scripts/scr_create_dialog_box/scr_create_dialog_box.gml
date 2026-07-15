function create_dialog_box(_text) {

	var _dialog_box = instance_create_depth(0, 0, 0, obj_dialog_box)
	
	with _dialog_box {
	
		text = _text
	}
}