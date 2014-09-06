namespace Transfert.Widgets {
	public class CloseMenu : Gtk.Menu {
		
		public CloseMenu () {
			var file = new Gtk.MenuItem.with_label ("File");
			var quit = new Gtk.MenuItem.with_label ("Quit");
			add (file);
			add (new Gtk.SeparatorMenuItem());
			add (quit);
			show_all();
		}
	}
}
