module gtk

fn init() {
	tm := []glib.TypeMarshaler{
		{glib.Type(C.gtk_align_get_type()), marshal_align},
		{glib.Type(C.gtk_accel_flags_get_type()), marshal_accel_flags},
		{glib.Type(C.gtk_accel_group_get_type()), marshal_accel_group},
		{glib.Type(C.gtk_accel_map_get_type()), marshal_accel_map},
		{glib.Type(C.gtk_arrow_placement_get_type()), marshal_arrow_placement},
		{glib.Type(C.gtk_arrow_type_get_type()), marshal_arrow_type},
		{glib.Type(C.gtk_assistant_page_type_get_type()), marshal_assistant_page_type},
		{glib.Type(C.gtk_buttons_type_get_type()), marshal_buttons_type},
		{glib.Type(C.gtk_calendar_display_options_get_type()), marshal_calendar_display_options},
		{glib.Type(C.gtk_corner_type_get_type()), marshal_corner_type},
		{glib.Type(C.gtk_dest_defaults_get_type()), marshal_dest_defaults},
		{glib.Type(C.gtk_dialog_flags_get_type()), marshal_dialog_flags},
		{glib.Type(C.gtk_entry_icon_position_get_type()), marshal_entry_icon_position},
		{glib.Type(C.gtk_file_chooser_action_get_type()), marshal_file_chooser_action},
		{glib.Type(C.gtk_icon_lookup_flags_get_type()), marshal_sort_type},
		{glib.Type(C.gtk_icon_size_get_type()), marshal_icon_size},
		{glib.Type(C.gtk_image_type_get_type()), marshal_image_type},
		{glib.Type(C.gtk_input_hints_get_type()), marshal_input_hints},
		{glib.Type(C.gtk_input_purpose_get_type()), marshal_input_purpose},
		{glib.Type(C.gtk_justification_get_type()), marshal_justification},
		{glib.Type(C.gtk_license_get_type()), marshal_license},
		{glib.Type(C.gtk_message_type_get_type()), marshal_message_type},
		{glib.Type(C.gtk_orientation_get_type()), marshal_orientation},
		{glib.Type(C.gtk_pack_type_get_type()), marshal_pack_type},
		{glib.Type(C.gtk_path_type_get_type()), marshal_path_type},
		{glib.Type(C.gtk_policy_type_get_type()), marshal_policy_type},
		{glib.Type(C.gtk_position_type_get_type()), marshal_position_type},
		{glib.Type(C.gtk_relief_style_get_type()), marshal_relief_style},
		{glib.Type(C.gtk_response_type_get_type()), marshal_response_type},
		{glib.Type(C.gtk_selection_mode_get_type()), marshal_selection_mode},
		{glib.Type(C.gtk_shadow_type_get_type()), marshal_shadow_type},
		{glib.Type(C.gtk_sort_type_get_type()), marshal_sort_type},
		{glib.Type(C.gtk_state_flags_get_type()), marshal_state_flags},
		{glib.Type(C.gtk_target_flags_get_type()), marshal_target_flags},
		{glib.Type(C.gtk_text_direction_get_type()), marshal_text_direction},
		{glib.Type(C.gtk_text_search_flags_get_type()), marshal_text_search_flags},
		{glib.Type(C.gtk_toolbar_style_get_type()), marshal_toolbar_style},
		{glib.Type(C.gtk_tree_model_flags_get_type()), marshal_treeModel_flags},
		{glib.Type(C.gtk_window_position_get_type()), marshal_window_position},
		{glib.Type(C.gtk_window_type_get_type()), marshal_window_type},
		{glib.Type(C.gtk_wrap_mode_get_type()), marshal_wrap_mode},
		{glib.Type(C.gtk_accel_group_get_type()), marshal_accel_group},
		{glib.Type(C.gtk_accel_map_get_type()), marshal_accel_map},
		{glib.Type(C.gtk_adjustment_get_type()), marshal_adjustment},
		{glib.Type(C.gtk_application_get_type()), marshal_application},
		{glib.Type(C.gtk_application_window_get_type()), marshal_application_window},
		{glib.Type(C.gtk_assistant_get_type()), marshal_assistant},
		{glib.Type(C.gtk_bin_get_type()), marshal_bin},
		{glib.Type(C.gtk_builder_get_type()), marshal_builder},
		{glib.Type(C.gtk_button_get_type()), marshal_button},
		{glib.Type(C.gtk_button_box_get_type()), marshal_button_box},
		{glib.Type(C.gtk_box_get_type()), marshal_box},
		{glib.Type(C.gtk_calendar_get_type()), marshal_calendar},
		{glib.Type(C.gtk_cell_layout_get_type()), marshal_cell_layout},
		{glib.Type(C.gtk_cell_renderer_get_type()), marshal_cell_renderer},
		{glib.Type(C.gtk_cell_renderer_spinner_get_type()), marshal_cell_renderer_spinner},
		{glib.Type(C.gtk_cell_renderer_pixbuf_get_type()), marshal_cell_renderer_pixbuf},
		{glib.Type(C.gtk_cell_renderer_text_get_type()), marshal_cell_renderer_text},
		{glib.Type(C.gtk_cell_renderer_progress_get_type()), marshal_cell_renderer_progress},
		{glib.Type(C.gtk_cell_renderer_toggle_get_type()), marshal_cell_renderer_toggle},
		{glib.Type(C.gtk_check_button_get_type()), marshal_check_button},
		{glib.Type(C.gtk_check_menu_item_get_type()), marshal_check_menu_item},
		{glib.Type(C.gtk_clipboard_get_type()), marshal_clipboard},
		{glib.Type(C.gtk_container_get_type()), marshal_container},
		{glib.Type(C.gtk_dialog_get_type()), marshal_dialog},
		{glib.Type(C.gtk_drawing_area_get_type()), marshal_drawing_area},
		{glib.Type(C.gtk_editable_get_type()), marshal_editable},
		{glib.Type(C.gtk_entry_get_type()), marshal_entry},
		{glib.Type(C.gtk_entry_buffer_get_type()), marshal_entry_buffer},
		{glib.Type(C.gtk_entry_completion_get_type()), marshal_entry_completion},
		{glib.Type(C.gtk_event_box_get_type()), marshal_event_box},
		{glib.Type(C.gtk_expander_get_type()), marshal_expander},
		{glib.Type(C.gtk_file_chooser_get_type()), marshal_file_chooser},
		{glib.Type(C.gtk_file_chooser_button_get_type()), marshal_file_chooser_button},
		{glib.Type(C.gtk_file_chooser_dialog_get_type()), marshal_file_chooser_dialog},
		{glib.Type(C.gtk_file_chooser_widget_get_type()), marshal_file_chooser_widget},
		{glib.Type(C.gtk_frame_get_type()), marshal_frame},
		{glib.Type(C.gtk_aspect_frame_get_type()), marshal_aspect_frame},
		{glib.Type(C.gtk_grid_get_type()), marshal_grid},
		{glib.Type(C.gtk_icon_view_get_type()), marshal_icon_view},
		{glib.Type(C.gtk_image_get_type()), marshal_image},
		{glib.Type(C.gtk_label_get_type()), marshal_label},
		{glib.Type(C.gtk_link_button_get_type()), marshal_link_button},
		{glib.Type(C.gtk_lock_button_get_type()), marshal_lock_button},
		{glib.Type(C.gtk_layout_get_type()), marshal_layout},
		{glib.Type(C.gtk_tree_model_sort_get_type()), marshal_tree_model_sort},
		{glib.Type(C.gtk_list_store_get_type()), marshal_list_store},
		{glib.Type(C.gtk_menu_get_type()), marshal_menu},
		{glib.Type(C.gtk_menu_bar_get_type()), marshal_menu_bar},
		{glib.Type(C.gtk_menu_button_get_type()), marshal_menu_button},
		{glib.Type(C.gtk_menu_item_get_type()), marshal_menu_item},
		{glib.Type(C.gtk_menu_shell_get_type()), marshal_menu_shell},
		{glib.Type(C.gtk_message_dialog_get_type()), marshal_message_dialog},
		{glib.Type(C.gtk_notebook_get_type()), marshal_notebook},
		{glib.Type(C.gtk_offscreen_window_get_type()), marshal_offscreen_window},
		{glib.Type(C.gtk_orientable_get_type()), marshal_orientable},
		{glib.Type(C.gtk_overlay_get_type()), marshal_overlay},
		{glib.Type(C.gtk_paned_get_type()), marshal_paned},
		{glib.Type(C.gtk_progress_bar_get_type()), marshal_progress_bar},
		{glib.Type(C.gtk_radio_button_get_type()), marshal_radio_button},
		{glib.Type(C.gtk_radio_menu_item_get_type()), marshal_radio_menu_item},
		{glib.Type(C.gtk_range_get_type()), marshal_range},
		{glib.Type(C.gtk_scale_button_get_type()), marshal_scale_button},
		{glib.Type(C.gtk_scale_get_type()), marshal_scale},
		{glib.Type(C.gtk_scrollbar_get_type()), marshal_scrollbar},
		{glib.Type(C.gtk_scrolled_window_get_type()), marshal_scrolled_window},
		{glib.Type(C.gtk_search_entry_get_type()), marshal_search_entry},
		//{glib.Type(C.gtk_selection_data_get_type()), marshalSelectionData},
		{glib.Type(C.gtk_separator_get_type()), marshal_separator},
		{glib.Type(C.gtk_separator_menu_item_get_type()), marshal_separator_menu_item},
		{glib.Type(C.gtk_separator_tool_item_get_type()), marshal_separator_tool_item},
		{glib.Type(C.gtk_spin_button_get_type()), marshal_spin_button},
		{glib.Type(C.gtk_spinner_get_type()), marshal_spinner},
		{glib.Type(C.gtk_statusbar_get_type()), marshal_statusbar},
		{glib.Type(C.gtk_switch_get_type()), marshal_switch},
		{glib.Type(C.gtk_text_view_get_type()), marshal_text_view},
		{glib.Type(C.gtk_text_tag_get_type()), marshal_text_tag},
		{glib.Type(C.gtk_text_tag_table_get_type()), marshal_text_tag_table},
		{glib.Type(C.gtk_text_buffer_get_type()), marshal_text_buffer},
		{glib.Type(C.gtk_toggle_button_get_type()), marshal_toggle_button},
		{glib.Type(C.gtk_toolbar_get_type()), marshal_toolbar},
		{glib.Type(C.gtk_tool_button_get_type()), marshal_tool_button},
		{glib.Type(C.gtk_toggle_tool_button_get_type()), marshal_toggle_tool_button},
		{glib.Type(C.gtk_tool_item_get_type()), marshal_tool_item},
		{glib.Type(C.gtk_tooltip_get_type()), marshal_tooltip},
		{glib.Type(C.gtk_tree_model_get_type()), marshal_tree_model},
		{glib.Type(C.gtk_tree_sortable_get_type()), marshal_tree_sortable},
		{glib.Type(C.gtk_tree_selection_get_type()), marshal_tree_selection},
		{glib.Type(C.gtk_tree_store_get_type()), marshal_tree_store},
		{glib.Type(C.gtk_tree_view_get_type()), marshal_tree_view},
		{glib.Type(C.gtk_tree_view_column_get_type()), marshal_tree_view_column},
		{glib.Type(C.gtk_volume_button_get_type()), marshal_volume_button},
		{glib.Type(C.gtk_widget_get_type()), marshal_widget},
		{glib.Type(C.gtk_window_get_type()), marshal_window},
		{glib.Type(C.gtk_window_group_get_type()), marshal_window_group},
		{glib.Type(C.gtk_target_entry_get_type()), marshal_target_entry},
		{glib.Type(C.gtk_text_iter_get_type()), marshal_text_iter},
		{glib.Type(C.gtk_text_mark_get_type()), marshal_text_mark},
		{glib.Type(C.gtk_tree_iter_get_type()), marshal_tree_iter},
		{glib.Type(C.gtk_tree_path_get_type()), marshal_tree_path},
	}
}

