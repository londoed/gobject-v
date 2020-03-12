module gtk

fn native_gdk_rectangle(rect *gdk.Rectangle) *C.GdkRectangle {
	return &C.GdkRectangle{
		x: C.int(rect.get_x()),
		y: C.int(rect.get_y()),
		width: C.int(rect.get_width()),
		height: C.int(rect.get_height()),
	}
}

fn native_gdk_geometry(geom gdk.Geometry) *C.Gdk.Geometry {
	return &C.GdkGeometry{
		min_width: C.int(geom.get_min_width()),
		min_height: C.int(geom.get_min_height()),
		max_width: C.int(geom.get_max_width()),
		max_height: C.int(geom.get_max_height()),
		base_width: C.int(geom.get_base_width()),
		base_height: C.int(geom.get_base_height()),
		width_inc: C.int(geom.get_width_inc()),
		height_inc: C.int(geom.get_height_inc()),
		min_aspect: C.int(geom.get_min_aspect()),
		max_aspect: C.int(geom.get_max_aspect()),
		win_gravity: C.int(geom.get_win_gravity()),
	}
}
