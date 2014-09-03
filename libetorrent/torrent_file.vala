namespace ETorrent {
	public class TorrentFile : Object {
		Json.Object object;
		
		internal TorrentFile (Json.Object object) {
			this.object = object;
		}
		
		public int64 bytes_completed {
			get {
				return object.get_int_member ("bytesCompleted");
			}
		}
		
		public int64 length {
			get {
				return object.get_int_member ("lengt");
			}
		}
		
		public double download_percent_complete {
			get {
				return ((double)bytes_completed)/((double)length);
			}
		}
		
		public string name {
			owned get {
				return object.get_string_member ("name");
			}
		}
		
		public Priority priority {
			get {
				return (Priority)object.get_int_member ("priority");
			}
		}
	}
}