fn free(str ...interface{}) {
	for _, s in str {
		match x := s.(type) {
			*C.char { C.free(voidptr(x)) }
			[]*C.char {
				for _, cp in x {
					C.free(voidptr(cp))
				}
			}
			else { println("utils.v free(): Unknown type: $x\n")}
		}
	}
}

voidptr_err = error("[!] ERROR: cgo returned unexpected nil pointer")

type Align int

const (
	ALIGN_FILL Align = C.GTK_ALIGN_FILL
	ALIGN_START Align = C.GTK_ALIGN_START
	ALIGN_END Align = C.GTK_ALIGN_END
	ALIGN Align = C.GTK_ALIGN_CENTER
)

fn marshal_align(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return Align(c), voidptr
}

type ArrowPlacement int

const (
	ARROWS_BOTH ArrowPlacement = C.GTK_ARROWS_BOTH
	ARROWS_START ArrowPlacement = C.GTK_ARROWS_START
	ARROWS_END ArrowPlacement = C.GTK_ARROWS_END
)

fn marshal_arrow_placement(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return ArrowPlacement(c), voidptr
}

type ArrowType int

const (
	ARROW_UP ArrowType = C.GTK_ARROW_UP
	ARROW_DOWN ArrowType = C.GTK_ARROW_DOWN
	ARROW_LEFT ArrowType = C.GTK_ARROW_LEFT
	ARROW_RIGHT ArrowType = C.GTK_ARROW_RIGHT
	ARROW_NONE ArrowType = C.GTK_ARROW_NONE
)

