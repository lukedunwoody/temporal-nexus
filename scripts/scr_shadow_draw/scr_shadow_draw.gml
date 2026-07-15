function shadow_draw() {
    if (!variable_global_exists("shadow_surface_blur")) return;
    if (!surface_exists(global.shadow_surface_blur)) return;

    draw_surface(global.shadow_surface_blur, 0, 0);
}