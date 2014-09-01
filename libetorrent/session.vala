namespace ETorrent {
	public class Session {
		string username;
		string password;
		string url;
		string session_id;
		
		Soup.Session soup_session;
		
		public Session (string username = "transmission", string password = "transmission") {
			this.username = username; this.password = password;
			url = @"http://$username:$password@127.0.0.1:9091/transmission/rpc";
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
		
		public void test() {
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
			var node = new Json.Node (Json.NodeType.OBJECT);
			node.set_object (o);
			var gen = new Json.Generator();
			gen.root = node;
			string s = gen.to_data (null);
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, s.data);
			soup_session.send_message (msg);
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
