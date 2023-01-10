package comma;

import haxe.Json;
import haxe.display.Display.Define;

class Table {
	private var rows:Array<Array<String>> = new Array<Array<String>>();


	private function new() {}

	public static function create() {
		return new Table();
	}


	private function getWideColumnWidth() {
		var widest = [0, 0];
		for (y in 0...rows.length) {
			var column = rows[y];
			for (x in 0...column.length) {
				var cell = rows[y][x];
				if (cell.length > rows[widest[0]][widest[1]].length) {
					widest[0] = y;
					widest[1] = x;
				}
			}
		}
		return rows[widest[0]][widest[1]].length;
	}

	private function getWidthForColumn(columnIndex:Int) {
		var widest = 0;
		for (y in 0...rows.length) {
            if (columnIndex >= rows[y].length) continue;
            var cell = rows[y][columnIndex];
			if (cell.length > widest) {
				widest = cell.length;
			}
		}

		return widest;
	}

	function getCurrentRow() {
		return rows[rows.length - 1];
	}

	public function addRow() {
		rows.push([]);
		return this;
	}

	public function addColumn(val:String) {
		var row = getCurrentRow().push(val);
		return this;
	}

	public function addEmptyColumn(size:Int) {
		var s = "";
		for (i in 0...size) {
			s += " ";
		}
		return addColumn(s);
	}

	public function toString(indention = 0):String {
		var ret = "";
     
		for (y in 0...rows.length) {
			for (i in 0...indention) {
				ret += "    ";
			}
			for (x in 0...rows[y].length) {
				var columnWidth = getWidthForColumn(x);
				var cell = rows[y][x];
				var rem = columnWidth - cell.length;
				ret += cell;
				for (i in 0...rem) {
					ret += " ";
				}
			}
			ret += "\n";
		}
		return ret;
	}
}
