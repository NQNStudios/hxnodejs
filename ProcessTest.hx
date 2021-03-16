import sys.io.Process;

class ProcessTest {
	static function main() {
		// var p = new Process("cmd.exe", ["/C"]);
		// p.stdin.writeString("echo hey");
		var p = new Process("@echo", ["hey"]);
		trace(p.stdout.readString(3));
	}
}