fn marshal_arrow_type(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return ArrowType(c), voidptr
}

type AssistantPageType int

const (
	ASSISTANT_PAGE_CONTENT  AssistantPageType = C.GTK_ASSISTANT_PAGE_CONTENT
	ASSISTANT_PAGE_INTRO    AssistantPageType = C.GTK_ASSISTANT_PAGE_INTRO
	ASSISTANT_PAGE_CONFIRM  AssistantPageType = C.GTK_ASSISTANT_PAGE_CONFIRM
	ASSISTANT_PAGE_SUMMARY  AssistantPageType = C.GTK_ASSISTANT_PAGE_SUMMARY
	ASSISTANT_PAGE_PROGRESS AssistantPageType = C.GTK_ASSISTANT_PAGE_PROGRESS
	ASSISTANT_PAGE_CUSTOM   AssistantPageType = C.GTK_ASSISTANT_PAGE_CUSTOM
)

fn marshal_assistant_page_type(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum(*C.value)(voidptr(p))
	return AssistantPageType(c), voidptr
}

type ButtonsType int

const (
	BUTTONS_NONE      ButtonsType = C.GTK_BUTTONS_NONE
	BUTTONS_OK        ButtonsType = C.GTK_BUTTONS_OK
	BUTTONS_CLOSE     ButtonsType = C.GTK_BUTTONS_CLOSE
	BUTTONS_CANCEL    ButtonsType = C.GTK_BUTTONS_CANCEL
	BUTTONS_YES_NO    ButtonsType = C.GTK_BUTTONS_YES_NO
	BUTTONS_OK_CANCEL ButtonsType = C.GTK_BUTTONS_OK_CANCEL
)

