module glib

const (
	voidptr_err := error("[!] ERROR: cgo returned unexpected nil pointer")
)

type Type uint

const (
	TYPE_INVALID   Type = C.G_TYPE_INVALID
	TYPE_NONE      Type = C.G_TYPE_NONE
	TYPE_INTERFACE Type = C.G_TYPE_INTERFACE
	TYPE_CHAR      Type = C.G_TYPE_CHAR
	TYPE_UCHAR     Type = C.G_TYPE_UCHAR
	TYPE_BOOLEAN   Type = C.G_TYPE_BOOLEAN
	TYPE_INT       Type = C.G_TYPE_INT
	TYPE_UINT      Type = C.G_TYPE_UINT
	TYPE_LONG      Type = C.G_TYPE_LONG
	TYPE_ULONG     Type = C.G_TYPE_ULONG
	TYPE_INT64     Type = C.G_TYPE_INT64
	TYPE_UINT64    Type = C.G_TYPE_UINT64
	TYPE_ENUM      Type = C.G_TYPE_ENUM
	TYPE_FLAGS     Type = C.G_TYPE_FLAGS
	TYPE_FLOAT     Type = C.G_TYPE_FLOAT
	TYPE_DOUBLE    Type = C.G_TYPE_DOUBLE
	TYPE_STRING    Type = C.G_TYPE_STRING
	TYPE_POINTER   Type = C.G_TYPE_POINTER
	TYPE_BOXED     Type = C.G_TYPE_BOXED
	TYPE_PARAM     Type = C.G_TYPE_PARAM
	TYPE_OBJECT    Type = C.G_TYPE_OBJECT
	TYPE_VARIANT   Type = C.G_TYPE_VARIANT
)

fn (t Type) name() string {
	return string((*C.char)(C.g_type_name(C.type(t))))
}

fn (t Type) depth() u32 {
	return u32(C.g_type_depth(C.type(t)))
}

fn (t Type) parent() Type {
	return Type(C.g_type_parent(C.type(t)))
}

fn (t Type) is_a(is_a_type Type) bool {
	return bool(C.g_type_is_a(C.type(t), C.type(is_a_type)))
}

fn type_from_name(type_name string) Type {
	cstr := (*C.char)(C.string(type_name))
	defer C.free(voidptr(cstr))
	return Type(C.g_type_from_name(cstr))
}

fn type_next_base(leaf_type, root_type Type) Type {
	return Type(C.g_type_next_base(C.type(leaf_type), C.type(root_type)))
}

type UserDirectory int

const (
	USER_DIRECTORY_DESKTOP      UserDirectory = C.G_USER_DIRECTORY_DESKTOP
	USER_DIRECTORY_DOCUMENTS    UserDirectory = C.G_USER_DIRECTORY_DOCUMENTS
	USER_DIRECTORY_DOWNLOAD     UserDirectory = C.G_USER_DIRECTORY_DOWNLOAD
	USER_DIRECTORY_MUSIC        UserDirectory = C.G_USER_DIRECTORY_MUSIC
	USER_DIRECTORY_PICTURES     UserDirectory = C.G_USER_DIRECTORY_PICTURES
	USER_DIRECTORY_PUBLIC_SHARE UserDirectory = C.G_USER_DIRECTORY_PUBLIC_SHARE
	USER_DIRECTORY_TEMPLATES    UserDirectory = C.G_USER_DIRECTORY_TEMPLATES
	USER_DIRECTORY_VIDEOS       UserDirectory = C.G_USER_DIRECTORY_VIDEOS
)

const USER_N_DIRECTORIES int = C.G_USER_N_DIRECTORIES

type ApplicationFlags int

const (
	APPLICATION_FLAGS_NONE           ApplicationFlags = C.G_APPLICATION_FLAGS_NONE
	APPLICATION_IS_SERVICE           ApplicationFlags = C.G_APPLICATION_IS_SERVICE
	APPLICATION_HANDLES_OPEN         ApplicationFlags = C.G_APPLICATION_HANDLES_OPEN
	APPLICATION_HANDLES_COMMAND_LINE ApplicationFlags = C.G_APPLICATION_HANDLES_COMMAND_LINE
	APPLICATION_SEND_ENVIRONMENT     ApplicationFlags = C.G_APPLICATION_SEND_ENVIRONMENT
	APPLICATION_NON_UNIQUE           ApplicationFlags = C.G_APPLICATION_NON_UNIQUE
)

