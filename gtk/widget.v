module gtk

const (
	voidptr_err := error('[!] ERROR: cgo returned unexpected nil pointer')
)

type Widget struct {
	glib.InitiallyOwned
}

type IWidgetable interface {
	to_widget() *C.GtkWidget
}

fn nullable_widget(v IWidgetable) *C.GtkWidget {
	if isnil(v) {
		return voidptr
	}

	return v.to_widget()
}

fn (v *Widget) native() *C.GtkWidget {
	if isnil(v) || isnil(v.GObject) {
		voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkWidget(p)
}

fn (v *Widget) to_widget() *C.GtkWidget {
	if isnil(v) {
		return voidptr
	}

	return v.native()
}

fn marshal_widget(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Take(voidptr(c))
	return wrap_widget(obj), voidptr
}

fn wrap_widget(obj *glib.Object) *Widget {
	return &Widget{glib.InitiallyOwned{obj}}
}

fn (v *Widget) destroy() {
	C.gtk_widget_destroy(v.native())
}

fn (v *Widget) hide_on_delete() {
	C._gtk_widget_hide_on_delete(v.native())
}

fn (v *Widget) queue_draw_area(x, y, w, h int) {
	C.gtk_widget_queue_draw_area(v.native(), C.int(x), C.int(y), C.int(w), C.int(h))
}

fn (v *Widget) get_screen() (*gdk.Screen, error) {
	c := C.gtk_widget_get_screen(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	s := &gdk.Screen{glib.Take(voidptr(c))}
	return s, voidptr
}

fn (v *Widget) drag_dest_set(flags DestDefaults, targets []TargetEntry, actions gdk.DragAction) {
	C.gtk_drag_dest_set(v.native(), C.GtkDestDefaults(flags), (*C.GtkTargetEntry)(&targets[0]), C.int(targets.len), C.GdkDragAction(actions))
}

fn (v *Widget) drag_source_set(start_button_mask gdk.ModifierType, targets []TargetEntry, actions gdk.DragAction) {
	C.gtk_drag_source_set(v.native(), C.GdkModifierType(start_button_mask), (*C.GtkTargetEntry)(&target[0]), C.int(targets.len), C.GdkDragAction(actions))
}

fn (v *Widget) reset_style() {
	C.gtk_widget_reset_style(v.native())
}

fn (v *Widget) in_destruction() bool {
	return bool(C.gtk_widget_in_destruction(v.native()))
}

fn (v *Widget) unparent() {
	C.gtk_widget_unparent(v.native())
}

fn (v *Widget) show() {
	C.gtk_widget_show(v.native())
}

fn (v *widget) hide() {
	C.gtk_widget_hide(v.native())
}

fn (v *Widget) get_can_focus() bool {
	c := C.gtk_widget_get_can_focus(v.native())
	return bool(c)
}

fn (v *Widget) set_can_focus(can_focus bool) {
	C.gtk_widget_set_can_focus(v.native(), C.boolean(can_focus))
}

fn (v *Widget) get_can_default() bool {
	c := C.gtk_widget_get_can_default(v.native())
	return bool(c)
}

fn (v *Widget) set_can_default(can_default bool) {
	C.gtk_widget_set_can_default(v.native(), C.boolean(can_default))
}

fn (v *Widget) set_mapped(mapped bool) {
	C.gtk_widget_set_mapped(v.native(), C.boolean(mapped))
}

fn (v *Widget) get_mapped() bool {
	c := C.gtk_widget_get_mapped(v.native())
	return bool(c)
}

fn (v *Widget) insert_action_group(name string, group glib.IActionGroup) {
	C.gtk_widget_insert_action_group(v.native(), (*C.char)(C.string(name)), C.toGActionGroup(voidptr(group.native())))
}

fn (v *Widget) get_preferred_height() (int, int) {
	minimum, natural C.int
	C.gtk_widget_get_preferred_height(v.native(), &minimum, &natural)
	return int(minimum), int(natural)
}

fn (v *Widget) get_halign() Align {
	c := C.gtk_widget_get_halign(v.native())
	return Align(c)
}

fn (v *Widget) set_halign(align Align) {
	C.gtk_widget_set_halign(v.native(), C.GtkAlign(align))
}

fn (v *Widget) get_valign() Align {
	c := C.gtk_widget_get_valign(v.native())
	return Align(c)
}

fn (v *Widget) set_valign(align Align) {
	C.gtk_widget_set_valign(v.native(), C.GtkAlign(align))
}

fn (v *Widget) get_margin_top() int {
	c := C.gtk_widget_get_margin_top(v.native())
	return int(c)
}

fn (v *Widget) set_margin_top(margin int) {
	C.gtk_widget_set_margin_top(v.native(), C.int(margin))
}

fn (v *Widget) get_margin_bottom() int {
	C.gtk_widget_get_margin_bottom(v.native())
	return int(c)
}

fn (v *Widget) set_margin_bottom(margin int) {
	C.gtk_widget_set_margin_bottom(v.native(), C.int(margin))
}

fn (v *Widget) get_hexpand() bool {
	c := C.gtk_widget_get_hexpand(v.native())
	return bool(c)
}

fn (v *Widget) set_hexpand(expand bool) {
	C.gtk_widget_set_hexpand(v.native(), C.boolean(expand))
}

fn (v *Widget) get_vexpand() bool {
	c := C.gtk_widget_get_vexpand(v.native())
	return bool(c)
}

fn (v *Widget) set_vexpand(expand bool) {
	C.gtk_widget_set_vexpand(v.native(), C.boolean(expand))
}

fn (v *Widget) get_realized() bool {
	c := C.gtk_widget_get_realized(v.native())
	return bool(c)
}

fn (v *Widget) set_realized(realized bool) {
	C.gtk_widget_set_realized(v.native(), C.boolean(realized))
}

fn (v *Widget) get_has_window() bool {
	c := C.gtk_widget_get_has_window(v.native())
	return bool(c)
}

fn (v *Widget) set_has_window(has_window bool) {
	C.gtk_widget_set_has_window(v.native(), C.boolean(has_window))
}

fn (v *Widget) show_now() {
	C.gtk_widget_show_now(v.native())
}

fn (v *Widget) show_all() {
	C.gtk_widget_show_all(v.native())
}

fn (v *Widget) set_no_show_all(no_show_all bool) {
	C.gtk_widget_set_no_show_all(v.native(), C.boolean(no_show_all))
}

fn (v *Widget) get_no_show_all() bool {
	c := C.gtk_widget_get_no_show_all(v.native())
	return bool(c)
}

fn (v *Widget) map() {
	C.gtk_widget_map(v.native())
}

fn (v *Widget) unmap() {
	C.gtk_widget_unmap(v.native())
}

fn (v *Widget) event(event *gdk.Event) bool {
	c := C.gtk_widget_event(v.native(), (*C.GdkEvent)(voidptr(event.native())))
	return bool(c)
}

fn (v *Widget) activate() bool {
	return bool(C.gtk_widget_activate(v.native()))
}

fn (v *Widget) intersect(area gdk.Rectangle) (*gdk.Rectangle, bool) {
	mut c_rect := *C.GdkRectangle{}
	had_intersection := C.gtk_widget_intersect(v.native(), native_gdk_rectangle(area), c_rect)
	intersection := gdk.wrap_rectangle(byteptr(voidptr(c_rect)))
	return intersection, bool(had_intersection)
}

fn (v *Widget) is_focus() bool {
	return bool(C.gtk_widget_is_focus(v.native()))
}

fn (v *Widget) grab_focus() {
	C.gtk_widget_grab_focus(v.native())
}

fn (v *Widget) grab_default() {
	C.gtk_widget_grab_default(v.native())
}

fn (v *Widget) set_name(name string) {
	cstr := C.string(name)
	defer C.free(voidptr(cstr))
	C.gtk_widget_set_name(v.native(), (*C.char)(cstr))
}

fn (v *Widget) get_name() (string, error) {
	c := C.gtk_widget_get_name(v.native())

	if isnil(c) {
		return '', voidptr_err
	}

	return string((*C.char)(c)), voidptr
}

fn (v *Widget) get_sensitive() bool {
	c := C.gtk_widget_get_sensitive(v.native())
	return bool(c)
}

fn (v *Widget) is_sensitive() bool {
	c := C.gtk_widget_is_sensitive(v.native())
	return bool(c)
}

fn (v *Widget) set_sensitive(sensitive bool) {
	C.gtk_widget_set_sensitive(v.native(), C.boolean(sensitive))
}

fn (v *Widget) get_visible() bool {
	c := C.gtk_widget_get_visible(v.native())
	return bool(c)
}

fn (v *Widget) set_visible(visible bool) {
	C.gtk_widget_set_visible(v.native(), C.boolean(visible))
}

fn (v *Widget) set_parent(parent IWidget) {
	C.gtk_widget_set_parent(v.native(), parent.to_widget())
}

fn (v *Widget) get_parent() (*Widget, error) {
	c := C.gtk_widget_get_parent(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_widget(glib.Take(voidptr(c))), voidptr
}

fn (v *Widget) set_size_request(width, height int) {
	C.gtk_widget_set_size_request(v.native(), C.int(width), C.int(height))
}

fn (v *Widget) get_size_request() (width, height int) {
	mut w, h := 0
	C.gtk_widget_get_size_request(v.native, &w, &h)
	return int(w), int(h)
}

fn (v *Widget) set_parent_window(parent_window *gdk.Window) {
	C.gtk_widget_set_parent_window(v.native(), (*C.GdkWindow)(voidptr(parent_window.native())))
}

fn (v *Widget) get_parent_window() (*gdk.Window, error) {
	c := C.gtk_widget_get_parent_window(v.native())

	if isnil(v) {
		return voidptr, voidptr_err
	}

	w := &gdk.Window{glib.Take(voidptr(c))}
	return w, voidptr
}

fn (v *Widget) set_events(events int) {
	C.gtk_widget_set_events(v.native(), C.int(events))
}

fn (v *Widget) get_events() int {
	return int(C.gtk_widget_get_events(v.native()))
}

fn (v *Widget) add_events(events int) {
	C.gtk_widget_add_events(v.native(), C.int(events))
}

fn (v *Widget) freeze_child_notify() {
	C.gtk_widget_freeze_child_notify(v.native())
}

fn (v *Widget) thaw_child_notify() {
	C.gtk_widget_thaw_child_notify(v.native())
}

fn (v *Widget) has_default() bool {
	c := C.gtk_widget_has_default(v.native())
	return bool(c)
}

fn (v *Widget) has_focus() bool {
	c := C.gtk_widget_has_focus(v.native())
	return bool(c)
}

fn (v *Widget) has_visible_focus() bool {
	c := C.gtk_widget_has_visible_focus(v.native())
	return bool(c)
}

fn (v *Widget) has_grab() bool {
	c := C.gtk_widget_has_grab(v.native())
	return bool(c)
}

fn (v *Widget) is_drawable() bool {
	c := C.gtk_widget_is_drawable(v.native())
	return bool(c)
}

fn (v *Widget) is_toplevel() bool {
	c := C.gtk_widget_is_toplevel(v.native())
	return bool(c)
}

fn (v *Widget) set_device_enabled(device *gdk.Device) bool {
	c := C.gtk_widget_get_device_enabled(
		v.native(),
		(*C.GdkDevice)(voidptr(device.native()))
	)

	return bool(c)
}

fn (v *Widget) get_device_enabled(device *gdk.Device) bool {
	c := C.gtk_widget_get_device_enabled(
		v.native(),
		(*C.GdkDevice)(voidptr(device.native()))
	)

	return bool(c)
}

fn (v *Widget) get_toplevel() (*Widget, error) {
	c := C.gtk_widget_get_toplevel(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_widget(glib.Take(voidptr(c))), voidptr
}

fn (v *Widget) get_tooltip_market() (string, error) {
	c := C.gtk_widget_get_tooltip_markup(v.native())

	if isnil(c) {
		return '', voidptr_err
	}

	return C.string((*C.char)(c)), voidptr
}

fn (v *Widget) set_tooltip_markup(text string) {
	cstr := C.string(text)
	defer C.free(voidptr(cstr))
	C.gtk_widget_set_tooltip_markup(v.native(), (*C.char)(cstr))
}

fn (v *Widget) get_tooltip_text() (string, error) {
	c := C.gtk_widget_get_tooltip_text(v.native())

	if isnil(c) {
		return '', voidptr
	}

	return C.string((*C.char)(c)), voidptr
}

fn (v *Widget) set_tooltip_text(text string) {
	cstr := C.string(text)
	defer C.free(voidptr(cstr))
	C.gtk_widget_set_tooltip_text(v.native(), (*C.char)(cstr))
}

fn (v *Widget) translate_coordinates(dest IWidget, src_x, src_y int) (dest_x, dest_y int, e error) {
	cdest := nullable_widget(dest)
	mut cdest_x, cdest_y := 0
	c := C.gtk_widget_translate_coordinates(v.native(), cdest, C.int(src_x), C.int(src_y), &cdest_x, &cdest_y)

	if !bool(c) {
		return 0, 0, voidptr_err
	}

	return int(cdest_x), int(cdest_y), voidptr
}

fn (v *Widget) set_visual(visual *gdk.Visual) {
	C.gtk_widget_set_visual(
		v.native(),
		(*C.GdkVisual)(voidptr(visual.native()))
	)
}

fn (v *Widget) set_app_paintable(paintable bool) {
	C.gtk_widget_set_app_paintable(v.native(), C.boolean(paintable))
}

fn (v *Widget) get_app_paintable() bool {
	c := C.gtk_widget_get_app_paintable(v.native())
	return bool(c)
}

fn (v *Widget) queue_draw() {
	C.gtk_widget_queue_draw(v.native())
}

fn (v *Widget) get_allocation() *Allocation {
	mut a := Allocation{}
	C.gtk_widget_get_allocation(v.native(), a.native())
	return &a
}

fn (v *Widget) set_allocation(allocation *Allocation) {
	C.gtk_widget_set_allocation(v.native(), allocation.native())
}

fn (v *Widget) size_allocation(allocation *Allocation) {
	C.gtk_widget_size_allocation(v.native(), allocation.native())
}

fn (v *Widget) set_state_flags(state_flags StateFlags, clear bool) {
	C.gtk_widget_set_state_flags(v.native(), C.GtkStateFlags(state_flags), C.boolean(clear))
}

fn (v *Widget) get_window() (*gdk.Window, error) {
	c := C.gtk_widget_get_window(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	w := &gdk.Window{glib.Take(voidptr(c))}
	return w, voidptr
}

type Allocation struct {
	gdk.Rectangle
}

fn (v *Allocation) native() *C.GtkAllocation {
	return (*C.GtkAllocation)(voidptr(&v.GdkRectangle))
}

fn (v *Widget) get_allocated_width() int {
	return int(C.gtk_widget_get_allocated_width(v.native()))
}

fn (v *Widget) get_allocated_height() int {
	return int(C.gtk_widget_get_allocated_height(v.native()))
}
