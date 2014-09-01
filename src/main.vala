using ETorrent;

public static void main (string[] args) {
	var session = new Session();
	session.init();
	session.remove_at (1);
}