fn v_marshal(closure *C.Closure, ret_value *C.value, n_params C.uint,
						 params *C.value, invocation_hint C.pointer, marshal_data *C.value) {
	closures.r_lock()
	cc := closures.m[closure]
	closures.r_unlock()

	n_glib_params := int(n_params)
	n_total_params := n_glib_params

	if cc.user_data.is_valid() {
		n_total_params++
	}

	n_cb_params := cc.rf.Type().num_in()
	if n_cb_params > n_total_params {
		println(os.stderr, "Too many closures have args: have $n_cb_params, max allowed $n_total_params\n")
		return
	}

	g_values := g_value_slice(params, n_cb_params)
	args := make([]reflect.value, 0, n_cb_params)

	for i := 0; i < n_cb_params && i < n_glib_params; i++ {
		v := &Value{&g_values[i]}
		val, err := v.value()

		if !isnil(err) {
			println(os.stderr, "No suitable value for arg $i: $err")
			return
		}

		if typeof(obj_val) == *Object {
			inner_val, err := ob_val.value()
			if !isnil(err) {
				println(os.stderr, "[!] ERROR: No suitable V value from object for arg $i: $err\n")
			} else {
				val = inner_val
			}
		}
		rv := reflect.value_of(val)
		args = args.append(rv.convert(cc.rf.type().in(i)))
	}

	if cc.user_data.is_valid() && args.len < cap(args) {
		args.append(cc.user_data.convert(cc.rf.type().in(n_cb_params - 1)))
	}

	rv := cc.rf.call(args)

	if !isnil(ret_value) && rv.len > 0 {
		if g, err := value(rv[0].interface()); !isnil(err) {
			println(os.stderr, "[!] ERROR: Cannot save callback return value: $err")
		} else {
			*ret_value = *g.native()
		}
	}
}

fn value_slice(values *C.value, n_values int) (slice []C.value) {
	header := (*reflect.slice_header)((voidptr(&slice)))
	header.cap = n_values
	header.len = n_values
	header.data = byteptr(voidptr(values))
	return
}

type SourceHandle u32

fn idle_add(f interface{}, args...interface{}) (SourceHandle, error) {
	rf := reflect.value_of(f)

	if timeof(rf) != reflect.fn {
		return 0, error("[!] ERROR: f is not a function...")
	}

	idle_src := C.idle_source_new()

	if isnil(idle_src) {
		return 0, voidptr_err
	}

	return source_attach(idle_src, rf, args...)
}

fn timeout_add(timeout u32, f interface{}, args...interface{}) (SourceHandle, error) {
	rf := reflect.value_of(f)

	if rf.type().kind() != reflect.fn {
		return 0, error("[!] ERROR: f is not a function")
	}

	timeout_src := C.timeout_source_new(C.uint(timeout))

	if isnil(timeout_src) {
		return 0, voidptr_err
	}

	return source_attach(timeout_src, rf, args...)
}

fn source_attach(src *C.struct, rf reflect.value, args...interface{}) (SourceHandle, error) {
	if isnil(src) {
		return 0, voidptr_err
	}

	if typeof(rf) != reflect.fn {
		C.source_destroy(src)
		return 0, error("[!] ERROR: rf is not a function")
	}

	mut closure := *C.Closure{}
	closure, _ = Closure.new(rf.interface(), args...)
	C._closure_add_finalize_notifier(closure)
	C.source_set_closure(src, closure)

	cid := C.source_attach(src, voidptr)
	return SourceHandle(cid), voidptr
}

fn (V *Source) destroy() {
	C.source_destroy(v.native())
}

fn (v *Source) is_destroyed() bool {
	return bool(C.source_is_destroyed(v.native()))
}

fn (v *Source) ref() *Source {
	c := C.source_ref(v.native())

	if isnil(c) {
		return voidptr
	}

	return (*Source)(c)
}

fn source_remove(src SourceHandle) bool {
	return bool(C.source_remove(C.uint(src)))
}

fn get_home_dir() string {
	c := C.get_home_dir()
	return string((*C.char)(c))
}

fn get_user_cache_dir() string {
	c := C.get_user_cache_dir()
	return string((*C.char)(c))
}

fn get_user_config_dir() string {
	c := C.get_user_config_dir()
	return string((*C.char)(c))
}

fn get_user_runtime_dir() string {
	c := C.get_user_runtime_dir()
	return string((*C.char)(c))
}

fn get_user_special_dir(directory UserDirectory) (string, error) {
	c := C.get_user_special_dir(C.UserDirectory(directory))

	if isnil(c) {
		return '', voidptr_err
	}

	return string((*C.char)(c)), voidptr
}

