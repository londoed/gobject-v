module gtk

const (
	voidptr_err := error('[!] ERROR: cgo returned unexpected nil pointer')
)

type TreeView struct {
	Container
}

fn (v *TreeView) native() *C.GtkTreeView {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGtkTreeView(p)
}

fn marshal_tree_view(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := glib.Take(voidptr(c))
	return wrap_tree_view(obj), voidptr
}

fn wrap_tree_view(obj *glib.Object) *TreeView {
	return &TreeView{Container{Widget{glib.initially_owned(obj)}}}
}

fn setup_tree_view(c voidptr) (*TreeView, error) {
	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_tree_view(glib.Take(c)), voidptr
}

fn (v *TreeView) new() (*TreeView, error) {
	return setup_tree_view(voidptr(C.gtk_tree_view_new(v.native())))
}

fn (v *TreeView) new_with_model(model ITreeModel) (*TreeView, error) {
	return setup_tree_view(voidptr(C.gtk_tree_view_new_with_model(model.to_tree_model())))
}

fn (v *TreeView) get_model() (*TreeModel, error) {
	c := C.gtk_tree_view_get_model(v.native())

	if isnil(c) {
		return voidptr, voidptr
	}

	return wrap_tree_model(glib.Take(voidptr(c))), voidptr
}

fn (v *TreeView) set_model(model ITreeModel) {
	mptr *C.GtkTreeModel

	if !isnil(model) {
		mptr = model.to_tree_model()
	}

	C.gtk_tree_view_set_model(v.native(), mptr)
}

