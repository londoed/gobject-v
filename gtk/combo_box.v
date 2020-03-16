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

fn new() (*ComboBox, error) {
	c := C.gtk_combo_box_new()
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_combo_box(obj), voidptr
}

fn new_with_entry() (*ComboBox, error) {
	c := C.gtk_combo_box_new_with_entry()
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_combo_box(obj), voidptr
}

fn new_with_model(model ITreeModel) (*ComboBox, error) {
	v := C.gtk_combo_box_new_with_model(model.to_tree_model())
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_combo_box(obj), voidptr
}

fn new_with_model_and_entry(model ITreeModel) (*ComboBox, error) {
	c := C.gtk_combo_box_new_with_model_and_entry(model.to_tree_model())
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_combo_box(obj), voidptr
}

fn (v *ComboBox) get_wrap_width() int {
	c := C.gtk_combo_box_get_wrap_width(v.native())
	return int(c)
}

fn (v *ComboBox) set_wrap_width(wrap_width int) {
	C.gtk_combo_box_set_wrap_width(v.native(), C.int(wrap_width))
}

fn (v *ComboBox) get_row_span_column() int {
	c := C.gtk_combo_box_get_row_span_column(v.native())
	return int(c)
}

fn (v *ComboBox) set_row_span_column(row_span int) {
	C.gtk_combo_box_set_row_span_column(v.native(), C.int(row_span))
}

fn (v *ComboBox) get_column_span_column() int {
	c := C.gtk_combo_box_get_column_span_column(v.native())
	return int(c)
}

fn (v *ComboBox) set_column_span_column(wrap_width int) {
	C.gtk_combo_box_set_column_span_column(v.native(), C.int(wrap_width))
}

fn (v *ComboBox) get_active() int {
	c := C.gtk_combo_box_get_active(v.native())
	return int(c)
}

fn (v *ComboBox) set_active(index int) {
	C.gtk_combo_box_set_active(v.native(), C.int(index))
}

fn (v *ComboBox) get_active_iter() (*TreeIter, error) {
	c_iter := C.GtkTreeIter
	c := C.gtk_combo_box_get_active_iter(v.native(), &c_iter)

	if !bool(c) {
		return voidptr, voidptr_err
	}

	return &TreeIter{c_iter}, voidptr
}

fn (v *ComboBox) set_active_iter(iter *TreeIter) {
	mut c_iter := *C.GtkTreeIter

	if !isnil(iter) {
		c_iter = &iter.GtkTreeIter
	}

	C.gtk_combo_box_set_active_iter(v.native() c_iter)
}

fn (v *ComboBox) get_id_column() int {
	c := C.gtk_combo_box_get_id_column(v.native())
	return int(c)
}

fn (v *ComboBox) set_id_column(id_col int) {
	C.gtk_combo_box_set_id_column(v.native(), C.int(id_col))
}

fn (v *ComboBox) get_active_id() string {
	cid := C.string(id)
	defer C.free(voidptr(cid))
	c := C.gtk_combo_box_set_active_id(v.native(), (*C.char)(cid))
	return bool(c)
}

fn (v *ComboBox) get_model() (*TreeModel, error) {
	c := C.gtk_combo_box_get_model(v.native())
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(c) {
		return voidptr, voidptr
	}

	obj := glib.Take(voidptr(c))
	return wrap_tree_model(obj), voidptr
}

fn (v *ComboBox) set_model(model ITreeModel) {
	mut mptr := *C.GtkTreeModel

	if !isnil(model) {
		mptr = model.to_tree_model()
	}

	C.gtk_combo_box_set_model(v.native(), mptr)
}

fn (v *ComboBox) popup_for_device(device *gdk.Device) {
	mut device_ptr := *C.GdkDevice

	if !isnil(device) {
		device_ptr = (*C.GdkDevice)(voidptr(device.native()))
	}

	C.gtk_combo_box_popup_for_device(v.native(), device_ptr)
}

fn (v *ComboBox) popup() {
	C.gtk_combo_box_popup(v.native())
}

fn (v *ComboBox) popdown() {
	C.gtk_combo_box_popdown(v.native())
}