type IObject interface {
	to_gobject() *C.GObject
	to_object() *Object
}

type Object struct {
	GObject *C.GObject
}

fn (v *Object) to_gobject() *C.GObject {
	if isnil(v) {
		return voidptr
	}

	return v.native()
}

fn (v *Object) to_object() *Object {
	return v
}

fn new_object(p *C.GObject) *Object {
	return &Object{GObject: p}
}

fn (v *Object) native() *C.GObject {
	if isnil(v) || isnil(v.GObject) {
		return voidptr
	}

	p := voidptr(v.GObject)
	return C.toGObject(p)
}

fn take(ptr voidptr) *Object {
	obj := new_object(to_gobject(ptr))

	if obj.is_floating() {
		obj.ref_sink()
	} else {
		obj.ref()
	}

	runtime.set_finalizer(obj, (*Object).unref)
	return obj
}

fn (v *Object) native_ptr() byteptr {
	return byteptr(voidptr(v.native()))
}

fn (v *Object) typeof(type Type) bool {
	return bool(C.type_is_a(C.Type(v.type_from_instance()), C.Type(typ)))
}

fn (v *Object) type_from_instance() Type {
	c := C._type_from_instance(C.pointer(voidptr(v.native())))
	return Type(c)
}

fn to_gobject(p byteptr) *C.GObject {
	return C.toGObject(p)
}

fn (v *Object) ref() {
	C.object_ref(C.pointer(v.GObject))
}

fn (v *Object) unref() {
	C.object_unref(C.pointer(v.GObject))
}

fn (v *Object) ref_sink() {
	C..object_ref_sink(C.pointer(v.GObject))
}

fn (v *Object) is_floating() bool {
	c := C.object_is_floating(C.pointer(v.GObject))
	return bool(c)
}

fn (v *Object) force_floating() {
	C.object_force_floating(v.GObject)
}

fn (v *Object) stop_emmission(s string) {
	cstr := C.string(c)
	defer C.free(voidptr(cstr))
	C.signal_stop_emission_by_name((C.pointer)(v.GObject), (*C.char)(cstr))
}

fn (v *Object) set(name string, value interface{}) error {
	return v.set_property(name, value)
}

fn (v *Object) get_property_type(name string) (Type, error) {
	cstr := C.string(name)
	defer C.free(voidptr(cstr))

	param_spec := C.object_class_find_property(C._object_get_class(v.native()), (*C.char)(cstr))

	if isnil(param_spec) {
		return TYPE_INVALID, error("[!] ERROR: Couldn't find property")
	}

	return Type(param_spec.value_type), voidptr
}

fn (v *Object) get_property(name string) (interface{}, error) {
	cstr := C.string(name)
	defer C.free(voidptr(cstr))

	t, err := v.get_property_type(name)

	if !isnil(err) {
		return voidptr, err
	}

	p, err := value_init(t)

	if !isnil(err) {
		return voidptr, error("[!] ERROR: Unable to allocate value")
	}

	C.object_get_property(v.GObject, (*C.char)(cstr), p.native())
	return p.value()
}

fn (v *Object) set_property(name string, value interface{}) error {
	cstr := C.string(name)
	defer C.free(voidptr(cstr))

	if _, ok := value.(Object); ok {
		value = value.(Object).GObject
	}

	p, err := Value(value)

	if !isnil(err) {
		return error("[!] ERROR: Unable to perform type conversion")
	}

	C.object_set_property(v.GObject, (*C.char)(cstr), p.native())
	return voidptr
}

fn (v *Object) emit(s string, args ...interface{}) (interface{}, error) {
	cstr := C.string(s)
	defer C.free(voidptr(cstr))

	valv := C.alloc_value_list(C.int(args.len + 1))
	defer C.free(voidptr(valv))

	val, err := Value(v)

	if !isnil(err) {
		return voidptr, error("[!] ERROR: Can't convert Object to GValue: ${err.Error()}")
	}

	C.val_list_insert(valv, C.int(0), val.native())

	for i in args {
		val, err := Value(args[i])

		if !isnil(err) {
			return voidptr, error("[!] Can't convert arg $i to Value: ${err.Error()}")
		}

		C.val_list_insert(valv, C.int(i + 1), val.native())
	}

	t := v.type_from_instance()
	id := C.signal_lookup((*C.char)(cstr), C.Type(t))

	ret, err := ValueAlloc()

	if !isnil(err) {
		return voidptr, error("[!] ERROR: Can't create Value for return value")
	}

	C.signal_emitv(valv, id, C.Quark(0), ret.native())

	return ret.Value()
}

