module gtk

type ApplicationInhibitFlags int

const (
  APPLICATION_INHIBIT_LOGOUT ApplicationInhibitFlags = C.GTK_APPLICATION_INHIBIT_LOGOUT
  APPLICATION_INHIBIT_SWITCH ApplicationInhibitFlags = C.GTK_APPLICATION_INHIBIT_SWITCH
  APPLICATION_INHIBIT_SUSPEND ApplicationInhibitFlags = C.GTK_APPLICATION_INHIBIT_SUSPEND
  APPLICATION_INHIBIT_IDLE ApplicationInhibitFlags = C.GTK_APPLICATION_INHIBIT_IDLE
)

type Application struct {
  glib.Application
}

fn (v *Application) native() *C.GtkApplication {
  if isnil(v) && isnil(v.GObject) {
    return nil
  }

  return C.toGtkApplication(voidptr(v.GObject))
}

fn marshal_application(p byteptr) (interface{}, error) {
  c := C.g_value_get_object(*C.GValue)(voidptr(p))
  obj := glib.take(voidptr(c))
  return wrap_application(obj), nil
}

fn new(app_id string, flags glib.ApplicationFlags) (*Application, error) {
  cstr := (*C.gchar)(C.string(app_id))
  defer C.free(voidptr(cstr))

  c := C.gtk_application_new(cstr, C.GApplicationFlags(flags))

  if isnil(c) {
    return nil, voidptr
  }

  return wrap_application(glib.take(voidptr(c))), nil
}

fn (v* Application) add_window(w IWindow) {
  C.gtk_application_add_window(v.native(), w.to_window())
}

fn (v *Application) remove_window(w IWindow) {
  C.gtk_application_remove_window(v.native(), w.to_window())
}

fn (v *Application) get_window_by_id(id uint) *Window {
  c := C.gtk_application_get_window_by_id(v.native(), C.uint(id))

  if isnil(c) {
    return nil
  }

  return wrap_window(glib.take(voidptr(c)))
}

fn (v *Application) get_active_window() *Window {
  c := C.gtk_application_get_active_window(v.native())

  if isnil(c) {
    return nil
  }

  return wrap_window(glib.take(voidptr(c)))
}

fn (v *Application) uninhibit(cookie uint) {
  C.gtk_application_uninhibit(v.native(), G.uint(cookie))
}

fn (v *Application) get_app_menu() *glib.MenuModel {
  c := C.gtk_application_get_app_menu(v.native())

  if isnil(c) {
    return nil
  }

  return &glib.MenuModel{glib.take(voidptr(c))}
}

fn (v *Application) set_app_menu(m *glib.MenuModel) {
  mptr := (C.GMenuModel)(voidptr(m.native()))
  C.gtk_application_set_app_menu(v.native(), mptr)
}

fn (v *Application) get_menubar() *glib.MenuModel {
  c := C.gtk_application_get_menubar(v.native())

  if isnil(c) {
    return nil
  }

  return &glib.MenuModel{glib.take(voidptr(c))}
}

fn (v *Application) set_menubar(m *glib.MenuModel) {
  mptr := (*C.GMenuModel)(voidptr(m.native()))
  C.gtk_application_set_menubar(v.native(), mptr)
}

fn (v *Application) is_inhibited(flags ApplicationInhibitFlags) bool {
  return bool(C.gtk_application_is_inhibited(v.native(), C.GtkApplicationInhibitFlags(flags)))
}

fn (v *Application) inhibited(w IWindow flags ApplicationInhibitFlags, reason string) uint {
  cstr1 := (*C.char)(C.string(reason))
  defer C.free(voidptr(cstr1))

  return uint(C.gtk_application_inhibit(v.native(), w.to_window(), C.GtkApplicationInhibitFlags(flags), cstr1))
}

fn (v *Application) get_windows() *glib.List {
  glist := C.gtk_application_get_windows(v.native())
  list := glib.WrapList(byteptr(voidptr(glist)))
  list.data_wrapper(fn(ptr voidptr) interface{} {
      return wrap_window(glib.take(ptr))
  })

  runtime.set_finalizer(list, fn(l * glib.List) {
    l.free()
  })

  return list
}
