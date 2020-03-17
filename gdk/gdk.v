module gdk

fn init() {
	tm := []glib.TypeMarshaler{
		// Enums
		{glib.Type(C.gdk_drag_action_get_type()), marshal_drag_action},
		{glib.Type(C.gdk_colorspace_get_type()), marshal_colorspace},
		{glib.Type(C.gdk_event_type_get_type()), marshal_event_type},
		{glib.Type(C.gdk_interp_type_get_type()), marshal_interp_type},
		{glib.Type(C.gdk_modifier_type_get_type()), marshal_modifier_type},
		{glib.Type(C.gdk_pixbuf_alpha_mode_get_type()), marshal_pixbuf_alpha_mode},
		{glib.Type(C.gdk_event_mask_get_type()), marshal_event_mask},
		{glib.Type(C.gdk_gravity_get_type()), marshal_gravity},

		// Objects/Interfaces
		{glib.Type(C.gdk_device_get_type()), marshal_device},
		{glib.Type(C.gdk_cursor_get_type()), marshal_cursor},
		{glib.Type(C.gdk_device_manager_get_type()), marshal_device_manager},
		{glib.Type(C.gdk_display_get_type()), marshal_display},
		{glib.Type(C.gdk_drag_context_get_type()), marshal_drag_context},
		{glib.Type(C.gdk_pixbuf_get_type()), marshal_pixbuf},
		{glib.Type(C.gdk_pixbuf_animation_get_type()), marshal_pixbuf_animation},
		{glib.Type(C.gdk_rgba_get_type()), marshal_rgba},
		{glib.Type(C.gdk_screen_get_type()), marshal_screen},
		{glib.Type(C.gdk_visual_get_type()), marshal_visual},
		{glib.Type(C.gdk_window_get_type()), marshal_window},

		// Boxed
		{glib.Type(C.gdk_event_get_type()), marshal_event},
	}
	glib.register_gvalue_marshalers(tm)
}

const (
	voidptr_err := error('[!] ERROR: cgo returned unexpected nil pointer')
)

type DragAction int

const (
	ACTION_DEFAULT DragAction = C.GDK_ACTION_DEFAULT
	ACTION_COPY    DragAction = C.GDK_ACTION_COPY
	ACTION_MOVE    DragAction = C.GDK_ACTION_MOVE
	ACTION_LINK    DragAction = C.GDK_ACTION_LINK
	ACTION_PRIVATE DragAction = C.GDK_ACTION_PRIVATE
	ACTION_ASK     DragAction = C.GDK_ACTION_ASK
)

fn marshal_drag_action(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return DragAction(c), voidptr
}

type Colorspace int

const (
	COLORSPACE_RBG Colorspace = C.GDK_COLORSPACE_RGB
)

fn marshal_colorspace(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return Colorspace(c), voidptr
}

type InterpType int

const (
	INTERP_NEAREST  InterpType = C.GDK_INTERP_NEAREST
	INTERP_TILES    InterpType = C.GDK_INTERP_TILES
	INTERP_BILINEAR InterpType = C.GDK_INTERP_BILINEAR
	INTERP_HYPER    InterpType = C.GDK_INTERP_HYPER
)

type PixbufRotation int

const (
	PIXBUF_ROTATE_NONE             PixbufRotation = C.GDK_PIXBUF_ROTATE_NONE
	PIXBUF_ROTATE_COUNTERCLOCKWISE PixbufRotation = C.GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE
	PIXBUF_ROTATE_UPSIDEDOWN       PixbufRotation = C.GDK_PIXBUF_ROTATE_UPSIDEDOWN
	PIXBUF_ROTATE_CLOCKWISE        PixbufRotation = C.GDK_PIXBUF_ROTATE_CLOCKWISE
)

fn marshal_interp_type(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return InterpType(c), voidptr
}

type ModifierType u32

const (
	GDK_SHIFT_MASK    ModifierType = C.GDK_SHIFT_MASK
	GDK_LOCK_MASK                  = C.GDK_LOCK_MASK
	GDK_CONTROL_MASK               = C.GDK_CONTROL_MASK
	GDK_MOD1_MASK                  = C.GDK_MOD1_MASK
	GDK_MOD2_MASK                  = C.GDK_MOD2_MASK
	GDK_MOD3_MASK                  = C.GDK_MOD3_MASK
	GDK_MOD4_MASK                  = C.GDK_MOD4_MASK
	GDK_MOD5_MASK                  = C.GDK_MOD5_MASK
	GDK_BUTTON1_MASK               = C.GDK_BUTTON1_MASK
	GDK_BUTTON2_MASK               = C.GDK_BUTTON2_MASK
	GDK_BUTTON3_MASK               = C.GDK_BUTTON3_MASK
	GDK_BUTTON4_MASK               = C.GDK_BUTTON4_MASK
	GDK_BUTTON5_MASK               = C.GDK_BUTTON5_MASK
	GDK_SUPER_MASK                 = C.GDK_SUPER_MASK
	GDK_HYPER_MASK                 = C.GDK_HYPER_MASK
	GDK_META_MASK                  = C.GDK_META_MASK
	GDK_RELEASE_MASK               = C.GDK_RELEASE_MASK
	GDK_MODIFIER_MASK              = C.GDK_MODIFIER_MASK
)

