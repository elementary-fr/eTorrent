namespace ETorrent {
	public class Torrent : Object {
		public Torrent (string path, string save_path) {
			this.path = path;
			this.save_path = save_path;
			added_internal.connect (o => {
				hash = o.get_object_member ("arguments")
						.get_object_member ("torrent-added")
						.get_string_member ("hashString");
				id = o.get_object_member ("arguments")
						.get_object_member ("torrent-added")
						.get_int_member ("id");
				added();
			});
		}
		
		internal signal void added_internal (Json.Object o);
		
		public signal void added();
		public signal void removed();
		
		void send_request (string method) {
			var object = new Json.Object();
			object.set_string_member ("method", method);
			var arguments = new Json.Object();
			var array = new Json.Array();
			array.add_int_element (id);
			arguments.set_array_member ("ids", array);
			object.set_object_member ("arguments", arguments);
			Session.send_object (object);
		}
		
		public void add_trackers (Tracker tracker, ...) {
			var array = new Json.Array();
			array.add_string_element (tracker.announce);
			var list = va_list();
			for (Tracker? t = list.arg<Tracker?>(); t != null; t = list.arg<Tracker?>())
				array.add_string_element (t.announce);
			torrent_set ("trackerAdd", array);
		}
		
		public void add_trackers_urls (string announce, ...) {
			var array = new Json.Array();
			array.add_string_element (announce);
			var list = va_list();
			for (string? s = list.arg<string?>(); s != null; s = list.arg<string?>())
				array.add_string_element (s);
			torrent_set ("trackerAdd", array);
		}
		
		public void remove_trackers (Tracker tracker, ...) {
			var array = new Json.Array();
			array.add_string_element (tracker.announce);
			var list = va_list();
			for (Tracker? t = list.arg<Tracker?>(); t != null; t = list.arg<Tracker?>())
				array.add_string_element (t.announce);
			torrent_set ("trackerRemove", array);
		}
		
		public void remove_trackers_urls (string announce, ...) {
			var array = new Json.Array();
			array.add_string_element (announce);
			var list = va_list();
			for (string? s = list.arg<string?>(); s != null; s = list.arg<string?>())
				array.add_string_element (s);
			torrent_set ("trackerRemove", array);
		}
		
		public void replace_tracker (int tracker_id, Tracker tracker) {
			replace_tracker_url (tracker_id, tracker.announce);
		}
		
		public void replace_tracker_pair (TrackerPair pair) {
		 	var jpair = new Json.Array();
			jpair.add_int_element (pair.id);
			jpair.add_string_element (pair.announce);
			var array = new Json.Array();
			array.add_array_element (jpair);
			torrent_set ("trackerReplace", array);
		}
		
		public void replace_tracker_url (int tracker_id, string announce) {
			var pair = new Json.Array();
			pair.add_int_element (tracker_id);
			pair.add_string_element (announce);
			var array = new Json.Array();
			array.add_array_element (pair);
			torrent_set ("trackerReplace", array);
		}
		
		public void start() {
			send_request ("torrent-start");
		}
		
		public void start_now() {
			send_request ("torrent-start-now");
		}
		
		public void stop() {
			send_request ("torrent-stop");
		}
		
		public void verify() {
			send_request ("torrent-verify");
		}
		
		public void reannounce() {
			send_request ("torrent-reannounce");
		}
		
		public FileIterator iterator() {
			return new FileIterator (this);
		}
		
		public int64 id { get; private set; }
		public string hash { get; private set; }
		
		public string path { get; private set; }
		
		string sp;
		
		public string save_path {
			owned get {
				return sp;
			}
			private set {
				sp = value;
			}
		}
		
		public void queue_move (MoveDirection direction) {
			string method = "queue-move-" + direction.to_string();
			var object = new Json.Object();
			var arguments = new Json.Object();
			var ids = new Json.Array();
			ids.add_int_element (id);
			arguments.set_array_member ("ids", ids);
			object.set_object_member ("arguments", arguments);
			object.set_string_member ("method", method);
			Session.send_object (object);
		}
		
		internal void torrent_set (string parameter, Value val) {
			var object = new Json.Object();
			var arguments = new Json.Object();
			var node = new Json.Node.alloc();
			node.set_value (val);
			arguments.set_member (parameter, node);
			object.set_object_member ("arguments", arguments);
			object.set_string_member ("method", "torrent-set");
			Session.send_object (object);
		}
		
		internal Value torrent_get (string parameter) {
			var arguments = new Json.Object();
			var ids = new Json.Array();
			ids.add_int_element (id);
			var fields = new Json.Array();
			fields.add_string_element (parameter);
			arguments.set_array_member ("ids", ids);
			arguments.set_array_member ("fields", fields);
			var object = new Json.Object();
			object.set_object_member ("arguments", arguments);
			object.set_string_member ("method", "torrent-get");
			return Session.receive_object (object)
				.get_object_member ("arguments")
				.get_array_member ("torrents")
				.get_object_element (0).get_member (parameter).get_value();
		}
		
		public int64 activity_date {
			get {
				return (int64)torrent_get ("activityDate");
			}
		}
		
		public int64 added_date {
			get {
				return (int64)torrent_get ("addedDate");
			}
		}
		
		public Priority bandwidth_priority {
			get {
				return (Priority)((int64)torrent_get ("bandwidthPriority"));
			}
			set {
				torrent_set ("bandwidthPriority", (int64)value);
			}
		}
		
		public string comment {
			owned get {
				return (string)torrent_get ("comment");
			}
		}
		
		public int64 corrupt_ever {
			get {
				return (int64)torrent_get ("corruptEver");
			}
		}
		
		public string creator {
			owned get {
				return (string)torrent_get ("creator");
			}
		}
		
		public int64 date_created {
			get {
				return (int64)torrent_get ("dateCreated");
			}
		}
		
		public int64 desired_available {
			get {
				return (int64)torrent_get ("desiredAvailable");
			}
		}
		
		public int64 done_date {
			get {
				return (int64)torrent_get ("doneDate");
			}
		}
		
		public string download_dir {
			owned get {
				return (string)torrent_get ("downloadDir");
			}
		}
		
		public int64 downloaded_ever {
			get {
				return (int64)torrent_get ("downloadedEver");
			}
		}
		
		public int64 download_limit {
			get {
				return (int64)torrent_get ("downloadLimit");
			}
			set {
				torrent_set ("downloadLimit", value);
			}
		}
		
		public bool download_limited {
			get {
				return (bool)torrent_get ("downloadLimited");
			}
			set {
				torrent_set ("downloadLimited", value);
			}
		}
		
		public int64 error {
			get {
				return (int64)torrent_get ("error");
			}
		}
		
		public string error_string {
			owned get {
				return (string)torrent_get ("errorString");
			}
		}
		
		public int64 eta {
			get {
				return (int64)torrent_get ("eta");
			}
		}
		
		public int64 eta_idle {
			get {
				return (int64)torrent_get ("etaIdle");
			}
		}
		
		public TorrentFile[] files {
			owned get {
				var array = (Json.Array)torrent_get ("files");
				var tfiles = new TorrentFile[0];
				for (var i = 0; i < array.get_length(); i++)
					tfiles += new TorrentFile (array.get_object_element (i));
				return tfiles;
			}
		}
		
		public int64 have_unchecked {
			get {
				return (int64)torrent_get ("haveUnchecked");
			}
		}
		
		public int64 have_valid {
			get {
				return (int64)torrent_get ("haveValid");
			}
		}
		
		public bool honor_session_limits {
			get {
				return (bool)torrent_get ("honorsSessionLimits");
			}
		}
		
		public bool is_finished {
			get {
				return (bool)torrent_get ("isFinished");
			}
		}
		
		public bool is_private {
			get {
				return (bool)torrent_get ("isPrivate");
			}
		}
		
		public bool is_stalled {
			get {
				return (bool)torrent_get ("isStalled");
			}
		}
		
		public string location {
			set {
				sp = value;
				torrent_set ("location", value);
			}
		}
		
		public string magnet_link {
			owned get {
				return (string)torrent_get ("magnetLink");
			}
		}
		
		public int64 manual_announce_time {
			get {
				return (int64)torrent_get ("manualAnnounceTime");
			}
		}
		
		public int64 max_connected_peers {
			get {
				return (int64)torrent_get ("maxConnectedPeers");
			}
		}
		
		public double metadata_percent_complete {
			get {
				return (double)torrent_get ("metadataPercentComplete");
			}
		}
		
		public string name {
			owned get {
				return (string)torrent_get ("name");
			}
		}
		
		public int64 peer_limit {
			get {
				return (int64)torrent_get ("peer-limit");
			}
			set {
				torrent_set ("peer-limit", value);
			}
		}
		
		public Peer[] peers {
			owned get {
				var array = (Json.Array)torrent_get ("peers");
				var table = new Peer[0];
				for (var i = 0; i < array.get_length(); i++)
					table += new Peer (array.get_object_element (0));
				return table;
			}
		}
		
		public int64 peers_connected {
			get {
				return (int64)torrent_get ("peersConnected");
			}
		}
		
		public int64 peers_getting_from_us {
			get {
				return (int64)torrent_get ("peersGettingFromUs");
			}
		}
		
		public int64 peers_sending_to_us {
			get {
				return (int64)torrent_get ("peersSendingToUs");
			}
		}
		
		public double percent_done {
			get {
				return (double)torrent_get ("percentDone");
			}
		}
		
		public int64 queue_position {
			get {
				return (int64)torrent_get ("queuePosition");
			}
			set {
				torrent_set ("queuePosition", value);
			}
		}
		
		public int64 rate_download {
			get {
				return (int64)torrent_get ("rateDownload");
			}
		}
		
		public double recheck_progress {
			get {
				return (double)torrent_get ("recheckProgress");
			}
		}
		
		public int64 seconds_downloading {
			get {
				return (int64)torrent_get ("secondsDownloading");
			}
		}
		
		public int64 seconds_seeding {
			get {
				return (int64)torrent_get ("secondsSeeding");
			}
		}
		
		public int64 rate_upload {
			get {
				return (int64)torrent_get ("rateUpload");
			}
		}
		
		public string realname {
			owned get {
				return Uri.unescape_string (name).replace ("+", " ");
			}
		}
		
		public int64 seed_idle_limit {
			get {
				return (int64)torrent_get ("seedIdleLimit");
			}
			set {
				torrent_set ("seedIdleLimit", value);
			}
		}
		
		public TorrentMode seed_idle_mode {
			get {
				return (TorrentMode)((int64)torrent_get ("seedIdleMode"));
			}
			set {
				torrent_set ("seedIdleMode", (int64)value);
			}
		}
		
		public double seed_ratio_limit {
			get {
				return (double)torrent_get ("seedRatioLimit");
			}
			set {
				torrent_set ("seedRatioLimit", value);
			}
		}
		
		public TorrentMode seed_ratio_mode {
			get {
				return (TorrentMode)((int64)torrent_get ("seedRatioMode"));
			}
			set {
				torrent_set ("seedRatioMode", (int64)value);
			}
		}
		
		public int64 size_when_done {
			get {
				return (int64)torrent_get ("sizeWhenDone");
			}
		}
		
		public int64 start_date {
			get {
				return (int64)torrent_get ("startDate");
			}
		}
		
		public int64 status {
			get {
				return (int64)torrent_get ("status");
			}
		}
		
		public Tracker[] trackers {
			owned get {
				var array = new Tracker[0];
				var jarray = (Json.Array)torrent_get ("trackers");
				for (var i = 0; i < jarray.get_length(); i++)
					array += new Tracker.internal (jarray.get_object_element (i));
				return array;
			}
		}
		
		public int64 total_size {
			get {
				return (int64)torrent_get ("totalSize");
			}
		}
		
		public int64 uploaded_ever {
			get {
				return (int64)torrent_get ("uploadedEver");
			}
		}
		
		public int64 upload_limit {
			get {
				return (int64)torrent_get ("uploadLimit");
			}
			set {
				torrent_set ("uploadLimit", value);
			}
		}
		
		public bool upload_limited {
			get {
				return (bool)torrent_get ("uploadLimited");
			}
			set {
				torrent_set ("uploadLimited", value);
			}
		}
		
		public double upload_ratio {
			get {
				return (double)torrent_get ("uploadRatio");
			}
		}
		
		public string[] webseeds {
			owned get {
				var jarray = (Json.Array)torrent_get ("webseeds");
				var strv = new string[0];
				for (var u = 0; u < jarray.get_length(); u++)
					strv += jarray.get_string_element (u);
				return strv;
			}
		}
		
		public int64 webseeds_sending_to_us {
			get {
				return (int64)torrent_get ("webseedsSendingToUs");
			}
		}
	}
	
	public class FileIterator {
		TorrentFile[] files;
		int index;
		
		internal FileIterator (Torrent t) {
			files = t.files;
			index = -1;
		}
		
		public TorrentFile? next_value() {
			index++;
			if (index < files.length)
				return files[index];
			else
				return null;
		}
	}
}
