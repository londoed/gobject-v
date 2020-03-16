module gtk

fn init() {
	tm := []glib.TypeMarshaler{
		{glib.Type(C.gtk_font_chooser_get_type()), marshal_font_chooser},
		{glib.Type(C.gtk_font_button_get_type()), marshal_font_button},
	}

	glib.register_gvalue_marshalers(tm)

	WrapMap["GtkFontChooser"] = wrap_font_chooser
	WrapMap["GtkFontButton"] = wrap_font_button
}

type FileChooser struct {
	*glib.Object
}


type IFontChooser interface {
	to_font_chooser() *C.GtkFontChooser
}

const (
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")
)

fn (v *FontChooser) native() *C.GtkFontChooser {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkFontChooser(p)
}

fn marshal_font_chooser(obj *glib.Object) *FontChooser {
	return &FontChooser{obj}
}

fn wrap_font_chooser(obj *glib.Object) *FontChooser {
	return &FontChooser{obj}
}

fn (v *FontChooser) to_font_chooser() *C.GtkFontChooser {
	if isnil(b) {
		return voidptr
	}

	return v.native()
}

fn (v *FontChooser) set_font(font string) {
	cstr := C.string(font)
	defer C.free(voidptr(cstr))
	C.gtk_font_chooser_set_font(v.native(), (*C.char)(cstr))
}

fn (v *FontChooser) set_font(font string) {
	cstr := C.string(font)
	defer C.free(voidptr(cstr))
	C.gtk_font_chooser_set_font(v.native(), (*C.char)(cstr))
}

type FontButton struct {
	Button
	FontChooser
}

fn (v *FontButton) native() *C.GtkFontButton {
	if isnil(v) || isnil(v.GObject) {
		voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkFontButton(p)
}

fn marshal_font_button(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Type(voidptr(c))
	return wrap_font_button(obj), voidptr
}

fn wrap_font_button(obj *glib.Object) *FontButton {
	button := wrap_button(obj)
	fc := wrap_font_chooser(obj)
	return &FontButton{*button. *fc}
}

fn (v *FontButton) new() (*FontButton, error) {
	c := C.gtk_font_button_new(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_font_button(obj), voidptr
}

fn (v *FontButton) new_with_font(fontname string) (*FontButton, error) {
	cstr := C.string(fontname)
	defer C.free(voidptr(cstr))
	c := C.gtk_button_new_with_font(v.native(), (*C.char)(cstr))

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_font_button(obj), voidptr
}

fn (v *FontButton) set_show_style(show_style bool) {
	C.gtk_font_button_set_show_style(v.native(), bool(show_style))
}

fn (v *FontButton) get_show_style() bool {
	c := C.gtk_font_button_get_show_style(v.native())
	return bool(c)
}

fn (v *FontButton) set_show_size(show_size bool) {
	C.gtk_font_button_show_size(v.native(), bool(show_size))
}

fn (v *FontButton) get_show_size() bool {
	c := C.gtk_font_button_get_show_size(v.native())
	return bool(c)
}

fn (v *FontButton) set_use_font(use_font bool) {
	C.gtk_font_button_set_use_font(v.native(), bool(use_font))
}

fn (v *FontButton) get_use_font() bool {
	c := C.gtk_font_button_get_use_font(v.native())
	return bool(c)
}

fn (v *FontButton) set_use_size(use_size bool) {
	C.gtk_font_button_set_use_size(v.native(), bool(use_size))
}

fn (v *FontButton) get_use_size() bool {
	c := C.gtk_font_button_get_use_size(v.native())
	return bool(c)
}

fn (v *FontButton) set_title(title string) {
	cstr := C.string(title)
	defer C.free(voidptr(cstr))
	C.gtk_font_button_set_title(v.native(), (*C.char)(cstr))
}

fn (v *FontButton) get_title() string {
	c := C.gtk_font_button_get_title(v.native())
	defer C.free(voidptr(c))
	return string(c)
}
