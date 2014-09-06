namespace ETorrent {
	public class Session : Object {
		string username;
		string password;
		string ip;
		uint16 port;
		internal static string url;
		internal static string session_id;
		
		internal static Soup.Session soup_session;
		
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
		
		Value session_get (string parameter) throws GLib.Error {
			string s = """{
				"method" : "session-get"
			}""";
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, s.data);
			soup_session.send_message (msg);
			var parser = new Json.Parser();
			parser.load_from_data ((string)msg.response_body.data);
			return parser.get_root().get_object().get_object_member ("arguments").get_member (parameter).get_value();
		}
		
		void session_set (string parameter, Value val) throws GLib.Error {
			var o = new Json.Object();
			var arguments = new Json.Object();
			var node = new Json.Node.alloc();
			node.set_value (val);
			arguments.set_member (parameter, node);
			o.set_string_member ("method", "session-set");
			o.set_object_member ("arguments", arguments);
			send_object (o);
		}
		
		public void add (Torrent torrent) throws GLib.Error {
			var o = new Json.Object();
			var object = new Json.Object();
			object.set_string_member ("download-dir", torrent.save_path);
			object.set_string_member ("filename", torrent.path);
			o.set_string_member ("method", "torrent-add");
			o.set_object_member ("arguments", object);
			torrent.added_internal(receive_object (o));
		}
		
		public void remove (Torrent torrent, bool delete_files = false) throws GLib.Error {
			remove_at (torrent.id, delete_files);
			torrent.removed();
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
		
		internal static void send_object (Json.Object object) throws GLib.Error {
			var node = new Json.Node (Json.NodeType.OBJECT);
			node.set_object (object);
			var gen = new Json.Generator();
			gen.root = node;
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			print ("send: %s\n", gen.to_data (null));
			msg.request_body.append (Soup.MemoryUse.COPY, gen.to_data (null).data);
			soup_session.send_message (msg);
		}
		
		internal static Json.Object receive_object (Json.Object sender) throws GLib.Error {
			var node = new Json.Node (Json.NodeType.OBJECT);
			node.set_object (sender);
			var gen = new Json.Generator();
			gen.root = node;
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, gen.to_data (null).data);
			soup_session.send_message (msg);
			var parser = new Json.Parser();
			print ("%s\n\n", (string)msg.response_body.data);
			parser.load_from_data ((string)msg.response_body.data);
			return parser.get_root().get_object();
		}
		
		public int64 alt_speed_down {
			get {
				return (int64)session_get ("alt-speed-down");
			}
			set {
				session_set ("alt-speed-down", value);
			}
		}
		
		public bool alt_speed_enabled {
			get {
				return (bool)session_get ("alt-speed-enabled");
			}
			set {
				session_set ("alt-speed-enabled", value);
			}
		}
		
		public int64 alt_speed_up {
			get {
				return (int64)session_get ("alt-speed-up");
			}
			set {
				session_set ("alt-speed-up", value);
			}
		}
		
		public string config_dir {
			owned get {
				return (string)session_get ("config-dir");
			}
		}
		
		public bool conflict { get; private set; }
		
		public string download_dir {
			owned get {
				return (string)session_get ("download-dir");
			}
			set {
				session_set ("download-dir", value);
			}
		}
		
		public int64 download_queue_size {
			get {
				return (int64)session_get ("download-queue-size");
			}
			set {
				session_set ("download-queue-size", value);
			}
		}
		
		public bool download_queue_enabled {
			get {
				return (bool)session_get ("download-queue-enabled");
			}
			set {
				session_set ("download-queue-enabled", value);
			}
		}
		
		public bool dht_enabled {
			get {
				return (bool)session_get ("dht-enabled");
			}
			set {
				session_set ("dht-enabled", value);
			}
		}
		
		public EncryptionType encryption {
			get {
				return EncryptionType.from_string ((string)session_get ("encryption"));
			}
			set {
				session_set ("encryption", value.to_string());
			}
		}
		
		public string incomplete_dir {
			owned get {
				return (string)session_get ("incomplete-dir");
			}
			set {
				session_set ("incomplete-dir", value);
			}
		}
		
		public bool incomplete_dir_enabled {
			get {
				return (bool)session_get ("incomplete-dir-enabled");
			}
			set {
				session_set ("incomplete-dir-enabled", value);
			}
		}
		
		public bool is_init { get; private set; }
		
		public bool lpd_enabled {
			get { return (bool)session_get ("lpd-enabled"); }
			set { session_set ("lpd-enabled", value); }
		}
		
		public int64 peer_limit_global {
			get { return (int64)session_get ("peer-limit-global"); }
			set { session_set ("peer-limit-global", value); }
		}
		
		public int64 peer_limit_per_torrent {
			get { return (int64)session_get ("peer-limit-per-torrent"); }
			set { session_set ("peer-limit-per-torrent", value); }
		}
		
		public int64 peer_port {
			get { return (int64)session_get ("peer-port"); }
			set { session_set ("peer-port", value); }
		}
		
		public bool peer_port_random_on_start {
			get { return (bool)session_get ("peer-port-random-on-start"); }
			set { session_set ("peer-port-random-on-start", value); }
		}
		
		public bool pex_enabled {
			get { return (bool)session_get ("pex-enabled"); }
			set { session_set ("pex-enabled", value); }
		}
		
		public bool port_forwarding_enabled {
			get { return (bool)session_get ("port-forwarding-enabled"); }
			set { session_set ("port-forwarding-enabled", value); }
		}
		
		public bool rename_partial_files {
			get { return (bool)session_get ("rename-partial-files"); }
			set { session_set ("rename-partial-files", value); }
		}
		
		public int64 rpc_version {
			get { return (int64)session_get ("rpc-version"); }
		}
		
		public int64 rpc_version_minimum {
			get { return (int64)session_get ("rpc-version-minimum"); }
		}
		
		public double seed_ratio_limit {
			get { return (double)session_get ("seedRatioLimit"); }
			set { session_set ("seedRatioLimit", value); }
		}
		
		public bool seed_ratio_limited {
			get { return (bool)session_get ("seedRatioLimited"); }
			set { session_set ("seedRatioLimited", value); }
		}
		
		public int64 seed_queue_size {
			get { return (int64)session_get ("seed-queue-size"); } 
			set { session_set ("seed-queue-size", value); }
		}
		
		public bool seed_queue_enabled {
			get { return (bool)session_get ("seed-queue-enabled"); } 
			set { session_set ("seed-queue-enabled", value); }
		}
		
		public int64 speed_limit_down {
			get { return (int64)session_get ("speed-limit-down"); }
			set { session_set ("speed-limit-down", value); }
		}
		
		public bool speed_limit_down_enabled {
			get { return (bool)session_get ("speed-limit-down-enabled"); }
			set { session_set ("speed-limit-down-enabled", value); }
		}
		
		public int64 speed_limit_up {
			get { return (int64)session_get ("speed-limit-up"); }
			set { session_set ("speed-limit-up", value); }
		}
		
		public bool speed_limit_up_enabled {
			get { return (bool)session_get ("speed-limit-up-enabled"); }
			set { session_set ("speed-limit-up-enabled", value); }
		}
		
		public bool start_added_torrents {
			get { return (bool)session_get ("start-added-torrents"); }
			set { session_set ("start-added-torrents", value); }
		}
		
		public bool trash_original_torrent_files {
			get { return (bool)session_get ("trash-original-torrent-files"); }
			set { session_set ("trash-original-torrent-files", value); }
		}
		
		public bool utp_enabled {
			get { return (bool)session_get ("utp-enabled"); }
			set { session_set ("utp-enabled", value); }
		}
		
		public string version {
			owned get { return (string)session_get ("version"); }
		}
		
		Value get_stat (string parameter) {
			string s = """{
				"method" : "session-stats"
			}""";
			var msg = new Soup.Message ("POST", url);
			msg.request_headers.append ("X-Transmission-Session-Id", session_id);
			msg.request_body.append (Soup.MemoryUse.COPY, s.data);
			soup_session.send_message (msg);
			var parser = new Json.Parser();
			parser.load_from_data ((string)msg.response_body.data);
			return parser.get_root().get_object().get_object_member ("arguments").get_member (parameter).get_value();
		}
		
		public int64 active_torrent_count {
			get {
				return (int64)get_stat ("activeTorrentCount");
			}
		}
		
		public int64 download_speed {
			get {
				return (int64)get_stat ("downloadSpeed");
			}
		}
		
		public int64 paused_torrent_count {
			get {
				return (int64)get_stat ("pausedTorrentCount");
			}
		}
		
		public int64 torrent_count {
			get {
				return (int64)get_stat ("torrentCount");
			}
		}
		
		public int64 upload_speed {
			get {
				return (int64)get_stat ("uploadSpeed");
			}
		}
	}
}
