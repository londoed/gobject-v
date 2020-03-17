module gtk

const (
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")
)

type StyleProviderPriority int

const (
	STYLE_PROVIDER_PRIORITY_FALLBACK    StyleProviderPriority = C.GTK_STYLE_PROVIDER_PRIORITY_FALLBACK
	STYLE_PROVIDER_PRIORITY_THEME                             = C.GTK_STYLE_PROVIDER_PRIORITY_THEME
	STYLE_PROVIDER_PRIORITY_SETTINGS                          = C.GTK_STYLE_PROVIDER_PRIORITY_SETTINGS
	STYLE_PROVIDER_PRIORITY_APPLICATION                       = C.GTK_STYLE_PROVIDER_PRIORITY_APPLICATION
	STYLE_PROVIDER_PRIORITY_USER                              = C.GTK_STYLE_PROVIDER_PRIORITY_USER
)

type StyleContext struct {
	*glib.Object
}

fn (v *StyleContext) native() *C.GtkStyleContext {
	if isnil(v) || isnil(v.Object) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkStyleContext(p)
}

fn wrap_style_context(obj *glib.Object) *StyleContext {
	return &StyleContext{obj}
}

fn (v *StyleContext) add_class(class_name string) {
	cstr := C.string(class_name)
	defer C.free(voidptr(cstr))
	C.gtk_style_context_add_class(v.native(), (*C.char)(cstr))
}

fn (v *StyleContext) remove_class(class_name string) {
	cstr := C.string(class_name)
	defer C.free(voidptr(cstr))
	C.gtk_style_context_remove_class(v.native(), (*C.char)(cstr))
}

fn from_native_style_context(c *C.GtkStyleContext) (*StyleContext, error) {
	if isnil(c) {
		return voidptr, voidptr_err
	}

	obj := glib.Take(voidptr(c))
	return wrap_style_context(obj), voidptr
}

fn (v *Widget) get_style_context() (*StyleContext, error) {
	return from_native_style_context(C.gtk_widget_style_context(v.native()))
}

fn (v *StyleContext) get_parent() (*StyleContext, error) {
	return from_native_style_context(C.gtk_style_context_get_parent(v.native()))
}

fn (v *StyleContext) get_property(property string, state StateFlags) (interface{}, error) {
	cstr := (*C.char)(C.string(property))
	defer C.free(voidptr(cstr))

	gval C.value

	C.gtk_style_context_get_property(v.native(), cstr, C.GtkStateFlags(state), &gval)
	val := glib.value_from_native(voidptr(&gval))
	return val.value()
}

fn (v *StyleContext) get_style_property(property string) (interface{}, error) {
	cstr := (*C.char)(C.string(property))
	defer C.free(voidptr(cstr))

	gval C.value

	C.gtk_style_context_get_style_property(v.native(), cstr, &gval)
	val := glib.value_from_native(voidptr(&gval))
	return val.value()
}

fn (v *StyleContext) get_screen() (*gdk.Screen, error) {
	c := C.gtk_style_context_get_screen(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	d := &gdk.Screen{glib.Take(voidptr(c))}
	return d, voidptr
}

fn (v *StyleContext) get_state() StateFlags {
	return StateFlags(C.gtk_style_context_get_state(v.native()))
}

fn (v *StyleContext) get_color(state StateFlags) *gdk.RGBA {
	gdk_color := gdk.RGBA.new()
	C.gtk_style_context_get_color(v.native(), C.GtkStateFlags(state), (*C.GdkRGBA)(voidptr(gdk_color.native())))
	return gdk_color
}

fn (v *StyleContext) lookup_color(color_name string) (*gdk.RGBA, bool) {
	cstr := (*C.char)(C.string(color_name))
	defer C.free(voidptr(cstr))
	gdk_color := gdk.RGBA.new()
	ret := C.gtk_style_context_lookup_color(v.native(), cstr, (*C.GdkRGBA)(voidptr(gdk_color.native())))
	return gdk_color, bool(ret)
}

fn style_context_reset_widgets(v *gdk.Screen) {
	C.gtk_style_context_reset_widgets((*C.GdkScreen)(voidptr(v.native())))
}

fn (v *StyleContext) restore() {
	C.gtk_style_context_restore(v.native())
}

fn (v *StyleContext) save() {
	C.gtk_style_context_save(v.native())
}

fn (v *StyleContext) set_parent(p *StyleContext) {
	C.gtk_style_context_set_parent(v.native(), p.native())
}

fn (v *StyleContext) has_class(class_name string) bool {
	cstr := C.string(class_name)
	defer C.free(voidptr(cstr))
	return bool(C.gtk_style_context_has_class(v.native(), (*C.char)(cstr)))
}

fn (v *StyleContext) set_screen(s *gdk.Screen) {
	C.gtk_style_context_set_screen(v.native(), (*C.GdkScreen)(voidptr(s.native())))
}

fn (v *StyleContext) set_state(state StateFlags) {
	C.gtk_style_context_set_state(v.native(), C.GtkStateFlags(state))
}

type IStyleProvider interface {
	to_style_provider() *C.GtkStyleProvider
}

fn (v *StyleContext) add_provider(provider IStyleProvider, prio u32) {
	C.gtk_style_context_add_provider(v.native(), provider.to_style_provider(), C.int(prio))
}

fn add_provider_for_screen(s *gdk.Screen, provider IStyleProvider, prio u32) {
	C.gtk_style_context_add_provider_for_screen((*C.GdkScreen)(voidptr(s.native())), provider.to_style_provider(), C.int(prio))
}

fn (v *StyleContext) remove_provider(provider IStyleProvider) {
	C.gtk_style_context_remove_provider(v.native(), provider.to_style_provider())
}

fn remove_provider_for_screen(s *gdk.Screen, provider IStyleProvider) {
	C.gtk_style_context_remove_provider_for_screen((*C.GdkScreen)(voidptr(s.native(), provider.to_style_provider())))
}