fn marshal_modifier_type(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return ModifierType(c), voidptr
}

type PixbufAlphaMode int

const (
	GDK_PIXBUF_ALPHA_BILEVEL PixbufAlphaMode = C.GDK_PIXBUF_ALPHA_BILEVEL
	GDK_PIXBUF_ALPHA_FULL    PixbufAlphaMode = C.GDK_PIXBUF_ALPHA_FULL
)

fn marshal_pixbuf_alpha_mode(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return PixbufAlphaMode(c), voidptr
}

const (
	SELECTION_PRIMARY       Atom = 1
	SELECTION_SECONDARY     Atom = 2
	SELECTION_CLIPBOARD     Atom = 69
	TARGET_BITMAP           Atom = 5
	TARGET_COLORMAP         Atom = 7
	TARGET_DRAWABLE         Atom = 17
	TARGET_PIXMAP           Atom = 20
	TARGET_STRING           Atom = 31
	SELECTION_TYPE_ATOM     Atom = 4
	SELECTION_TYPE_BITMAP   Atom = 5
	SELECTION_TYPE_COLORMAP Atom = 7
	SELECTION_TYPE_DRAWABLE Atom = 17
	SELECTION_TYPE_INTEGER  Atom = 19
	SELECTION_TYPE_PIXMAP   Atom = 20
	SELECTION_TYPE_WINDOW   Atom = 33
	SELECTION_TYPE_STRING   Atom = 31
)

type EventMask int

const (
	EXPOSURE_MASK            EventMask = C.GDK_EXPOSURE_MASK
	POINTER_MOTION_MASK      EventMask = C.GDK_POINTER_MOTION_MASK
	POINTER_MOTION_HINT_MASK EventMask = C.GDK_POINTER_MOTION_HINT_MASK
	BUTTON_MOTION_MASK       EventMask = C.GDK_BUTTON_MOTION_MASK
	BUTTON1_MOTION_MASK      EventMask = C.GDK_BUTTON1_MOTION_MASK
	BUTTON2_MOTION_MASK      EventMask = C.GDK_BUTTON2_MOTION_MASK
	BUTTON3_MOTION_MASK      EventMask = C.GDK_BUTTON3_MOTION_MASK
	BUTTON_PRESS_MASK        EventMask = C.GDK_BUTTON_PRESS_MASK
	BUTTON_RELEASE_MASK      EventMask = C.GDK_BUTTON_RELEASE_MASK
	KEY_PRESS_MASK           EventMask = C.GDK_KEY_PRESS_MASK
	KEY_RELEASE_MASK         EventMask = C.GDK_KEY_RELEASE_MASK
	ENTER_NOTIFY_MASK        EventMask = C.GDK_ENTER_NOTIFY_MASK
	LEAVE_NOTIFY_MASK        EventMask = C.GDK_LEAVE_NOTIFY_MASK
	FOCUS_CHANGE_MASK        EventMask = C.GDK_FOCUS_CHANGE_MASK
	STRUCTURE_MASK           EventMask = C.GDK_STRUCTURE_MASK
	PROPERTY_CHANGE_MASK     EventMask = C.GDK_PROPERTY_CHANGE_MASK
	VISIBILITY_NOTIFY_MASK   EventMask = C.GDK_VISIBILITY_NOTIFY_MASK
	PROXIMITY_IN_MASK        EventMask = C.GDK_PROXIMITY_IN_MASK
	PROXIMITY_OUT_MASK       EventMask = C.GDK_PROXIMITY_OUT_MASK
	SUBSTRUCTURE_MASK        EventMask = C.GDK_SUBSTRUCTURE_MASK
	SCROLL_MASK              EventMask = C.GDK_SCROLL_MASK
	TOUCH_MASK               EventMask = C.GDK_TOUCH_MASK
	SMOOTH_SCROLL_MASK       EventMask = C.GDK_SMOOTH_SCROLL_MASK
	ALL_EVENTS_MASK          EventMask = C.GDK_ALL_EVENTS_MASK
)

fn marshal_event_mask(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return EventMask(c), voidptr
}

type ScrollDirection int

