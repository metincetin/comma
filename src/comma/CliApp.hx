package comma;

import comma.ValueDefinition;
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
		var args = Sys.args();
		var cwd = args.pop();
		var options = ParsedOptions.parse(args);
		var values = parseValues(args);
		
		Sys.setCwd(cwd);
		
		if (executeDefaultCommandOnly) {
			getDefaultCommand().execute(this, values, options);
			return;
		}
		if (args.length == 0) {
			printHelp();
			return;
		}

		var cm = args[0];
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
		for(i in 1...args.length){
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
			println(
				Table.create()
					.addRow()
					.addColumn(defaultCommand.getName()+":")
					.addEmptyColumn(1)
					.addColumn(defaultCommand.getDescription()).toString()
			);
			return;
		}
		if (commands.length > 0) {
			println(Style.tab(1, true) + "Commands:");
			
			var table = Table.create();
			for (c in commands) {
				if (c.getName() == "") continue;
				table.addRow();

				var commandNameColumn = "";

				if (c != defaultCommand){
					commandNameColumn = c.getName();
				}


				var valueDefinitions = c.getValueDefinitions();
				if (valueDefinitions.length > 0){
					for(i in 0...valueDefinitions.length){
						var valDef = c.getValueDefinitions()[i];
						if (i == 0){
							commandNameColumn += " [";
						}
						commandNameColumn += valDef.name;

						if (i < valueDefinitions.length - 1){
							commandNameColumn +=", ";
						}

						if (i == valueDefinitions.length - 1){
							commandNameColumn += "]";
						}
					}
				}

				table.addColumn(commandNameColumn);

				

				table.addEmptyColumn(16);
				table.addColumn(c.getDescription());
				if (c.getOptionDefinitions().length > 0){
					table.addRow();
					for(optDef in c.getOptionDefinitions()){
						var optDefNameColumn = "-" + optDef.getName();
						if (optDef.getAlias() != ""){
							optDefNameColumn += " --"+optDef.getAlias();
						}
						table.addColumn(Style.tab(1, true) + optDefNameColumn);
						table.addEmptyColumn(16);
						table.addColumn(optDef.getDescription());
					}
				}	
				//println(Style.tab(2, true) + c.getHelpString());
			}
			println(table.toString(2));
		}
	}
}