fn marshal_buttons_type(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return ButtonsType(c), voidptr
}

type CalendarDisplayOptions int

const (
	CALENDAR_SHOW_HEADING      CalendarDisplayOptions = C.GTK_CALENDAR_SHOW_HEADING
	CALENDAR_SHOW_DAY_NAMES    CalendarDisplayOptions = C.GTK_CALENDAR_SHOW_DAY_NAMES
	CALENDAR_NO_MONTH_CHANGE   CalendarDisplayOptions = C.GTK_CALENDAR_NO_MONTH_CHANGE
	CALENDAR_SHOW_WEEK_NUMBERS CalendarDisplayOptions = C.GTK_CALENDAR_SHOW_WEEK_NUMBERS
	CALENDAR_SHOW_DETAILS      CalendarDisplayOptions = C.GTK_CALENDAR_SHOW_DETAILS
)

fn marshal_calendar_display_options(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return CalendarDisplayOptions(c), voidptr
}

type DestDefaults int

const (
	DEST_DEFAULT_MOTION    DestDefaults = C.GTK_DEST_DEFAULT_MOTION
	DEST_DEFAULT_HIGHLIGHT DestDefaults = C.GTK_DEST_DEFAULT_HIGHLIGHT
	DEST_DEFAULT_DROP      DestDefaults = C.GTK_DEST_DEFAULT_DROP
	DEST_DEFAULT_ALL       DestDefaults = C.GTK_DEST_DEFAULT_ALL
)

fn marshal_dest_defaults(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return DestDefaults(c), voidptr
}

type DialogFlags int

const (
	DIALOG_MODAL               DialogFlags = C.GTK_DIALOG_MODAL
	DIALOG_DESTROY_WITH_PARENT DialogFlags = C.GTK_DIALOG_DESTROY_WITH_PARENT
)