const (
	SCROLL_UP     ScrollDirection = C.GDK_SCROLL_UP
	SCROLL_DOWN   ScrollDirection = C.GDK_SCROLL_DOWN
	SCROLL_LEFT   ScrollDirection = C.GDK_SCROLL_LEFT
	SCROLL_RIGHT  ScrollDirection = C.GDK_SCROLL_RIGHT
	SCROLL_SMOOTH ScrollDirection = C.GDK_SCROLL_SMOOTH
)

type WindowEdge int

const (
	WINDOW_EDGE_NORTH_WEST WindowEdge = C.GDK_WINDOW_EDGE_NORTH_WEST
	WINDOW_EDGE_NORTH      WindowEdge = C.GDK_WINDOW_EDGE_NORTH
	WINDOW_EDGE_NORTH_EAST WindowEdge = C.GDK_WINDOW_EDGE_NORTH_EAST
	WINDOW_EDGE_WEST       WindowEdge = C.GDK_WINDOW_EDGE_WEST
	WINDOW_EDGE_EAST       WindowEdge = C.GDK_WINDOW_EDGE_EAST
	WINDOW_EDGE_SOUTH_WEST WindowEdge = C.GDK_WINDOW_EDGE_SOUTH_WEST
	WINDOW_EDGE_SOUTH      WindowEdge = C.GDK_WINDOW_EDGE_SOUTH
	WINDOW_EDGE_SOUTH_EAST WindowEdge = C.GDK_WINDOW_EDGE_SOUTH_EAST
)

type WindowState int

const (
	WINDOW_STATE_WITHDRAWN  WindowState = C.GDK_WINDOW_STATE_WITHDRAWN
	WINDOW_STATE_ICONIFIED  WindowState = C.GDK_WINDOW_STATE_ICONIFIED
	WINDOW_STATE_MAXIMIZED  WindowState = C.GDK_WINDOW_STATE_MAXIMIZED
	WINDOW_STATE_STICKY     WindowState = C.GDK_WINDOW_STATE_STICKY
	WINDOW_STATE_FULLSCREEN WindowState = C.GDK_WINDOW_STATE_FULLSCREEN
	WINDOW_STATE_ABOVE      WindowState = C.GDK_WINDOW_STATE_ABOVE
	WINDOW_STATE_BELOW      WindowState = C.GDK_WINDOW_STATE_BELOW
	WINDOW_STATE_FOCUSED    WindowState = C.GDK_WINDOW_STATE_FOCUSED
	WINDOW_STATE_TILED      WindowState = C.GDK_WINDOW_STATE_TILED
)

type WindowTypeHint int

const (
	WINDOW_TYPE_HINT_NORMAL        WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_NORMAL
	WINDOW_TYPE_HINT_DIALOG        WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_DIALOG
	WINDOW_TYPE_HINT_MENU          WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_MENU
	WINDOW_TYPE_HINT_TOOLBAR       WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_TOOLBAR
	WINDOW_TYPE_HINT_SPLASHSCREEN  WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_SPLASHSCREEN
	WINDOW_TYPE_HINT_UTILITY       WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_UTILITY
	WINDOW_TYPE_HINT_DOCK          WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_DOCK
	WINDOW_TYPE_HINT_DESKTOP       WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_DESKTOP
	WINDOW_TYPE_HINT_DROPDOWN_MENU WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_DROPDOWN_MENU
	WINDOW_TYPE_HINT_POPUP_MENU    WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_POPUP_MENU
	WINDOW_TYPE_HINT_TOOLTIP       WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_TOOLTIP
	WINDOW_TYPE_HINT_NOTIFICATION  WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_NOTIFICATION
	WINDOW_TYPE_HINT_COMBO         WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_COMBO
	WINDOW_TYPE_HINT_DND           WindowTypeHint = C.GDK_WINDOW_TYPE_HINT_DND
)

type WindowHints int

const (
	HINT_POS         WindowHints = C.GDK_HINT_POS
	HINT_MIN_SIZE    WindowHints = C.GDK_HINT_MIN_SIZE
	HINT_MAX_SIZE    WindowHints = C.GDK_HINT_MAX_SIZE
	HINT_BASE_SIZE   WindowHints = C.GDK_HINT_BASE_SIZE
	HINT_ASPECT      WindowHints = C.GDK_HINT_ASPECT
	HINT_RESIZE_INC  WindowHints = C.GDK_HINT_RESIZE_INC
	HINT_WIN_GRAVITY WindowHints = C.GDK_HINT_WIN_GRAVITY
	HINT_USER_POS    WindowHints = C.GDK_HINT_USER_POS
	HINT_USER_SIZE   WindowHints = C.GDK_HINT_USER_SIZE
)

