import sys.io.Process;

class ProcessTest {
	static function main() {
		var p = new Process("cmd.exe", ["/C", "exit", "/b", "1"], true);
		trace(p.getPid());
		trace(p.exitCode(false));

		// p.stdin.writeString("@echo hey\r\n");
		// trace(p.stdout.readString(3));

		var p = new Process("python", ["--version"], true);
		trace(p.exitCode(false));

		// var p = new Process("@echo", ["hey"]);
		// Sys.sleep(1);
		// trace(p.stdout.readString(3));
		Sys.sleep(10);

		// var p = new Process("haxelib", ["run", "kiss"]);
		// Sys.sleep(3);
		// trace(p.stdout.readString(3));
		trace("main done");
	}
}
