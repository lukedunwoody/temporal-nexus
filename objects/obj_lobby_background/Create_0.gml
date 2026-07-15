// 1) Start defining a new vertex format
vertex_format_begin();

// 2) Add the attributes you need
vertex_format_add_position();  // 2D position (x,y) :contentReference[oaicite:0]{index=0}
vertex_format_add_color();     // Colour + alpha

// 3) Finish and capture the format handle!
//    **This** is what you must store in global.vf_color.
vf_color = vertex_format_end();  
//                               ↑ returns the “handle” :contentReference[oaicite:1]{index=1}