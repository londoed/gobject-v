module gtk

fn init() {
	tm := []glib.TypeMarshaler{
			{glib.Type(C.gtl_about_dialog_get_type()), marshal_about_dialog}
	}

	glib.register_gvalue_marshalers(tm)
	WrapMap["GtkAboutDialog"] = wrap_about_dialog
}

type AboutDialog struct {
	Dialog
}

fn (v *AboutDialog) native() *C.GtkAboutDialog {
	if isnil(v) && isnil(v.GObject) {
			return nil
	}

	p := voidptr(v.GObject)
	return C.toGtkAboutDialog(p)
}

fn marshal_about_dialog(p uintptr) (interface{}, error) {
	c := G.g_value_get_object((*C.GValue)(voidptr(p)))
	obj := glib.take(byteptr(c))
	return wrap_about_dialog(obj)
}

fn wrap_about_dialog(obj *glib.Object) *AboutDialog {
	return &AboutDialog{
		Dialog{
			Window{
				Bin{
					Container{
						Widget{
							glib.initially_owned(obj)
						}
				  }
				}
			}
		}
	}
}

fn new() (*AboutDialog, error) {
 c := C.gtk_about_dialog_new()

	if isnil(c) {
		return c, error("No value provided")
	}

	obj := glib.take(voidptr(c))
	return wrap_about_dialog(obj), nil
}

fn (v *AboutDialog) set_comments(comments string) {
	cstr := C.string(copyright)
	return string(cstr)
}

