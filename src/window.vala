using Transfert.Widgets;

namespace Transfert {
	public class Window : Gtk.Window {
		construct {
			decorated = false;
			var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
			var bar = new HeaderBar();
			box.pack_start (bar, false, false);
			add (box);
		}
	}
}