fn marshal_dialog_flags(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return DialogFlags(c), voidptr
}

type EntryIconPosition int

const (
	ENTRY_ICON_PRIMARY   EntryIconPosition = C.GTK_ENTRY_ICON_PRIMARY
	ENTRY_ICON_SECONDARY EntryIconPosition = C.GTK_ENTRY_ICON_SECONDARY
)

fn marshal_entry_icon_position(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return EntryIconPosition(c), voidptr
}

type FileChooserAction int

const (
	FILE_CHOOSER_ACTION_OPEN          FileChooserAction = C.GTK_FILE_CHOOSER_ACTION_OPEN
	FILE_CHOOSER_ACTION_SAVE          FileChooserAction = C.GTK_FILE_CHOOSER_ACTION_SAVE
	FILE_CHOOSER_ACTION_SELECT_FOLDER FileChooserAction = C.GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER
	FILE_CHOOSER_ACTION_CREATE_FOLDER FileChooserAction = C.GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER
)

fn marshal_file_chooser_action(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return FileChooserAction(c), voidptr
}

type IconLookupFlags int

const (
	ICON_LOOKUP_NO_SVG           IconLookupFlags = C.GTK_ICON_LOOKUP_NO_SVG
	ICON_LOOKUP_FORCE_SVG                        = C.GTK_ICON_LOOKUP_FORCE_SVG
	ICON_LOOKUP_USE_BUILTIN                      = C.GTK_ICON_LOOKUP_USE_BUILTIN
	ICON_LOOKUP_GENERIC_FALLBACK                 = C.GTK_ICON_LOOKUP_GENERIC_FALLBACK
	ICON_LOOKUP_FORCE_SIZE                       = C.GTK_ICON_LOOKUP_FORCE_SIZE
)

fn marshal_icon_lookup_flags(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return IconLookupFlags(c), voidptr
}

type IconSize int

const (
	ICON_SIZE_INVALID       IconSize = C.GTK_ICON_SIZE_INVALID
	ICON_SIZE_MENU          IconSize = C.GTK_ICON_SIZE_MENU
	ICON_SIZE_SMALL_TOOLBAR IconSize = C.GTK_ICON_SIZE_SMALL_TOOLBAR
	ICON_SIZE_LARGE_TOOLBAR IconSize = C.GTK_ICON_SIZE_LARGE_TOOLBAR
	ICON_SIZE_BUTTON        IconSize = C.GTK_ICON_SIZE_BUTTON
	ICON_SIZE_DND           IconSize = C.GTK_ICON_SIZE_DND
	ICON_SIZE_DIALOG        IconSize = C.GTK_ICON_SIZE_DIALOG
)

fn marshal_icon_size(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr))
	return IconSize(c), voidptr
}

type ImageType int

const (
	IMAGE_EMPTY     ImageType = C.GTK_IMAGE_EMPTY
	IMAGE_PIXBUF    ImageType = C.GTK_IMAGE_PIXBUF
	IMAGE_STOCK     ImageType = C.GTK_IMAGE_STOCK
	IMAGE_ICON_SET  ImageType = C.GTK_IMAGE_ICON_SET
	IMAGE_ANIMATION ImageType = C.GTK_IMAGE_ANIMATION
	IMAGE_ICON_NAME ImageType = C.GTK_IMAGE_ICON_NAME
	IMAGE_GICON     ImageType = C.GTK_IMAGE_GICON
)

fn marshal_image_type(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return ImageType(c), voidptr
}

type InputHints int

const (
	INPUT_HINT_NONE                InputHints = C.GTK_INPUT_HINT_NONE
	INPUT_HINT_SPELLCHECK          InputHints = C.GTK_INPUT_HINT_SPELLCHECK
	INPUT_HINT_NO_SPELLCHECK       InputHints = C.GTK_INPUT_HINT_NO_SPELLCHECK
	INPUT_HINT_WORD_COMPLETION     InputHints = C.GTK_INPUT_HINT_WORD_COMPLETION
	INPUT_HINT_LOWERCASE           InputHints = C.GTK_INPUT_HINT_LOWERCASE
	INPUT_HINT_UPPERCASE_CHARS     InputHints = C.GTK_INPUT_HINT_UPPERCASE_CHARS
	INPUT_HINT_UPPERCASE_WORDS     InputHints = C.GTK_INPUT_HINT_UPPERCASE_WORDS
	INPUT_HINT_UPPERCASE_SENTENCES InputHints = C.GTK_INPUT_HINT_UPPERCASE_SENTENCES
	INPUT_HINT_INHIBIT_OSK         InputHints = C.GTK_INPUT_HINT_INHIBIT_OSK
)

