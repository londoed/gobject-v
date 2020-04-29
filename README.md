# gobject-v
GTK Bindings for the V Programming Language.

# Installation
Installation can be done through the V Package Manager (vpm) with the following command:
```
v install londoed.gobjectv
```
Or via vpkg:
```
vpkg get gobjectv

# or

vpkg get https://github.com/londoed/gobject-v
```
# Sample Usage
Create a GTK Window:

```V
import gobject
import os

fn main() {
    gtk.init(voidptr)
    
    win := gtk.Window{level: gtk.WINDOW_TOPLEVEL}
    win.set_title('Simple Example')
    win.connect("destroy", fn() {
        gtk.main_quit()
    })
    
    lbl := gtk.Label{text: 'GTK V App'}
    
    win.add(lbl)
    win.set_default_size(800, 800)
    win.show_all()
    
    gtk.main()
}
```

Create a simple GTK application:

```V
import gobject
import os

const app_id = 'org.gtk.example'

fn main() {
    application := gtk.ApplicationWindow{app_id: app_id, app_flags: glib.APPLICATION_FLAGS_NONE}
    
    
    application.connect("activate", fn() { on_activate(application) })
    application.run(os.args))
}

fn on_activate(application *gtk.Application) {
    app_window := gtk.ApplicationWindow{app: application}
    
    app_window.set_title('Basic Application')
    app_window.set_default_size(400, 400)
    app_window.show()
}
```

Another simple GTK application:

```V
import gobject
import os

const app_id = 'org.gtk.exampleapp'

fn main() {
    application := gtk.Application{app_id: app_id, app_flags: glib.APPLICATION_FLAGS_NONE}
    
    application.connect('application', fn() {
        app_window := gtk.ApplicationWindow{app: application}
        
        app_window.set_title('Basic Application')
        app_window.set_default_size(400, 400)
        app_window.show()
    })
    
    application.run(os.args)
}
```