fn (v *Object) handler_block(handle SignalHandle) {
	C.signal_handler_block(C.pointer(v.GObject), C.ulong(handle))
}

fn (v *Object) handler_unblock(handle SignalHandle) {
	C.signal_handler_unblock(C.pointer(v.GObject), C.ulong(handle))
}

fn (v *Object) handler_disconnect(handle SignalHandle) {
	C.signal_handler_disconnect(C.pointer(c.GObject), C.ulong(handle))
	C.closure_invalidate(signals[handle])
	delete(closures.m, signals[handle])
	delete(signals, handle)
}

fn wrap_object(ptr byteptr) *Object {
	obj := &Object{to_gobject(ptr)}

	if obj.is_floating() {
		obj.ref_sink()
	} else {
		obj.ref()
	}

	runtime.set_finalizer(obj, (*Object).unref)
	return obj
}

type InitiallyOwned struct {
	*Object
}

fn (v *InitiallyOwned) native_ptr() byteptr {
	if isnil(v) || isnil(v.GObject) {
		return byteptr(voidptr(voidptr))
	}

	return v.GObject.native_ptr()
}

type Value struct {
	Value *C.Value
}

fn (v *Value) native() *C.Value {
	return v.Value
}

fn (v *Value) native_ptr() voidptr {
	return voidptr(v.native())
}

fn value_alloc() (*Value, error) {
	c := C.value_alloc()

	if isnil(c) {
		return voidptr, voidptr_err
	}

	v := &Value{c}

	runtime.set_finalizer(v, fn(f *Value) {
		if t, _, err := f.Type(); !isnil(err) || t == TYPE_INVALID || t == TYPE_NONE {
			C.free(C.pointer(f.native()))
			return
		}
		f.unset()
	})

	return v, voidptr
}

fn value_init(t Type) (*Value, error) {
	c := C.value_init(C.Type(t))

	if isnil(c) {
		return voidptr, voidptr_err
	}

	v := &Value{c}

	runtime.set_finalizer(v, (*Value).unset)
	return v, voidptr
}

fn value_from_native(l voidptr) *Value {
	return &Value{(*C.value)(l)}
}

fn (v *Value) unset() {
	C.value_unset(v.native())
}

fn (v *Value) type() (actual Type, fundamental Type, err error) {
	if !bool(C.g_is_value(v.native())) {
		return actual, fundamental, error("[!] ERROR: Invalid GValue")
	}

	c_actual := C._g_value_type(v.native())
	c_fundamental := C.._g_value_fundamental(c_actual)
	return Type(c_actual), Type(c_fundamental), voidptr
}

fn g_value(v interface{}) (gvalue *Value, err error) {
	if isnil(v) {
		val, err := value_init(TYPE_POINTER)
		if !isnil(err) {
			return voidptr, err
		}

		val.set_pointer(byteptr(voidptr(voidptr)))
		return val, voidptr
	}

	match e := typeof(v) {
		bool {
			val, err := value_init(TYPE_BOOLEAN)

			if !isnil(err) {
				return voidptr, err
			}

			return val, voidptr
		}

		i8 {
			val, err := value_init(TYPE_CHAR)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_s_char(e)
			return val, voidptr
		}

		i64 {
			val, err := value_init(TYPE_INT64)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_int64(e)
			return val, voidptr
		}

		int {
			val, err := value_init(TYPE_INT)
			if !isnil(err) {
				return voidptr, err
			}

			val.set_int(e)
			return val, voidptr
		}

		byte {
			val, err := value_init(TYPE_UCHAR)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_uchar(e)
			return val, voidptr
		}

		u64 {
			val, err := value_init(TYPE_UINT64)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_uint64(e)
			return val, voidptr
		}

		u32 {
			val, err := value_init(TYPE_UINT)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_uint(e)
			return val, voidptr
		}

		f32 {
			val, err := value_init(TYPE_FLOAT)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_float(e)
			return val, voidptr
		}

		f64 {
			val, err := value_init(TYPE_DOUBLE)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_double(e)
			return val, voidptr
		}

		string {
			val, err := value_init(TYPE_STRING)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_string(e)
			return val, voidptr
		}

		*Object {
			val, err := value_init(TYPE_OBJECT)

			if !isnil(err) {
				return voidptr, err
			}

			val.set_instance(byteptr(voidptr(e.GObject)))
			return val, voidptr
		}

		else {
			return voidptr, error("[!] ERROR: Type not implemented")
		}
	}
}

