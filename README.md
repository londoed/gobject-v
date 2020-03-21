# gobject-v
GTK Bindings for the V Programming Language.

# Sample Usage
Create a GTK Window:

```Vlang
import gtk
import os

fn main() {
    gtk.init(voidptr)
    
    win, err := gtk.Window.new(gtk.WINDOW_TOPLEVEL)
    
    if !isnil(err) {
        panic('[!] ERROR: Unable to create window: $err')
    }
    
    win.set_title('Simple Example')
    win.connect("destroy", fn() {
        gtk.main_quit()
    })
    
    l, err := gtk.Label.new('GTK V App')
    
    if !isnil(err) {
        panic('[!] ERROR: Unable to create label: $err')
    }
    
    win.add(l)
    win.set_default_size(800, 800)
    win.show_all()
    
    gtk.main()
}
```

Create a simple GTK application:

```Vlang
import gtk
import glib
import os

const app_id = 'org.gtk.example'

fn main() {
    application, err := gtk.ApplicationWindow.new(app_id, glib.APPLICATION_FLAGS_NONE)
    
    if !isnil(err) {
        panic('[!] ERROR: Could not create application: $err')
    }
    
    application.connect("activate", fn() { on_activate(application) })
    os.exit(application.run(os.args))
}

fn on_activate(application *gtk.Application {
    app_window, err := gtk.ApplicationWindow(application)
    
    if !isnil(err) {
        panic([!] ERROR: Could not create application window: $err)
    }
    
    app_window.set_title('Basic Application')
    app_window.set_default_size(400, 400)
    app_window.show()
}
```

Another simple GTK application:

```Vlang
import gtk
import glib
import os

const app_id = 'org.gtk.exampleapp'

fn main() {
    application, err := gtk.Application.new(app_id, glib.APPLICATION_FLAGS_NONE)
    
    if !isnil(err) {
        panic('[!] ERROR: Could not create application: $err')
    }
    
    application.connect('application', fn() {
        app_window, err := gtk.ApplicationWindow.new(application)
        
        if !isnil(err) {
            panic('[!] ERROR: Could not create application window: $err')
        }
        
        app_window.set_title('Basic Application')
        app_window.set_default_size(400, 400)
        app_window.show()
    })
    
    application.run(os.args)
}
```
