namespace Transfert {
	namespace Widgets {
		public class HeaderBar : Gtk.HeaderBar {
			construct {
				title = "Transfert";
				close_button = new Gtk.MenuButton();
				close_button.popup = new CloseMenu();
				close_button.image = new Gtk.Image.from_icon_name ("dialog-close", Gtk.IconSize.BUTTON);
				pack_start (close_button);
				pack_start (new Gtk.Separator(Gtk.Orientation.VERTICAL));
			}
			
			public Gtk.MenuButton close_button { get; private set; }
		}
	}
}