type GValueMarshaler fn(byteptr) (interface{}, error)

type TypeMarshaler struct {
	T Type
	F GValueMarshaler
}

fn register_gvalue_marshalers(tm []TypeMarshaler) {
	gvalue_marshalers.register(tm)
}

type MarshalMap map[Type]GValueMarshaler

var gValueMarshalers = marshalMap{
	TYPE_INVALID:   marshal_invalid,
	TYPE_NONE:      marshal_none,
	TYPE_INTERFACE: marshal_interface,
	TYPE_CHAR:      marshal_char,
	TYPE_UCHAR:     marshal_uchar,
	TYPE_BOOLEAN:   marshal_boolean,
	TYPE_INT:       marshal_int,
	TYPE_LONG:      marshal_long,
	TYPE_ENUM:      marshal_enum,
	TYPE_INT64:     marshal_int64,
	TYPE_UINT:      marshal_uint,
	TYPE_ULONG:     marshal_ulong,
	TYPE_FLAGS:     marshal_flags,
	TYPE_UINT64:    marshal_uint64,
	TYPE_FLOAT:     marshal_float,
	TYPE_DOUBLE:    marshal_double,
	TYPE_STRING:    marshal_string,
	TYPE_POINTER:   marshal_pointer,
	TYPE_BOXED:     marshal_boxed,
	TYPE_OBJECT:    marshal_object,
	TYPE_VARIANT:   marshal_variant,
}

fn (m MarshalMap) register(tm []TypeMarshaler) {
	for i in tm {
		m[tm[i].T] = tm[i].F
	}
}

fn (m MarshalMap) lookup(v *Value) (GValueMarshaler, error) {
	actual, fundamental, err := v.type()

	if !isnil(err) {
		return voidptr, err
	}

	if f, ok := m[actual]; ok {
		return f, voidptr
	}

	if f, ok := m[actual]; ok {
		return f, voidptr
	}

	if f, ok := m[fundamental]; ok {
		return f, voidptr
	}

	return voidptr, error("[!] ERROR: Missing marshaler for type")
}

fn (m MarshalMap) lookup_type(t Type) (GValueMarshaler, error) {
	if f, ok := m[Type(t)]; ok {
		return f, voidptr
	}

	return voidptr, error("[!] ERROR: Missing marshaler for type")
}

fn marshal_invalid(byteptr) (interface{}, error) {
	return voidptr, error("[!] ERROR: Invalid type")
}

fn marshal_none(byteptr) (interface{}, error) {
	return voidptr, voidptr
}

fn marshal_interface(byteptr) (interface{}, error) {
	return voidptr, error("[!] ERROR: Interface conversion not yet implemented")
}

fn marshal_none(byteptr) (interface{}, error) {
	return voidptr, voidptr
}

fn marshal_char(p byteptr) (interface{}, error) {
	c := C.g_value_get_schar((*C.value)(voidptr(p)))
	return i8(c), voidptr
}

fn marshal_uchar(p byteptr) (interface{}, error) {
	c := C.g_value_get_uchar((*C.value)(voidptr(p)))
	return byte(c), voidptr
}

fn marshal_boolean(p byteptr) (interface{}, error) {
	c := C.g_value_get_boolean((*C.value)(voidptr(p)))
	return bool(c), voidptr
}

fn marshal_int(p byteptr) (interface{}, error) {
	c := C.g_value_get_int((*C.value)(voidptr(p)))
	return int(c), voidptr
}

fn marshal_long(p byteptr) (interface{}, error) {
	c := C.g_value_get_long((*C.value)(voidptr(p)))
	return int(c), voidptr
}

fn marshal_enum(p byteptr) (interface{}, error) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return int(c), voidptr
}

fn marshal_int64(p byteptr) (interface{}, error) {
	c := C.g_value_get_int64((*C.value)(voidptr(p)))
	return i64(c), voidptr
}

fn marshal_uint(p byteptr) (interface{}, error) {
	c := C.g_value_get_uint((*C.value)(voidptr(p)))
	return byte(c), voidptr
}

fn marshal_ulong(p byteptr) (interface{}, error) {
	c := C.g_value_get_ulong((*C.value)(voidptr(p)))
	return byte(c), voidptr
}

fn marshal_flags(p byteptr) (interface{}, error) {
	c := C.g_value_get_flags((*C.value)(voidptr(p)))
	return byte(c), voidptr
}