fn marshal_input_hints(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return InputHints(c), voidptr
}

type InputPurpose int

const (
	INPUT_PURPOSE_FREE_FORM InputPurpose = C.GTK_INPUT_PURPOSE_FREE_FORM
	INPUT_PURPOSE_ALPHA     InputPurpose = C.GTK_INPUT_PURPOSE_ALPHA
	INPUT_PURPOSE_DIGITS    InputPurpose = C.GTK_INPUT_PURPOSE_DIGITS
	INPUT_PURPOSE_NUMBER    InputPurpose = C.GTK_INPUT_PURPOSE_NUMBER
	INPUT_PURPOSE_PHONE     InputPurpose = C.GTK_INPUT_PURPOSE_PHONE
	INPUT_PURPOSE_URL       InputPurpose = C.GTK_INPUT_PURPOSE_URL
	INPUT_PURPOSE_EMAIL     InputPurpose = C.GTK_INPUT_PURPOSE_EMAIL
	INPUT_PURPOSE_NAME      InputPurpose = C.GTK_INPUT_PURPOSE_NAME
	INPUT_PURPOSE_PASSWORD  InputPurpose = C.GTK_INPUT_PURPOSE_PASSWORD
	INPUT_PURPOSE_PIN       InputPurpose = C.GTK_INPUT_PURPOSE_PIN
)

fn marshal_input_purpose(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return InputPurpose(c), voidptr
}

type Justification int

const (
	JUSTIFY_LEFT   Justification = C.GTK_JUSTIFY_LEFT
	JUSTIFY_RIGHT  Justification = C.GTK_JUSTIFY_RIGHT
	JUSTIFY_CENTER Justification = C.GTK_JUSTIFY_CENTER
	JUSTIFY_FILL   Justification = C.GTK_JUSTIFY_FILL
)

fn marshal_justification(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return Justification(c), voidptr
}

type License int

const (
	LICENSE_UNKNOWN      License = C.GTK_LICENSE_UNKNOWN
	LICENSE_CUSTOM       License = C.GTK_LICENSE_CUSTOM
	LICENSE_GPL_2_0      License = C.GTK_LICENSE_GPL_2_0
	LICENSE_GPL_3_0      License = C.GTK_LICENSE_GPL_3_0
	LICENSE_LGPL_2_1     License = C.GTK_LICENSE_LGPL_2_1
	LICENSE_LGPL_3_0     License = C.GTK_LICENSE_LGPL_3_0
	LICENSE_BSD          License = C.GTK_LICENSE_BSD
	LICENSE_MIT_X11      License = C.GTK_LICENSE_MIT_X11
	LICENSE_GTK_ARTISTIC License = C.GTK_LICENSE_ARTISTIC
)

fn marshal_license(p voidptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return License(c), voidptr
}

type MessageType int

const (
	MESSAGE_INFO     MessageType = C.GTK_MESSAGE_INFO
	MESSAGE_WARNING  MessageType = C.GTK_MESSAGE_WARNING
	MESSAGE_QUESTION MessageType = C.GTK_MESSAGE_QUESTION
	MESSAGE_ERROR    MessageType = C.GTK_MESSAGE_ERROR
	MESSAGE_OTHER    MessageType = C.GTK_MESSAGE_OTHER
)

fn marshal_message_type(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return MessageType(c), voidptr
}

type Orientation int

const (
	ORIENTATION_HORIZONTAL Orientation = C.GTK_ORIENTATION_HORIZONTAL
	ORIENTATION_VERTICAL   Orientation = C.GTK_ORIENTATION_VERTICAL
)

fn marshal_orientation(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(c)))
	return Orientation(c), voidptr
}

type PackType int

const (
	PACK_START PackType = C.GTK_PACK_START
	PACK_END   PackType = C.GTK_PACK_END
)

fn marshal_pack_type(p byteptr) (interface{}, voidptr) {
	c := C.g_value_get_enum((*C.value)(voidptr(p)))
	return PackType(c), voidptr
}