fn (v *TreeView) get_selection() (*TreeSelection, error) {
	c := C.gtk_tree_view_get_selection(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return wrap_tree_selection(glib.Take(voidptr(c))), voidptr
}

fn (v *TreeView) append_column(column *TreeViewColumn) int {
	c := C.gtk_tree_view_append_column(v.native(), column.native())
	return int(c)
}

fn (v *TreeView) get_path_at_pos(x, y int) (*TreePath, *TreeViewColumn, int, int, bool) {
	cpath *C.GtkTreePath
	ccol *C.GtkTreeViewColumn
	ccell_x, ccell_y *C.int
	cell_x, cell_y int

	path := TreePath{}
	column := TreeViewColumn{}
	cbool := C.gtk_tree_view_get_path_at_pos(
		v.native(),
		(C.int)(x),
		(C.int)(y),
		&cpath,
		&ccol,
		ccell_x,
		ccell_y
	)

	if !isnil(cpath) {
		path = &TreePath{cpath}
		runtime.set_finalizer(path, (*TreePath).free)
	}

	if !isnil(ccol) {
		column = wrap_tree_view_column(glib.Take(voidptr(ccol)))
	}

	if !isnil(ccell_x) {
		cell_x = int(*((*C.int)(voidptr(ccell_x))))
	}

	if !isnil(ccell_y) {
		cell_y = int(*((C.int)(voidptr(ccell_y))))
	}

	return path, column, cell_x, cell_y, bool(cbool)
}

fn (v *TreeView) get_cell_area(path *TreeView, column *TreeViewColumn) *gdk.Rectangle {
	ctp := path.native()
	pctvcol := column.native()

	rect C.GdkRectangle

	C.gtk_tree_view_get_cell_area(v.native(), ctp, pctvcol, &rect)

	return gdk.wrap_rectangle(byteptr(voidptr(&rect)))
}

fn (v *TreeView) get_level_indentation() int {
	return int(C.gtk_tree_view_get_level_indentation(v.native()))
}

fn (v *TreeView) get_show_expanders() bool {
	return bool(C.gtk_tree_view_get_show_expanders(v.native()))
}

fn (v *TreeView) set_level_indentation(indent int) {
	C.gtk_tree_view_set_level_indentation(v.native(), C.int(indent))
}

fn (v *TreeView) set_show_expanders(show bool) {
	C.gtk_tree_view_set_show_expanders(v.native(), bool(show))
}

fn (v *TreeView) get_headers_visible() bool {
	return bool(C.gtk_tree_view_get_headers_visible(v.native()))
}

fn (v *TreeView) set_headers_visible(show bool) {
	C.gtk_tree_view_set_headers_visible(v.native(), bool(show))
}

fn (v *TreeView) columns_autosize() {
	C.gtk_tree_view_columns_autosize(v.native())
}

fn (v *TreeView) get_headers_clickable() bool {
	return bool(C.gtk_tree_view_get_headers_clickable(v.native()))
}

fn (v *TreeView) set_headers_clickable(show bool) {
	C.gtk_tree_view_set_headers_clickable(v.native(), bool(show))
}

fn (v *TreeView) get_activate_on_single_click() bool {
	return bool(C.gtk_tree_view_get_activate_on_single_click(v.native()))
}

fn (v *TreeView) set_activate_on_single_click(show bool) {
	C.gtk_tree_view_set_activate_on_single_click(v.native(), bool(show))
}

fn (v *TreeView) remove_column(column *TreeViewColumn) int {
	return int(C.gtk_tree_view_remove_column(v.native(), column.native()))
}

fn (v *TreeView) insert_column(column *TreeViewColumn, pos int) int {
	return int(C.gtk_tree_view_insert_column(v.native(), column.native(), C.int(pos)))
}

fn (v *TreeView) get_ncolumns() u32 {
	return u32(C.gtk_tree_view_get_n_columns(v.native()))
}

fn (v *TreeView) get_column(n int) *TreeViewColumn {
	c := C.gtk_tree_view_get_column(v.native(), C.int(n))

	if isnil(c) {
		return voidptr
	}

	return wrap_tree_view_column(glib.Take(voidptr(c)))
}

fn (v *TreeView) get_columns() *glib.List {
	clist := C.gtk_tree_view_get_columns(v.native())

	if isnil(clist) {
		return voidptr
	}

	list := glib.wrap_list(byteptr(voidptr(clist)))
	list.data_wrapper(fn (ptr voidptr) interface{} {
		return wrap_tree_view_column(glib.Take(voidptr(ptr)))
	})

	runtime.set_finalizer(list, func(glist *glib.List) {
		glist.free()
	})

	return list
}

fn (v *TreeView) move_column_after(column *TreeViewColumn, base_column *TreeViewColumn) {
	C.gtk_tree_view_move_column_after(v.native(), column.native(), base_column.native())
}

fn (v *TreeView) set_expander_column(column *TreeViewColumn) {
	C.gtk_tree_view_set_expander_column(v.native(), column.native())
}

fn (v *TreeView) get_expander_column() *TreeViewColumn {
	c := C.gtk_tree_view_get_expander_column(v.native())

	if isnil(c) {
		return voidptr
	}

	return wrap_tree_view_column(glib.Take(voidptr(c)))
}

fn (v *TreeView) scroll_to_point(tree_x, tree_y int) {
	C.gtk_tree_view_scroll_to_point(v.native(), C.int(tree_x), C.int(tree_y))
}

fn (v *TreeView) set_cursor(path *TreePath, focus_col *TreeViewColumn, start_editing bool) {
	C.gtk_tree_view_set_cursor(v.native(), path.native(), focus_col.native(), bool(start_editing))
}

fn (v *TreeView) set_cursor_on_cell(path *TreePath, focus_col *TreeViewColumn, focus_cell *CellRenderer, start_editing bool) {
	C.gtk_tree_view_set_cursor_on_cell(v.native(), path.native(), focus_col.native(), focus_cell.native(), bool(start_editing))
}

fn (v *TreeView) get_cursor(p *TreePath, c *TreePathColumn) {
	path *C.GtkTreePath
	col *C.GtkTreeViewColumn

	C.gtk_tree_view_get_cursor(v.native(), &path, &col)

	if !isnil(path) {
		p = &TreePath{path}
		runtime.set_finalizer(p, (*TreePath).free)
	}

	if !isnil(col) {
		c = wrap_tree_view_column(glib.Take(voidptr(col)))
	}

	return
}

fn (v *TreeView) row_activated(path *TreePath, column *TreeViewColumn) {
	C.gtk_tree_view_row_activated(v.native(), path.native(), column.native())
}

fn (v *TreeView) expand_all() {
	C.gtk_tree_view_expand_all(v.native())
}

fn (v *TreeView) collapse_all() {
	C.gtk_tree_view_collapse_all(v.native())
}

fn (v *TreeView) collapse_all() {
	C.gtk_tree_view_collapse_all(v.native())
}

fn (v *TreeView) expand_to_path(path *TreePath) {
	C.gtk_tree_view_expand_to_path(v.native(), path.native())
}

fn (v *TreePath) expand_row(path *TreePath, open_all bool) bool {
	return bool(C.gtk_tree_view_expand_row(v.native(), path.native(), bool(open_all)))
}

fn (v *TreeView) collapse_row(path *TreePath) bool {
	return bool(C.gtk_tree_view_collapse_row(v.native(), path.native()))
}

fn (v *TreeView) row_expanded(path *TreeView) bool {
	bool(C.gtk_tree_view_row_expanded(v.native(), path.native()))
}

fn (v *TreeView) set_reorderable(b bool) {
	C.gtk_tree_view_set_reorderable(v.native(), bool(b))
}

fn (v *TreeView) get_reorderable() bool {
	return bool(C.gtk_tree_view_get_reorderable(v.native()))
}

fn (v *TreeView) get_bin_window() *gdk.Window {
	c := C.gtk_tree_view_get_bin_window(v.native())

	if isnil(c) {
		return voidptr
	}

	w := &gdk.Window{glib.Take(voidptr(c))}
	return w
}

fn (v *TreeView) convert_widget_to_bin_widget_coords(wx, wy int, bx, by *int) {
	C.gtk_tree_view_convert_widget_to_bin_widget_coords(
		v.native(),
		(C.int)(wx),
		(C.int)(wy),
		(*C.int)(voidptr(bx)),
		(*C.int)(voidptr(by))
	)
}

fn (v *TreeView) convert_bin_window_to_tree_coords(bx, by int, wx, wy *int) {
	C.gtk_tree_view_convert_bin_window_to_widget_coords(
		v.native(),
		(C.int)(bx),
		(C.int)(by),
		(*C.int)(voidptr(wx)),
		(*C.int)(voidptr(wy))
	)
}

fn (v *TreeView) convert_bin_window_to_tree_coords(bx, by int, tx, ty *int) {
	C.gtk_tree_view_convert_bin_window_to_tree_coords(
		v.native(),
		(C.int)(bx),
		(C.int)(by),
		(*C.int)(voidptr(tx)),
		(*C.int)(voidptr(ty))
	)
}

fn (v *TreeView) set_enable_search(b bool) {
	C.gtk_tree_view_set_enable_search(v.native(), bool(b))
}

fn (v *TreeView) get_enable_search() bool {
	return bool(C.gtk_tree_view_get_enable_search(v.native()))
}

fn (v *TreeView) set_search_column(c int) {
	C.gtk_tree_view_set_search_column(v.native(), C.int(c))
}

fn (v *TreeView) get_search_column() int {
	return int(C.gtk_tree_view_get_search_column(v.native()))
}

fn (v *TreeView) get_search_entry() *Entry {
	c := C.gtk_tree_view_get_search_entry(v.native())

	if isnil(c) {
		return voidptr
	}

	return wrap_entry(glib.Take(voidptr(c)))
}

fn (v *TreeView) set_search_entry(e *Entry) {
	C.gtk_tree_view_set_search_entry(v.native(), e.native())
}

fn (v *TreeView) set_search_equal_substring_match() {
	C.gtk_tree_view_set_search_equal_func(
		v.native(),
		(C.GtkTreeViewSearchEqualFunc)(voidptr(C.substring_match_equal_func)),
		voidptr,
		voidptr
	)
}

fn (v *TreeView) set_fixed_height_mode(b bool) {
	C.gtk_tree_view_set_fixed_height_mode(v.native(), bool(b))
}

fn (v *TreeView) get_fixed_height_mode() bool {
	return bool(C.gtk_tree_view_get_fixed_height_mode(v.native()))
}

fn (v *TreeView) set_hover_selection(b bool) {
	C.gtk_tree_view_set_hover_selection(v.native(), bool(b))
}

fn (v *TreeView) get_hover_selection() bool {
	return bool(C.gtk_tree_view_get_hover_selection(v.native()))
}

fn (v *TreeView) set_hover_expand(b bool) {
	C.gtk_tree_view_view_set_hover_expand(v.native(), bool(b))
}

fn (v *TreeView) get_hover_expand() bool {
	return bool(C.gtk_tree_view_get_hover_expand(v.native()))
}

fn (v *TreeView) set_rubber_banding(b bool) {
	C.gtk_tree_view_set_rubber_banding(v.native(), bool(b))
}

fn (v *TreeView) get_rubber_banding() bool {
	return bool(C.gtk_tree_view_get_rubber_banding(v.native()))
}

fn (v *TreeView) is_rubber_banding_active() bool {
	return bool(C.gtk_tree_view_is_rubber_banding_active(v.native()))
}

fn (v *TreeView) set_enable_tree_lines(b bool) {
	C.gtk_tree_view_set_enable_tree_lines(v.native(), bool(b))
}

fn (v *TreeView) get_enable_tree_lines() bool {
	return bool(C.gtk_tree_view_get_enable_tree_lines(v.native()))
}

fn (v *TreeView) get_tooltip_column() int {
	return int(C.gtk_tree_view_get_tooltip_column(v.native()))
}

fn (v *TreeView) set_tooltip_column(c int) {
	C.gtk_tree_view_set_tooltip_column(v.native(), C.int(c))
}

fn (v *TreeView) set_grid_lines(grid_lines TreeViewGridLines) {
	C.gtk_tree_view_set_grid_lines(v.native(), C.GtkTreeViewGridLines(grid_lines))
}

fn (v *TreeView) get_grid_lines() TreeViewGridLines {
	return TreeViewGridLines(C.gtk_tree_view_get_grid_lines(v.native()))
}

fn (v *TreeView) is_blank_pos(x, y int) (*TreePath, *TreeViewColumn, int, int, bool) {
	cpath *C.GtkTreePath
	ccol *C.GtkTreeViewColumn
	ccell_x, ccell_y *C.int
	cell_x, cell_y int

	path := TreePath{}
	column := TreeViewColumn{}

	cbool := C.gtk_tree_view_is_blank_at_pos(
		v.native(),
		(C.int)(x),
		(C.int)(y),
		&cpath,
		&ccol,
		ccell_x,
		ccell_y
	)

	if !isnil(cpath) {
		path = &TreePath{cpath}
		runtime.set_finalizer(path, (*TreePath).free)
	}

	if !isnil(ccol) {
		column = wrap_tree_view_column(glib.Take(voidptr(ccol)))
	}

	if !isnil(ccell_x) {
		cell_x = int(*((*C.int)(voidptr(ccell_x))))
	}

	if !isnil(ccell_y) {
		cell_y = int(*((C.int)(voidptr(ccell_y))))
	}

	return path, column, cell_x, cell_y, bool(cbool)
}

fn (v *TreeView) scroll_to_cell(path *TreePath, column *TreeViewColumn, align bool, x_align, y_align f32) {
	C.gtk_tree_view_scroll_to_cell(v.native(), path.native(), column.native(), bool(align), C.float(x_align), C.float(y_align))
}

fn (v *TreeView) set_tooltip_cell(tooltip *Tooltip, path *TreePath, column *TreeViewColumn, cell *CellRenderer) {
	C.gtk_tree_view_set_tooltip_row(v.native(), tooltip.native(), path.native())
}

fn (v *TreeView) set_tooltip_row(tooltip *Tooltip, path *TreePath) {
	C.gtk_tree_view_set_tooltip_row(v.native(), tooltip.native(), path.native())
}