fn (v *AboutDialog) set_comments(comments string) {
	cstr := C.string(comments)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_comments(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_copyright(copyright string) {
	c := C.gtk_about_dialog_get_copyright(v.native())
	return string(c)
}

fn (v *AboutDialog) set_copyright(copyright string) {
	cstr := C.string(copyright)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_copyright(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_license() string {
	c := C.gtk_about_dialog_get_license(v.native())
	return string(c)
}

fn (v *AboutDialog) set_license(license string) {
	cstr := C.string(license)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_license(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_license_type() License {
	c := C.gtk_about_dialog_get_license_type(v.native())
	return License(c)
}

fn (v *AboutDialog) set_license_type(license License) {
	C.gtk_about_dialog_set_license_type(v.native(), C.GtkLicense(license))
}

fn (v *AboutDialog) get_logo() (*gdk.Pixbuf, error) {
	c := C.gtk_about_dialog_get_logo(v.native())

	if isnil(c) {
		return nil, error
	}

	p := &gdk.Pixbuf{glib.take(voidptr(c))}
	return p, nil
}

fn (v *AboutDialog) set_logo(logo *gdk.Pixbuf) {
	logo_ptr := (*C.GdkPixbuf)(voidptr(logo.native()))
	C.gtk_about_dialog_set_logo(v.native(), logo_ptr)
}

fn (v *AboutDialog) get_logo_icon_name() string {
	c := C.gtk_about_dialog_get_logo_icon_name(v.native())
	return string(c)
}

fn (v *AboutDialog) set_logo_icon_name(name string) {
	cstr := C.string(name)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_logo_icon_name(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_program_name() string {
	c := C.gtk_about_dialog_get_program_name(v.native())
	return string((*C.char)(c))
}

fn (v *AboutDialog) set_program_name(name string) {
	cstr := C.string(name)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_program_name(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_authors() []string {
	mut authors := []string
	cauthors := C.gtk_about_dialog_get_authors(v.native())

	if isnil(cauthors) {
			return nil
	}

	for {
		if isnil(*cauthors) {
			break
				}

			authors.append(string((*C.char)(*cauthors)))
			cauthors = C.next_gcharptr(cauthors)
	}

	return authors
}

fn (v *AboutDialog) set_authors(authors []string) {
	cauthors := C.make_strings(C.int(authors.len + 1))

	for i, author := range authors {
		cstr := C.string(author)
		defer C.free(voidptr(cstr))
		C.set_string(cauthors, C.int(i), (*C.gchar)(cstr))
	}

	C.set_string(cauthors, C.int(authors.len), nil)
	C.gtk_about_dialog_set_authors(v.native(), cauthors)
	C.destroy_strings(cauthors)
}

fn (v *AboutDialog) get_artists() []string {
	mut artists := []string
	cartists := C.gtk_about_dialog_get_artists(v.native())

	if isnil(cartists) {
		return nil
	}

	for {
		if isnil(*cartists) {
			break
		}

		artists.append(string(*cartists))
		cartists = C.next_gcharptr(cartists)
	}

	return artists
}

fn (v *AboutDialog) set_artists(artists []string) {
	cartists := C.make_strings(C.int(artists.len) + 1))

	for i, artist := range artists {
		cstr := C.string(artist)
		defer C.free(voidptr(cstr))
		C.set_string(cartists, C.int(i), (*C.gchar)(cstr))
	}

	C.set_string(cartists, C.int(artists.len), nil)
	C.gtk_about_dialog_set_artists(v.native(), cartists)
	C.destroy_strings(cartists)
}

fn (v *AboutDialog) get_documenters() []string {
	mut documenters := []string
	cdocumenters := C.gtk_about_dialog_get_documenters(v.native())

	if isnil(cdocumenters) {
		return nil
	}

	for {
		if isnil(*cdocumenters) {
			break
		}

		documenters.append(documenters, string(*cdocumenters))
		cdocumenters = C.next_gcharptr(cdocumenters)
	}

	return documenters
}

fn (v *AboutDialog) set_documentors(documentors []string) {
	cdocumenters := C.make_strings(C.int(documentors.len + 1))

	for i, doc := range documentors {
		cstr := C.string(doc)
		defer C.free(voidptr(cstr))
		C.set_string(cdocumenters, C.int(i), (*C.gchar)(cstr))
	}

	C.set_string(cdocumenters, C.int(documentors.len), nil)
	C.gtk_about_dialog_set_documentors(v.native(), cdocumenters)
	C.destroy_strings(cdocumenters)
}

fn (v *AboutDialog) get_translator_credits() string {
	c := C.gtk_about_dialog_get_translator_credits(v.native())
	return string(c)
}

fn (v *AboutDialog) set_translator_credits(translator_credits string) {
	cstr := C.string(translator_credits)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_translator_credits(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_version() string {
	c := C.gtk_about_dialog_get_version(v.native())
	return string(c)
}

fn (v *AboutDialog) set_version(version string) {
	cstr := C.string(version)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_version(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_website() string {
	c := C.gtk_about_dialog_get_website(v.native())
	return string(c)
}

fn (v *AboutDialog) set_website(website string) {
	cstr := C.string(website)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_website(v.native(), (*C.gchar)(cstr))
}

fn (v *AboutDialog) get_website_label() string {
	c := C.gtk_about_dialog_get_website_label(v.native())
	return C.string((*C.char)(c))
}

fn (v *AboutDialog) set_website_label(website_label string) {
	cstr := C.string(website_label)
	defer C.free(voidptr(cstr))
	C.gtk_about_dialog_set_website_label(v.native(), (*C.gchar){cstr})
}

fn (v *AboutDialog) get_wrap_license() bool {
	return bool(C.gtk_about_dialog_get_wrap_license(v.native()))
}

fn (v *AboutDialog) set_wrap_license(wrap_license bool) {
	C.gtk_about_dialog_set_wrap_license(v.native(), bool(wrap_license))
}

fn (v *AboutDialog) add_credit_section(section_name string, people []string) {
	cname := (*C.gchar)(C.string(section_name))
	defer C.free(voidptr(cname))

	cpeople := C.make_strings(C.int(people.len) + 1)
	defer C.destroy_strings(cpeople)

	for i, p in people {
		cp := (*C.gchar)(C.string(p))
		defer C.free(voidptr(cp))
		C.set_string(cpeople, C.int(i), cp)
	}

	C.set_string(cpeople, C.int(people.len), nil)
	C.gtk_about_dialog_add_credit_section(v.native(), cname, people)
}