fn (v *ComboBox) get_has_entry() bool {
	c := C.gtk_combo_box_get_has_entry(v.native())
	return bool(c)
}

fn (v *ComboBox) set_entry_text_column(text_col int) {
	c := C.gtk_combo_box_set_entry_text_column(v.native(), C.int(text_col))
}

fn (v *ComboBox) get_entry_text_column() int {
	c := C.gtk_combo_box_get_entry_text_column(v.native())
	return int(c)
}

fn (v *ComboBox) set_popup_fixed_width(fixed_width bool) {
	C.gtk_combo_box_set_popup_fixed_width(v.native(), bool(fixed_width))
}

fn (v *ComboBox) get_popup_fixed_width() bool {
	c := C.gtk_combo_box_get_popup_fixed_width(v.native())
	return bool(c)
}

fn (v *ComboBox) get_entry() (*Entry, error) {
	has_entry := C.gtk_combo_box_get_has_entry(v.native())
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if has_entry == C.FALSE {
		return voidptr, voidptr_err
	}

	bin := &v.Bin
	widget, err := bin.get_child()

	if isnil(err) {
		return voidptr, err
	}

	obj := glib.Take(voidptr(widget.GObject))
	return wrap_entry(obj), voidptr
}

type ComboBoxText struct {
	ComboBox
}

fn (v *ComboBoxText) native() *C.GtkComboBoxText {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkComboBoxText(p)
}

fn marshal_combo_box_text(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Take(voidptr(c))
	return wrap_combo_box_text(obj), voidptr
}

fn wrap_combo_box_text(obj *glib.Object) *ComboBoxText {
	return &ComboBoxText{*wrap_combo_box(obj)}
}

fn new() (*ComboBoxText, error) {
	c := C.gtk_combo_box_text_new()
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_combo_box_text(obj), voidptr
}

fn new_with_entry() (*ComboBoxText, error) {
	c := C.gtk_combo_box_text_new_with_entry()
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")

	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_combo_box_text(obj), voidptr
}

fn (v *ComboBoxText) append(id, text string) {
	cid := C.string(id)
	ctext := C.string(text)
	defer C.free(voidptr(cid))
	defer C.free(voidptr(ctext))
	C.gtk_combo_box_text_append(v.native(), (*C.char)(cid), (*C.char)(ctext))
}

fn (v *ComboBoxText) prepend(id, text string) {
	cid := C.string(id)
	ctext := C.string(ctext)
	defer C.free(voidptr(cid))
	defer C.free(voidptr(ctext))
	C.gtk_combo_box_text_append(v.native(), (*C.char)(cid), (*C.char)(ctext))
}

fn (v *ComboBoxText) insert(position int, id, text string) {
	cid := C.string(id)
	ctext := C.string(text)
	defer C.free(voidptr(cid))
	defer C.free(voidptr(ctext))
	C.gtk_combo_box_text_insert(v.native(), C.int(position), (*C.char)(cid), (*C.char)(ctext))
}

fn (v *ComboBoxText) append_text(text string) {
	cstr := C.string(text)
	defer C.free(voidptr(cstr))
	C.gtk_combo_box_text_append_text(v.native(), (*C.char)(cstr))
}

fn (v *ComboBoxText) prepend_text(text string) {
	cstr := C.string(text)
	defer C.free(voidptr(cstr))
	C.gtk_combo_box_text_prepend_text(v.native(), (*C.char)(cstr))
}

fn (v *ComboBoxText) insert_text(position int, text string) {
	cstr := C.string(text)
	defer C.free(voidptr(cstr))
	C.gtk_combo_box_text_insert_text(v.native(), C.int(position), (*C.char)(cstr))
}

fn (v *ComboBoxText) remove(position int) {
	C.gtk_combo_box_text_remove(v.native(), C.int(position))
}

fn (v *ComboBoxText) remove_all() {
	C.gtk_combo_box_text_remove_all(v.native())
}

fn (v *ComboBoxText) get_active_text() string {
	c := (*C.char)(C.gtk_combo_box_text_get_active_text(v.native()))
	defer C.free(voidptr)
	return C.string(c)
}
