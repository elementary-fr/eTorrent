namespace ETorrent {
	public class Peer : Object {
		Json.Object object;
		
		internal Peer (Json.Object object) {
			this.object = object;
		}
		
		public string address {
			owned get {
				return object.get_string_member ("address");
			}
		}
		
		public string client_name {
			owned get {
				return object.get_string_member ("clientName");
			}
		}
		
		public bool client_is_choked {
			get {
				return object.get_boolean_member ("clientIsChoked");
			}
		}
		
		public bool client_is_interested {
			get {
				return object.get_boolean_member ("clientIsInterested");
			}
		}
		
		public string flag {
			owned get {
				return object.get_string_member ("flagStr");
			}
		}
		
		public bool is_downloading_from {
			get {
				return object.get_boolean_member ("isDownloadingFrom");
			}
		}
		
		public bool is_encrypted {
			get {
				return object.get_boolean_member ("isEncrypted");
			}
		}
		
		public bool is_incoming {
			get {
				return object.get_boolean_member ("isIncoming");
			}
		}
		
		public bool is_uploading_to {
			get {
				return object.get_boolean_member ("isUploadingTo");
			}
		}
		
		public bool is_utp {
			get {
				return object.get_boolean_member ("isUTP");
			}
		}
		
		public bool peer_is_choked {
			get {
				return object.get_boolean_member ("peerIsChoked");
			}
		}
		
		public bool peer_is_interested {
			get {
				return object.get_boolean_member ("peerIsInterested");
			}
		}
		
		public int64 port {
			get {
				return object.get_int_member ("port");
			}
		}
		
		public double progress {
			get {
				return object.get_double_member ("progress");
			}
		}
		
		public int64 rate_to_client {
			get {
				return object.get_int_member ("rateToClient");
			}
		}
		
		public int64 rate_to_peer {
			get {
				return object.get_int_member ("rateToPeer");
			}
		}
	}
}
