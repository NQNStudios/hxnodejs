package sys.io;

import haxe.io.Eof;
import haxe.io.Input;
import haxe.io.Output;
import js.lib.Error;
import js.node.ChildProcess;
import js.node.child_process.ChildProcess as ChildProcessObject;
import js.node.stream.Readable;
import js.node.stream.Writable;

@:coreApi
class Process {
	var process:ChildProcessObject;

	public var stderr(default, null):Input;
	public var stdin(default, null):Output;
	public var stdout(default, null):Input;

	public function new(cmd:String, ?args:Array<String>, ?detached:Bool) {
		process = ChildProcess.spawn(cmd, args, {detached: detached});

		stderr = new StreamInput(process.stderr);
		stdin = new StreamOutput(process.stdin);
		stdout = new StreamInput(process.stdout);
	}

	public function close():Void {
		process.disconnect();
	}

	public function kill():Void {
		process.kill();
	}

	public function exitCode(block:Bool = true):Null<Int> {
		if (block == true) {
			throw "node.js does not support blocking for a subprocess's exit code";
		}

		return process.exitCode;
	}

	public function getPid():Int {
		return process.pid;
	}
}

@:allow(sys.io.Process)
class StreamInput extends Input {
	var stream:IReadable;

	function new(stream:IReadable) {
		this.stream = stream;
	}

	override public function readByte():Int {
		var buffer = stream.read(1);
		if (buffer == null)
			throw new Eof();
		return buffer.readInt8();
	}
}

@:allow(sys.io.Process)
class StreamOutput extends Output {
	var stream:IWritable;

	function new(stream:IWritable) {
		this.stream = stream;
	}

	override public function writeByte(c:Int):Void {
		stream.write(c, null, (error:Error) -> {
			throw error;
		});
	}
}
