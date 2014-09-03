using ETorrent;

public static void main (string[] args) {
	var session = new Session();
	session.init();
	session.peer_limit_per_torrent = 2;
}
