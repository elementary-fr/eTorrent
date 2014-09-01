using ETorrent;

public static void main (string[] args) {
	var session = new Session();
	session.init();
	session.alt_speed_down = 60;
	print ("%lld\n", session.alt_speed_down);
}
