/* Copyright 2013 elemntary-os FR
 *
 * This file is part of eTorrent
 *
 * eTorrent is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * eTorrent is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with eTorrent. If not, see http://www.gnu.org/licenses/.
 */

 /* compile file with valac --pkg gtk+-3.0 --pkg granite main.vala */

using Gtk;
using Granite;

namespace eTorrent {

    public class eTorrentApp : Window {

        public eTorrentApp () {

            // Defining Window

            this.title = "eTorrent";
            this.set_border_width (12);
            this.window_position = WindowPosition.CENTER;
            this.destroy.connect (Gtk.main_quit);
            set_default_size (900, 550);


            // Defining HeaderBar

            var header = new Gtk.HeaderBar ();
            header.set_title ("Torrents");
            header.show_close_button = true;
            this.set_titlebar (header);

            var label = new Gtk.Label ("Hello World !");
            
            this.add(label);
            
        }


        // Stuff happens here
        
        public static int main (string[] args) {
            
            Gtk.init (ref args);

            var window = new eTorrentApp ();
            window.show_all ();

            Gtk.main ();
            return 0;
        }
    }
}