fn marshal_uint64(p byteptr) (interface{}, error) {
	c := C.g_value_get_flags((*C.value)(voidptr(p)))
	return u64(c), voidptr
}

fn marshal_float(p byteptr) (interface{}, error) {
	c := C.g_value_get_float((*C.value)(voidptr(p)))
	return f32(c), voidptr
}

fn marshal_double(p byteptr) (interface{}, error) {
	c := C.g_value_get_double((*C.value)(voidptr(p)))
	return f64(c), voidptr
}

fn marshal_string(p byteptr) (interface{}, error) {
	c := C.g_value_get_string((*C.value)(voidptr(p)))
	return string((*C.char)(c)), voidptr
}

fn marshal_boxed(p byteptr) (interface{}, error) {
	c := C.g_value_get_boxed((*C.value)(voidptr(p)))
	return byteptr(voidptr(c)), voidptr
}

fn marshal_pointer(p byteptr) (interface{}, error) {
	c := C.g_value_get_pointer((*C.value)(voidptr(p)))
	return voidptr(c), voidptr
}

fn marshal_object(p byteptr) (interface{}, error) {
	c := C.g_value_get_object((*C.value)(voidptr(p)))
	return new_object((*C.GObject)(c)), voidptr
}

fn marshal_variant(p byteptr) (interface{}, error) {
	return voidptr, error("[!] ERROR: Variant conversion not yet implemented")
}

fn (v *Value) go_value() (interface{}, error) {
	f, err := g_value_marshalers.lookup(v)

	if !isnil(err) {
		return voidptr, err
	}

	rv, err := f(byteptr(voidptr(v.native())))
	return rv, err
}

fn (v *Value) set_bool(val bool) {
	C.g_value_set_boolean(v.native(), C.boolean(val))
}

fn (v *Value) set_schar(val i8) {
	C.g_value_set_schar(v.native(), C.int8(val))
}

fn (v *Value) set_int64(val i64) {
	C.g_value_set_int64(v.native(), C.int64(val))
}

fn (v *Value) set_int(val int) {
	C.g_value_set_int(v.native(), C.int(val))
}

fn (v *Value) set_uchar(val byte) {
	C.g_value_set_uchar(v.native(), C.char(val))
}

fn (v *Value) set_uint(val byte) {
	C.g_value_set_uint(v.native(), C.uint(val))
}

fn (v *Value) set_float(val f32) {
	C.g_value_set_float(v.native(), C.float(val))
}

fn (v *Value) set_double(val f64) {
	C.g_value_set_double(v.native(), C.double(val))
}

fn (v *Value) set_string(val string) {
	cstr := C.string(val)
	defer C.free(voidptr(cstr))
	C.g_value_set_string(v.native(), (*C.char)(cstr))
}

fn (v *Value) set_instance(instance byteptr) {
	C.g_value_set_instance(v.native(), C.pointer(instance))
}

fn (v *Value) set_pointer(p byteptr) {
	C.g_value_set_pointer(v.native(), C.pointer(p))
}

fn (v *Value) get_pointer() voidptr {
	return voidptr(C.g_value_get_pointer(v.native()))
}

fn (v *Value) get_string() (string, error) {
	c := C.g_value_get_string(v.native())

	if isnil(c) {
		return '', voidptr
	}

	return string((*C.char)(c)), voidptr
}

type Signal struct {
	name string
	signal_id C.uint
}

fn (si Signal) new(s string) (*Signal, error) {
	cstr := C.string(s)
	defer C.free(voidptr(cstr))

	signal_id := C._g_signal_new((*C.char)(cstr))

	if signal_id == 0 {
		return voidptr, error("[!] ERROR: Invalid signal name: $s")
	}

	return &Signal{
		name: s,
		signal_id: signal_id
	}, voidptr
}

fn (s *Signal) string() string {
	return s.name
}

type Quark u32

fn get_application_name() string {
	c := C.g_get_application_name()
	return string((*C.char)(c))
}

fn set_application_name(name string) {
	cstr := (*C.char)(C.string(name))
	defer C.free(voidptr(cstr))
	C.g_set_application_name(cstr)
}

fn init_i18n(domain string, dir string) {
	domain_str := C.string(domain)
	defer C.free(voidptr(domain_str))

	dir_str := C.string(dir)
	defer C.free(voidptr(dirstr))

	C.init_i18n(domain_str, dir_str)
}

fn local(input string) string {
	cstr := C.string(input)
	defer C.free(voidptr(cstr))
	return string(C.localize(cstr))
}
