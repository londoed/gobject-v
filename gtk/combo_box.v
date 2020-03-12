module gtk

fn init() {
	tm := []glib.TypeMarshaler{
		{glib.Type(C.gtk_combo_box_get_type()), marshal_combo_box},
		{glib.Type(C.gtk_combo_box_text_get_type()), marshal_combo_box_text}
	}

	glib.register_gvalue_marshalers(tm)

	WrapMap["GtkComboBox"] = wrap_combo_box
	WrapMap["GtkComboBoxText"] = wrap_combo_box_text
}

type ComboBox struct {
	Bin
	CellLayout
}

fn (v *ComboBox) native() *C.GtkComboBox {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkComboBox(p)
}

fn (v *ComboBox) to_cell_layout() *C.GtkCellLayout {
	if isnil(v) {
		return voidptr
	}

	return C.toGtkCellLayout(voidptr(v.GObject))
}

fn marshal_combo_box(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Take(voidptr(c))
	return wrap_combo_box(obj), voidptr
}

fn wrap_combo_box(obj *glib.Object) *ComboBox {
	cl := wrap_cell_layout(obj)
	return &ComboBox{Bin{Container{Widget{glib.InitiallyOwned(obj)}}}, *cl}
}

fn (v *ComboBox) new() (*ComboBox, voidptr) {
	v := C.gtk_combo_box_new()
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(v) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(v))
	return wrap_combo_box(obj), voidptr
}
