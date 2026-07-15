depth = 450

if !surface_exists(surface_whatyoucansee) surface_whatyoucansee = surface_create(room_width, room_height)

surface_set_target(surface_whatyoucansee)

draw_clear_alpha(c_black,1) // make the whole surface black

gpu_set_blendmode(bm_subtract) // remove all the places the player can see

with(obj_wall)
{
    // draw_shadows
	
	draw_set_colour(c_black)

    draw_primitive_begin(pr_trianglestrip)
    
	draw_find_shadows(other.bbox_left + 1, other.bbox_top + 1, other.shadow_size)
	draw_find_shadows(other.bbox_left + 1, other.bbox_bottom - 1, other.shadow_size)
	draw_find_shadows(other.bbox_right - 1, other.bbox_top + 1, other.shadow_size)
	draw_find_shadows(other.bbox_right - 1, other.bbox_bottom - 1, other.shadow_size)

    draw_primitive_end()
}

// reset everything 
gpu_set_blendmode(bm_normal)
surface_reset_target();

if (!surface_exists(surface_blur)) {surface_blur = surface_create(room_width, room_height); }

surface_set_target(surface_blur)

// darken:
draw_set_alpha(0.15) // 0.15
draw_set_colour(c_black)
draw_rectangle(0,0,room_width,room_height,false)
draw_set_alpha(1)

gpu_set_blendmode(bm_subtract)

draw_surface(surface_whatyoucansee,0,0) // use blend mode subtract to cut the lighting mask out of the surface we blurred up 

gpu_set_blendmode(bm_normal)

surface_reset_target(); // reset everything 

draw_surface(surface_blur,0,0)

depth = -y
draw_self()

depth = -y - weapon.length
draw_sprite_ext(weapon.sprite, 0, x, y, 1, 1, aim_dir, c_white, 1)