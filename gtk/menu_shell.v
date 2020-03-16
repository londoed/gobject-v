module gtk

type MenuShell struct {
	Container
}

fn (v *MenuShell) native() *C.GtkMenuShell {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkMenuShell(p)
}

fn marshal_menu_shell(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Take(voidptr(c))
	return wrap_menu_shell(obj), voidptr
}

fn wrap_menu_shell(obj *glib.Object) *MenuShell {
	return &MenuShell{Container{Widget{glib.initially_owned(obj)}}}
}

fn (v *MenuShell) append(child IMenuItem) {
	C.gtk_menu_shell_append(v.native(), child.to_widget())
}

fn (v *MenuShell) insert(child IMenuItem, position int) {
	C.gtk_menu_shell_insert(v.native(), child.to_widget(), C.int(position))
}

fn (v *MenuShell) deactivate() {
	C.gtk_menu_shell_deactivate(v.native())
}

fn (v *MenuShell) select_item(child IMenuItem) {
	C.gtk_menu_shell_select_item(v.native(), child.to_widget())
}

fn (v *MenuShell) select_first(search_sensitive bool) {
	C.gtk_menu_shell_select_first(v.native(), bool(search_sensitive))
}

fn (v *MenuShell) deselect() {
	C.gtk_menu_shell_deselect(v.native())
}

fn (v *MenuShell) activate_item(child IMenuItem, force_deactivate bool) {
	C.gtk_menu_shell_activate_item(v.native(), child.to_widget(), bool(force_deactivate))
}

fn (v *MenuShell) cancel() {
	C.gtk_menu_shell_cancel(v.native())
}

fn (v *MenuShell) set_take_focus(take_focus bool) {
	C.gtk_menu_shell_set_take_focus(v.native(), bool(take_focus))
}
