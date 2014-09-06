namespace ETorrent {
	public enum EncryptionType {
		NONE,
		TOLERATED,
		PREFERRED,
		REQUIRED;
		
		internal static EncryptionType from_string (string s) {
			if (strcmp (s, "tolerated") == 0)
				return EncryptionType.TOLERATED;
			if (strcmp (s, "preferred") == 0)
				return EncryptionType.PREFERRED;
			if (strcmp (s, "required") == 0)
				return EncryptionType.REQUIRED;
			return EncryptionType.NONE;
		}
		
		public string to_string() {
			var strv = new string[]{"none", "tolerated", "preferred", "required"};
			return strv[(int)this];
		}
	}
	
	public enum MoveDirection {
		TOP,
		UP,
		DOWN,
		BOTTOM;
		
		public string to_string() {
			var strv = new string[]{"top", "up", "down", "bottom"};
			return strv[(int)this];
		}
	}
	
	public enum Priority {
		LOW = -1,
		NORMAL = 0,
		HIGH = 1
	}
	
	public enum TorrentMode {
		GLOBAL,
		SINGLE,
		UNLIMITED
	}
}
