# gobject-v
GTK Bindings for the V Programming Language.

# Sample Usage
Create a GTK Application:
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