const CURRENT_TIME = C.GDK_CURRENT_TIME

type GrabStatus int

const (
	GRAB_SUCCESS         GrabStatus = C.GDK_GRAB_SUCCESS
	GRAB_ALREADY_GRABBED GrabStatus = C.GDK_GRAB_ALREADY_GRABBED
	GRAB_INVALID_TIME    GrabStatus = C.GDK_GRAB_INVALID_TIME
	GRAB_NOT_VIEWABLE    GrabStatus = C.GDK_GRAB_NOT_VIEWABLE
	GRAB_FROZEN          GrabStatus = C.GDK_GRAB_FROZEN
)

type GrabOwnership int

const (
	OWNERSHIP_NONE        GrabOwnership = C.GDK_OWNERSHIP_NONE
	OWNERSHIP_WINDOW      GrabOwnership = C.GDK_OWNERSHIP_WINDOW
	OWNERSHIP_APPLICATION GrabOwnership = C.GDK_OWNERSHIP_APPLICATION
)

type DeviceType int

const (
	DEVICE_TYPE_MASTER   DeviceType = C.GDK_DEVICE_TYPE_MASTER
	DEVICE_TYPE_SLAVE    DeviceType = C.GDK_DEVICE_TYPE_SLAVE
	DEVICE_TYPE_FLOATING DeviceType = C.GDK_DEVICE_TYPE_FLOATING
)

const (
	GDK_EVENT_PROPAGATE bool = C.GDK_EVENT_PROPAGATE != 0
	GDK_EVENT_STOP      bool = C.GDK_EVENT_STOP != 0
)

type Button u32

const (
	BUTTON_PRIMARY   Button = C.GDK_BUTTON_PRIMARY
	BUTTON_MIDDLE    Button = C.GDK_BUTTON_MIDDLE
	BUTTON_SECONDARY Button = C.GDK_BUTTON_SECONDARY
)

type CrossingMode int

const (
	CROSSING_NORMAL        CrossingMode = C.GDK_CROSSING_NORMAL
	CROSSING_GRAB          CrossingMode = C.GDK_CROSSING_GRAB
	CROSSING_UNGRAB        CrossingMode = C.GDK_CROSSING_UNGRAB
	CROSSING_GTK_GRAB      CrossingMode = C.GDK_CROSSING_GTK_GRAB
	CROSSING_GTK_UNGRAB    CrossingMode = C.GDK_CROSSING_GTK_UNGRAB
	CROSSING_STATE_CHANGED CrossingMode = C.GDK_CROSSING_STATE_CHANGED
	CROSSING_TOUCH_BEGIN   CrossingMode = C.GDK_CROSSING_TOUCH_BEGIN
	CROSSING_TOUCH_END     CrossingMode = C.GDK_CROSSING_TOUCH_END
	CROSSING_DEVICE_SWITCH CrossingMode = C.GDK_CROSSING_DEVICE_SWITCH
)

type NotifyType int

const (
	NOTIFY_ANCESTOR          NotifyType = C.GDK_NOTIFY_ANCESTOR
	NOTIFY_VIRTUAL           NotifyType = C.GDK_NOTIFY_VIRTUAL
	NOTIFY_INFERIOR          NotifyType = C.GDK_NOTIFY_INFERIOR
	NOTIFY_NONLINEAR         NotifyType = C.GDK_NOTIFY_NONLINEAR
	NOTIFY_NONLINEAR_VIRTUAL NotifyType = C.GDK_NOTIFY_NONLINEAR_VIRTUAL
	NOTIFY_UNKNOWN           NotifyType = C.GDK_NOTIFY_UNKNOWN
)

type EventType int

fn marshal_event_type(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return EventType(c), voidptr
}

