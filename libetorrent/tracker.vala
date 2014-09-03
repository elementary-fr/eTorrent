namespace ETorrent {
	public class Tracker : Object {
		Json.Object object;
		
		internal Tracker.internal (Json.Object object) {
			this.object = object;
		}
		
		public Tracker (string announce) {
			object = new Json.Object();
			this.announce = announce;
		}
		
		public string announce {
			owned get {
				return object.get_string_member ("announce");
			}
			set {
				object.set_string_member ("announce", value);
			}
		}
		
		public int64 id {
			get {
				return object.get_int_member ("id");
			}
		}
		
		public string scrape {
			owned get {
				return object.get_string_member ("scrape");
			}
		}
		
		public int64 tier {
			get {
				return object.get_int_member ("tier");
			}
		}
	}
	
	public struct TrackerPair {
		public int id;
		public string announce;
	}
}
