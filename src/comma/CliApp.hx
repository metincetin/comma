package comma;

import haxe.io.Eof;

class CliApp {
	var commands = new Array<Command>();
	var appName = "";
	var version = "";
	var defaultCommand:Command;
	var executeDefaultCommandOnly = false;

	public function new(appName:String, version:String, executeDefaultCommandOnly = false) {
		this.appName = appName;
		this.version = version;
		this.executeDefaultCommandOnly = executeDefaultCommandOnly;
	}

	public function getDefaultCommand() {
		if (defaultCommand == null) {
			if (commands.length == 0) {
				throw("No default command is set and no command registered");
			}
			return commands[0];
		}
		return defaultCommand;
	}

	function getCommandOfName(name:String) {
		for (c in commands) {
			if (c.getName() == name) {
				return c;
			}
		}
		return null;
	}

	function hasCommandOfName(name:String) {
		for (c in commands) {
			if (c.getName() == name) {
				return true;
			}
		}
		return false;
	}

	public function setDefaultCommand(command:Command) {
		defaultCommand = command;
	}

	public function addCommand(command:Command) {
		commands.push(command);
	}

	public function removeCommand(command:Command) {
		commands.remove(command);
	}

	public function start() {
		var options = ParsedOptions.parse(Sys.args());
		var values = parseValues(Sys.args());
		if (executeDefaultCommandOnly) {
			getDefaultCommand().execute(this, values, options);
			return;
		}
		if (Sys.args().length == 0) {
			printHelp();
			return;
		}

		var cm = Sys.args()[0];
		if (cm.charAt(0) == "-") {
			printHelp();
			return;
		}
		if (hasCommandOfName(cm)) {
			getCommandOfName(cm).execute(this,values, options);
		} else {
			println("Command not found: " + cm);
		}
	}

	function parseValues(args:Array<String>){
		var ret = new Array<String>();
		for(i in 1...args.length - 1){
			var val = args[i];
			if (val.charAt(0) == "-"){
				return ret;
			}
			ret.push(val);
		}
		return ret;
	}

	public function println(message:Dynamic) {
		Sys.println(message);
	}

	public function print(message:Dynamic) {
		Sys.print(message);
	}

	public function prompt(message:String = "") {
		print(message + ": ");
		return Sys.stdin().readLine();
	}

	public function printHelp() {
		println(appName + " help");
		if (executeDefaultCommandOnly){
			getDefaultCommand().getHelpString();
			return;
		}
		if (commands.length > 0) {
			println(Style.tab(1, true) + "Commands:");

			for (c in commands) {
				println(Style.tab(2, true) + c.getHelpString());
			}
		}
	}
}
