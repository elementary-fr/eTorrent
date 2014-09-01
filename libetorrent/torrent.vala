namespace ETorrent {
	public class Torrent : Object {
		public Torrent (string path, string save_path) {
			this.path = path;
			this.save_path = save_path;
			added.connect (o => {
				hash = o.get_object_member ("arguments")
						.get_object_member ("torrent-added")
						.get_string_member ("hashString");
				id = o.get_object_member ("arguments")
						.get_object_member ("torrent-added")
						.get_int_member ("hashString");
			});
		}
		
		internal signal void added (Json.Object o);
		
		public int64 id { get; private set; }
		public string hash { get; private set; }
		
		public string path { get; private set; }
		public string save_path { get; private set; }
	}
}