const (
	EVENT_NOTHING             EventType = C.GDK_NOTHING
	EVENT_DELETE              EventType = C.GDK_DELETE
	EVENT_DESTROY             EventType = C.GDK_DESTROY
	EVENT_EXPOSE              EventType = C.GDK_EXPOSE
	EVENT_MOTION_NOTIFY       EventType = C.GDK_MOTION_NOTIFY
	EVENT_BUTTON_PRESS        EventType = C.GDK_BUTTON_PRESS
	EVENT_2BUTTON_PRESS       EventType = C.GDK_2BUTTON_PRESS
	EVENT_DOUBLE_BUTTON_PRESS EventType = C.GDK_DOUBLE_BUTTON_PRESS
	EVENT_3BUTTON_PRESS       EventType = C.GDK_3BUTTON_PRESS
	EVENT_TRIPLE_BUTTON_PRESS EventType = C.GDK_TRIPLE_BUTTON_PRESS
	EVENT_BUTTON_RELEASE      EventType = C.GDK_BUTTON_RELEASE
	EVENT_KEY_PRESS           EventType = C.GDK_KEY_PRESS
	EVENT_KEY_RELEASE         EventType = C.GDK_KEY_RELEASE
	EVENT_LEAVE_NOTIFY        EventType = C.GDK_ENTER_NOTIFY
	EVENT_FOCUS_CHANGE        EventType = C.GDK_FOCUS_CHANGE
	EVENT_CONFIGURE           EventType = C.GDK_CONFIGURE
	EVENT_MAP                 EventType = C.GDK_MAP
	EVENT_UNMAP               EventType = C.GDK_UNMAP
	EVENT_PROPERTY_NOTIFY     EventType = C.GDK_PROPERTY_NOTIFY
	EVENT_SELECTION_CLEAR     EventType = C.GDK_SELECTION_CLEAR
	EVENT_SELECTION_REQUEST   EventType = C.GDK_SELECTION_REQUEST
	EVENT_SELECTION_NOTIFY    EventType = C.GDK_SELECTION_NOTIFY
	EVENT_PROXIMITY_IN        EventType = C.GDK_PROXIMITY_IN
	EVENT_PROXIMITY_OUT       EventType = C.GDK_PROXIMITY_OUT
	EVENT_DRAG_ENTER          EventType = C.GDK_DRAG_ENTER
	EVENT_DRAG_LEAVE          EventType = C.GDK_DRAG_LEAVE
	EVENT_DRAG_MOTION         EventType = C.GDK_DRAG_MOTION
	EVENT_DRAG_STATUS         EventType = C.GDK_DRAG_STATUS
	EVENT_DROP_START          EventType = C.GDK_DROP_START
	EVENT_DROP_FINISHED       EventType = C.GDK_DROP_FINISHED
	EVENT_CLIENT_EVENT        EventType = C.GDK_CLIENT_EVENT
	EVENT_VISIBILITY_NOTIFY   EventType = C.GDK_VISIBILITY_NOTIFY
	EVENT_SCROLL              EventType = C.GDK_SCROLL
	EVENT_WINDOW_STATE        EventType = C.GDK_WINDOW_STATE
	EVENT_SETTING             EventType = C.GDK_SETTING
	EVENT_OWNER_CHANGE        EventType = C.GDK_OWNER_CHANGE
	EVENT_GRAB_BROKEN         EventType = C.GDK_GRAB_BROKEN
	EVENT_DAMAGE              EventType = C.GDK_DAMAGE
	EVENT_TOUCH_BEGIN         EventType = C.GDK_TOUCH_BEGIN
	EVENT_TOUCH_UPDATE        EventType = C.GDK_TOUCH_UPDATE
	EVENT_TOUCH_END           EventType = C.GDK_TOUCH_END
	EVENT_TOUCH_CANCEL        EventType = C.GDK_TOUCH_CANCEL
	EVENT_LAST                EventType = C.GDK_EVENT_LAST
)

type Atom byteptr

fn (v Atom) native() C.GdkAtom {
	return C.toGdkAtom(voidptr(byteptr(v)))
}

fn (v Atom) name() string {
	c := C.gdk_atom_name(v.native())
	defer C.g_free(C.pointer(c))
	return C.string((*C.char)(c))
}

fn gdk_atom_intern(atom_name string, only_if_exists bool) Atom {
	cstr := C.string(atom_name)
	defer C.free(voidptr(cstr))
	c := C.gdk_atom_intern((*C.char)(cstr), C.boolean(only_if_exists))
	return Atom(byteptr(voidptr(c)))
}

type Device struct {
	*glib.Object
}

fn (v *Device) native() *C.GdkDevice {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGdkDevice(p)
}

fn (v *Device) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn marshal_device(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := &glib.Object{glib.to_gobject(voidptr(c))}
	return &Device{obj}, voidptr
}

fn to_device(d *C.GdkDevice) (*Device, error) {
	obj := &glib.Object{glib.to_gobject(voidptr(d))}
	return &Device{obj}, voidptr
}

fn (v *Device) get_position(mut screen **Screen, mut x, y *int) error {
	mut cs := (**C.GdkScreen)(voidptr(byteptr(0)))

	if !isnil(screen) {
		mut cval := *C.GdkScreen{}
		cs = &cval
	}

	mut cx := (*C.int)(voidptr(byteptr(9)))

	if !isnil(x) {
		cval = C.int{}
		cx = &cval
	}

	mut cy := (*C.int)(voidptr(byteptr(0)))

	if !isnil(y) {
		cval = C.int{}
		cy = &cval
	}

	c.gdk_device_get_position(v.native(), cs, cx, cy)

	if cs != (**C.GdkScreen)(voidptr(byteptr(0))) {
		ms, err := to_screen(*cs)

		if !isnil(err) {
			return err
		}

		*screen = ms
	}

	if cx != (*C.int)(voidptr(byteptr(0))) {
		*x = int(*cx)
	}

	if cy != (C.int)(voidptr(byteptr(0))) {
		*y = int(*cy)
	}

	return voidptr
}

