namespace ETorrent {
	public class Session {
		string username;
		string password;
		string ip;
		uint16 port;
		string url;
		string session_id;
		
		Soup.Session soup_session;
		
		~Session() {
			string s = """{
				"method" : "session-close"
			}""";
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, s.data);
			soup_session.send_message (msg);
		}
		
		public Session (string username = "transmission", string password = "transmission", string ip = "127.0.0.1", uint16 port = 9091) {
			this.username = username; this.password = password;
			this.ip = ip; this.port = port;
			url = @"http://$username:$password@$ip:$port/transmission/rpc";
			soup_session = new Soup.Session();
		}
		
		public void init() throws GLib.Error {
			var msg = new Soup.Message ("GET", url);
			soup_session.send_message (msg);
			if (msg.status_code == 401)
				throw new SessionError.UNAUTHORIZED ("unauthorized user: invalid username and/or password\n");
			conflict = msg.status_code == 409;
			string response = (string)msg.response_body.data;
			session_id = response.split ("<code>")[1].split ("</code>")[0].split (": ")[1];
			is_init = true;
		}
		
		Json.Node session_get () throws GLib.Error {
			string s = """{
				"method" : "session-get"
			}""";
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, s.data);
			soup_session.send_message (msg);
			var parser = new Json.Parser();
			parser.load_from_data ((string)msg.response_body.data);
			return parser.get_root();
		}
		
		void session_set (Json.Object object) throws GLib.Error {
			var o = new Json.Object();
			o.set_string_member ("method", "session-set");
			o.set_object_member ("arguments", object);
			send_object (o);
		}
		
		public void add (Torrent torrent) throws GLib.Error {
			var o = new Json.Object();
			var object = new Json.Object();
			object.set_string_member ("download-dir", torrent.save_path);
			object.set_string_member ("filename", torrent.path);
			o.set_string_member ("method", "torrent-add");
			o.set_object_member ("arguments", object);
			torrent.added(receive_object (o));
		}
		
		public void remove (Torrent torrent, bool delete_files = false) throws GLib.Error {
			remove_at (torrent.id, delete_files);
		}
		
		public void remove_at (int64 index, bool delete_files = false) throws GLib.Error {
			var arguments = new Json.Object();
			var array = new Json.Array();
			array.add_int_element (index);
			arguments.set_array_member ("ids", array);
			arguments.set_boolean_member ("delete-local-data", delete_files);
			var o = new Json.Object();
			o.set_string_member ("method", "torrent-remove");
			o.set_object_member ("arguments", arguments);
			send_object (o);
		}
		
		void send_object (Json.Object object) throws GLib.Error {
			var node = new Json.Node (Json.NodeType.OBJECT);
			node.set_object (object);
			var gen = new Json.Generator();
			gen.root = node;
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, gen.to_data (null).data);
			soup_session.send_message (msg);
		}
		
		Json.Object receive_object (Json.Object object) throws GLib.Error {
			var node = new Json.Node (Json.NodeType.OBJECT);
			node.set_object (object);
			var gen = new Json.Generator();
			gen.root = node;
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, gen.to_data (null).data);
			soup_session.send_message (msg);
			var parser = new Json.Parser();
			print ("%s\n", (string)msg.response_body.data);
			parser.load_from_data ((string)msg.response_body.data);
			return parser.get_root().get_object();
		}
		
		public int64 alt_speed_down {
			get {
				return session_get().get_object().get_object_member ("arguments").get_int_member ("alt-speed-down");
			}
			set {
				var o = new Json.Object();
				o.set_int_member ("alt-speed-down", value);
				session_set (o);
			}
		}
		
		public int64 alt_speed_up {
			get {
				return session_get().get_object().get_object_member ("arguments").get_int_member ("alt-speed-up");
			}
			set {
				var o = new Json.Object();
				o.set_int_member ("alt-speed-up", value);
				session_set (o);
			}
		}
		
		public bool conflict { get; set; }
		
		public bool is_init { get; private set; }
	}
}
