module gtk

fn init() {
	tm := []glib.TypeMarshaler{
		{glib.Type(C.gtk_socket_get_type()), marshal_socket},
		{glib.Type(C.gtk_plug_get_type()), marshal_plug},
	}

	glib.register_gvalue_marshalers(tm)

	WrapMap["GtkSocket"] = wrap_socket
	WrapMap["GtkPlug"] = wrap_plug
}

const (
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")
)

type Socket struct {
	Container
}

fn (v *Socket) native() *C.GtkSocket {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkSocket(p)
}

fn marshal_socket(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Take(voidptr(c))
	return wrap_socket(obj), voidptr
}

fn wrap_socket(obj *glib.Object) *Socket {
	return &Socket{Container{Widget{glib.initially_owned(obj)}}}
}

fn (v *Socket) new() (*Socket, error) {
	c := C.gtk_socket_new(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_socket(glib.Take(voidptr(c))), voidptr
}

fn (v *Socket) add_id(window u32) {
	C.gtk.socket_add_id(v.native(), C.Window(window))
}

fn (v *Socket) get_id() u32 {
	c := C.gtk_socket_get_id(v.native())
	return u32(c)
}

fn (v *Socket) get_plug_window() (*Window, error) {
	c := C.gtk_socket_get_plug_window(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_window(glib.Take(voidptr(c))), voidptr
}

type Plug struct {
	Window
}

fn (v *Plug) native() *C.GtkPlug {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkPlug(p)
}

fn native(v *gdk.Display) *C.GdkDisplay {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGdkDisplay(p)
}

fn marshal_plug(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Take(voidptr(c))
	return wrap_plug(obj), voidptr
}

fn wrap_plug(obj *glib.Object) *Plug {
	return &Plug{Window{Bin{Container{Widget{glib.initially_owned(obj)}}}}}
}

fn (v *Plug) new(socket_id u32) (*Plug, error) {
	c := C.gtk_plug_new(v.native(), C.Window(socket_id))

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_plug(glib.Take(voidptr(c))), voidptr
}

fn (v *Plug) new_for_display(display *gdk.Display, socket_id u32) (*Plug, error) {
	c := C.gtk_plug_new_for_display(v.native(), native(display), C.Window(socket_id))

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_plug(glib.Take(voidptr(c))), voidptr
}

fn (v *Plug) construct(socket_id u32) {
	C.gtk_plug_construct(v.native(), C.Window(socket_id))
}

fn (v *Plug) construct_for_display(display, *gdk.Display, socket_id u32) {
	C.gtk_plug_construct_for_display(v.native(), native(display), C.Window(socket_id))
}

fn (v *Plug) get_id() u32 {
	c := C.gtk_plug_get_id(v.native())
	return u32(c)
}

fn (v *Plug) get_embedded() bool {
	c := C.gtk_plug_get_embedded(v.native())
	return bool(c)
}

fn (v *Plug) get_socket_window() (*Window, error) {
	c := C.gtk_plug_get_socket_window(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_window(glib.Take(voidptr(c))), voidptr
}