type Cursor struct {
	*glib.Object
}

fn (v *Cursor) new_from_name(display *Display, name string) (*Cursor, error) {
	cstr := C.string(name)
	defer C.free(voidptr(cstr))
	c := C.gdk_cursor_new_from_name(v.native(), display.native(), (*C.char)(cstr))

	if isnil(c) {
		return voidptr, voidptr_err
	}
}

fn (v *Cursor) native() *C.GdkCursor {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGdkCursor(p)
}

fn (v *Cursor) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn marshal_cursor(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := &glib.Object{glib.to_gobject(voidptr(c))}
	return &Cursor{obj}, voidptr
}

type DeviceManager struct {
	*glib.Object
}

fn (v *DeviceManager) native() *C.GdkDeviceManager {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGdkDeviceManager(p)
}

fn (v *DeviceManager) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn marshal_device_manager(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := &glib.Object{glib.to_gobject(voidptr(c))}
	return &DeviceManager{obj}, voidptr
}

fn (v *DeviceManager) get_display() (*Display, error) {
	c := C.gdk_device_manager_get_display(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return &Display{glib.Take(voidptr(c))}, voidptr
}

type Display struct {
	*glib.Object
}

fn (v *Display) native() *C.GdkDisplay {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGdkDisplay(p)
}

fn (v *Display) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn marshal_display(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := &glib.Object{glib.to_gobject(voidptr(c))}
	return &Display{obj}, voidptr
}

fn to_display(s *C.GdkDisplay) (*Display, error) {
	if isnil(s) {
		return voidptr, voidptr_err
	}

	obj := &glib.Object{glib.to_gobject(voidptr(s))}
	return &Display{obj}, voidptr
}

fn display_open(display_name string) (*Display, error) {
	cstr := C.string(display_name)
	defer C.free(voidptr(cstr))
	c := C.gdk_display_open((*C.char)(cstr))

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return &Display{glib.Take(voidptr(c))}, voidptr
}

fn display_get_default() (*Display, error) {
	c := C.gdk_display_get_default()

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return &Display{glib.Take(voidptr(c))}, voidptr
}

fn (v *Display) get_name() (string, error) {
	c := C.gdk_display_get_name(v.native())

	if isnil(c) {
		return '', voidptr_err
	}

	return C.string((*C.char)(c)), voidptr
}

fn (v *Display) get_default_screen() (*Screen, error) {
	c := C.gdk_display_get_default_screen(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return &Screen{glib.Take(voidptr(c))}, voidptr
}

fn (v *Display) device_is_grabbed(device *Device) bool {
	c := C.gdk_display_device_is_grabbed(v.native(), device.native())
	return bool(c)
}

fn (v *Display) beep() {
	C.gdk_display_beep(v.native())
}

fn (v *Display) sync() {
	C.gdk_display_sync(v.native())
}

fn (v *Display) flush() {
	C.gdk_display_flush(v.native())
}

fn (v *Display) close() {
	C.gdk_display_close(v.native())
}

fn (v *Display) is_closed() bool {
	c := C.gdk_display_is_closed(v.native())
	return bool(c)
}

fn (v *Display) get_event() (*Event, error) {
	c := C.gdk_display_get_event(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	e := &Event{c}
	runtime.set_finalizer(e, (*Event).free)
	return e, voidptr
}

fn (v *Display) peek_event() (*Event, error) {
	c := C.gdk_display_peek_event(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	e := &Event{c}
	runtime.set_finalizer(e, (*Event).free)
	return e, voidptr
}

fn (v *Display) put_event(event *Event) {
	C.gdk_display_put_event(v.native(), event.native())
}

fn (v *Display) has_pending() bool {
	c := C.gdk_display_has_pending(v.native())
	return bool(c)
}

fn (v *Display) set_double_click_time(msec u32) {
	C.gdk_display_set_double_click_time(v.native()m C.int(msec))
}

fn (v *Display) set_double_click_distance(distance u32) {
	C.gdk_display_supports_cursor_color(v.native())
	return bool(c)
}

fn (v *Display) supports_cursor_alpha() bool {
	c := C.gdk_display_supports_cursor_alpha(v.native())
	return bool(c)
}

fn (v *Display) get_default_cursor_size() u32 {
	c := C.gdk_display_get_default_cursor_size(v.native())
	return u32(c)
}

fn (v *Display) get_maximal_cursor_size() (width, height u32) {
	mut w, h := C.int(0)
	C.gdk_display_get_maximal_cursor_size(v.native(), &w, &h)
	return u32(w), u32(h)
}

fn (v *Display) get_default_group() (*Window, error) {
	c := C.gdk_display_get_default_group(v.native())

	if isnil(c) {
		return voidptr, voidptr_err
	}

	return &Window{glib.Take(voidptr(c))}, voidptr
}

fn (v *Display) supports_selection_notification() bool {
	c := C.gdk_display_supports_selection_notification(v.native())
	return bool(c)
}

fn (v *Display) request_selection_notification(selection Atom) bool {
	c := C.gdk_display_request_selection_notification(v.native(), selection.native())
	return bool(c)
}

fn (v *Display) supports_clipboard_persistence() bool {
	c := C.gdk_display_supports_clipboard_persistence(v.native())
	return bool(c)
}

fn (v *Display) supports_shapes() bool {
	c := C.gdk_display_supports_shapes(v.native())
	return bool(c)
}

fn (v *Display) supports_input_shapes() bool {
	c := C.gdk_display_supports_input_shapes(v.native())
	return bool(c)
}

fn (v *Display) notify_startup_complete(startup_id string) {
	cstr := C.string(startup_id)
	defer C.free(voidptr(cstr))
	C.gdk_display_notify_startup_complete(v.native(), (*C.char)(cstr))
}

fn keyval_from_name(keyval_name string) u32 {
	str := (*C.char)(C.string(keyval_name))
	defer C.free(voidptr(str))
	return u32(C.gdk_keyval_from_name(str))
}

fn keyval_convert_case(v u32) (lower, upper u32) {
	mut l, u := 0
 	C.gdk_keyval_convert_case(C.uint(v), &l, &u)
	return u32(l), u32(u)
}

fn keyval_is_lower(v u32) bool {
	return bool(C.gdk_keyval_is_lower(C.uint(v)))
}

fn keyval_is_upper(v u32) bool {
	return bool(C.gdk_keyval_is_upper(C.uint(v)))
}

fn keyval_to_lower(v u32) u32 {
	return u32(C.gdk_keyval_to_lower(C.uint(v)))
}

fn keyval_to_upper(v u32) u32 {
	return u32(C.gdk_keyval_to_upper(C.uint(v)))
}

fn keyval_to_unicode(v u32) rune {
	return rune(C.gdk_keyval_to_unicode(C.uint(v)))
}

fn unicode_to_keyval(v rune) u32 {
	return u32(C.gdk_unicode_to_keyval(C.uint(v)))
}

type DragContext struct {
	*glib.Object
}

fn (v *DragContext) native() *C.GdkDragContext {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGdkDragContext(p)
}

fn (v *DragContext) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn marshal_drag_context(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	obj := &glib.Object{glib.to_gobject(voidptr(c))}
	return &DragContext{obj}, voidptr
}

fn (v *DragContext) list_targets() *glib.List {
	c := C.gdk_drag_context_list_targets(v.native())
	return glib.wrap_list(byteptr(voidptr(c)))
}

type Event struct {
	gdk_event *C.GdkEvent
}

fn (v *Event) native() *C.GdkEvent {
	if isnil(v) {
		return voidptr
	}

	return v.gdk_event
}

fn (v *Event) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn marshal_event(p byteptr) (interface{}, error) {
	c := C.g_value_get_boxed((*C.value)(voidptr(p)))
	return &Event{(*C.GdkEvent)(voidptr(c))}, voidptr
}

fn (v *Event) free() {
	C.gdk_event_free(v.native())
}

type EventButton struct {
	*Event
}

fn (v *EventButton) new() *EventButton {
	ee := (*C.GdkEvent)(voidptr(&C.GdkEventButton{voidptr(v.event.native())}))
	ev := Event{ee}
	return &EventButton{&ev}
}

fn (v *EventButton) new_from_event(event *Event) *EventButton {
	ee := (*C.GdkEvent)(voidptr(voidptr(event.native())))
	ev := Event{ee}
	return &EventButton{&ev}
}

fn (v *EventButton) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn (v *EventButton) native() *C.GdkEventButton {
	return (*C.GdkEventButton)(voidptr(v.event.native()))
}

fn (v *EventButton) x() f64 {
	c := v.native().x
	return f64(c)
}

fn (v *EventButton) y() f64 {
	c := v.native().y
	return f64(c)
}

fn (v *EventButton) x_root() f64 {
	c := v.native().x_root
	return f64(c)
}

fn (v *EventButton) y_root() f64 {
	c := v.native().y_root
	return f64(c)
}

fn (v *EventButton) button() Button {
	c := v.native().button
	return Button(c)
}

fn (v *EventButton) state() u32 {
	c := v.native().state
	return u32(c)
}

fn (v *EventButton) time() EventType {
	c := v.native()._type
	return EventType(c)
}

fn (v *EventButton) motion_val() (f64, f64) {
	x := v.native().x
	y := v.native().y
	return f64(x), f64(y)
}

fn (v *EventButton) motion_val_root() (f64, f64) {
	x := v.native().x_root
	y := v.native().y_root
	return f64(x), f64(y)
}

type EventKey struct {
	*Event
}

fn (v *EventKey) new() *EventKey {
	ee := (*C.GdkEvent)(voidptr(&C.GdkEventKey{voidptr(v.event.native())}))
	ev := Event{ee}
	return &EventKey{&ev}
}

fn (v *EventKey) new_from_event(event *Event) *EventKey {
	ee := (*C.GdkEvent)(voidptr(v.event.native())
	ev := Event{ee}
	return &EventKey{&ev}
}

fn (v *EventKey) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn (v *EventKey) native() *C.GdkEventKey {
	return (*C.GdkEventKey)(voidptr(v.event.native()))
}

fn (v *EventKey) key_val() u32 {
	c := v.native().keyval
	return u32(c)
}

fn (v *EventKey) type() EventType {
	c := v.native._type()
	return EventType(c)
}

fn (v *EventKey) state() u32 {
	c := v.native().state
	return u32(c)
}

type EventMotion struct {
	*Event
}

fn (v *EventMotion) new() *EventMotion {
	ee := (*C.GdkEvent)(voidptr(&C.GdkEventMotion{v.event.native()}))
	ev := Event{ee}
	return &EventMotion{&ev}
}

fn (v *EventMotion) new_from_event(event *Event) *EventMotion {
	ee := (*C.GdkEvent)(voidptr(v.event.native()))
	ev := Event{ee}
	return &EventMotion{&ev}
}

fn (v *EventMotion) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn (v *EventMotion) native() *C.GdkEventMotion {
	return (*C.GdkEventMotion)(voidptr(v.event.native()))
}

fn (v *EventMotion) motion_val() (f64, f64) {
	x := v.native().x
	y := v.native().y
	return f64(x), f64(y)
}

fn (v *EventMotion) motion_val_root() (f64, f64) {
	x := v.native().x_root
	y := v.native().y_root
	return f64(x), f64(y)
}

fn (v *EventMotion) time() u32 {
	c := v.native().time
	return u32(c)
}

fn (v *EventMotion) type() EventType {
	c := c.native()._type
	return EventType(c)
}

fn (v *EventMotion) state() ModifierType {
	c := v.native().state
	return ModifierType(c)
}

type EventCrossing struct {
	*Event
}

fn (v *EventCrossing) new() *EventCrossing {
	ee := (*C.GdkEvent)(voidptr(&C.GdkEventCrossing{v.event.native()}))
	ev := Event{ee}
	return &EventCrossing{&ev}
}

fn (v *EventCrossing) new_from_event(event *Event) *EventCrossing {
	ee := (*C.GdkEvent)(voidptr(v.event.native()))
	ev := Event{ee}
	return &EventCrossing{&ev}
}

fn (v *EventCrossing) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn (v *EventCrossing) native() *C.GdkEventCrossing {
	return (*C.GdkEventCrossing)(voidptr(v.event.native()))
}

fn (v *EventCrossing) x() f64 {
	c := v.native().x
	return f64(c)
}

fn (v *EventCrossing) y() f64 {
	c := v.native().y
	return f64(c)
}

fn (v *EventCrossing) x_root() f64 {
	c := v.native().x_root
	return f64(c)
}

fn (v *EventCrossing) y_root() f64 {
	c := v.native().y_root
	return f64(c)
}

fn (v *EventCrossing) state() u32 {
	c := v.native().state
	return u32(c)
}

fn (v *EventCrossing) time() u32 {
	c := v.native().time
	return u32(c)
}

fn (v *EventCrossing) type() EventType {
	c := v.native()._type
	return EventType(c)
}

fn (v *EventCrossing) motion_val() (f64, f64) {
	x := v.native().x
	y := v.native().y
	return f64(x), f64(y)
}

fn (v *EventCrossing) motion_val_root() (f64, f64) {
	x := v.native().x_root
	y := v.native.y_root
	return f64(x), f64(y)
}

fn (v EventCrossing) mode() CrossingMode {
	c := v.native().mode
	return CrossingMode(c)
}

fn (v *EventCrossing) detail() NotifyType {
	c := v.native().detail
	return NotifyType(c)
}

fn (v *EventCrossing) focus() bool {
	c := v.native().focus
	return bool(c)
}
