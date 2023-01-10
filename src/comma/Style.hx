package comma;

class Style{
    static var reset = "\u001b[0m";
    var codes = new Array<String>();
    var message = "";

    function new(message:String){
        this.message = message;
    }

    public static function space(width:Int){
        var ret = "";
        for (i in 0...width){
            ret += " ";
        }
        return ret;
    }
    public static function tab(number:Int, withSpaces:Bool = false){
        var ret = "";
        for (i in 0...number){
            if (withSpaces){
                ret += space(4);
            }else{
                ret += "\t";
            }
        }
        return ret;
    }

    public static function color(message:String, textColor:TextColor){
        return textColor + message + reset;
    }
    public static function background(message:String, backgroundColor:BackgroundColor){
        return backgroundColor + message + reset;
    }
    public static function textStyle(message:String, textStyle:TextStyle){
        return textStyle + message + reset;
    }

    public static function compose(message:String){
        return new Style(message);
    }

    public function setTextColor(color:TextColor){
        codes.push(cast color);
        return this;
    }
    public function setBackgroundColor(color:BackgroundColor){
        codes.push(cast color);
        return this;
    }
    public function setTextStyle(style:TextStyle){
        codes.push(cast style);
        return this;
    }
    public function build(){
        var ret = "";

        for(c in codes){
            ret += c;
        }

        ret += message + reset;

        return ret;
    }
}

@:enum
abstract TextColor(String){
    var Black = "\u001b[30m";
    var Red = "\u001b[31m";
    var Green = "\u001b[32m";
    var Yellow = "\u001b[33m";
    var Blue = "\u001b[34m";
    var Magenta = "\u001b[35m";
    var Cyan = "\u001b[36m";
    var White = "\u001b[37m";
    var Reset = "\u001b[0m";
    var BrightBlack = "\u001b[30;1m";
    var BrightRed = "\u001b[31;1m";
    var BrightGreen = "\u001b[32;1m";
    var BrightYellow = "\u001b[33;1m";
    var BrightBlue = "\u001b[34;1m";
    var BrightMagenta = "\u001b[35;1m";
    var BrightCyan = "\u001b[36;1m";
    var BrightWhite = "\u001b[37;1m";
}

@:enum
abstract BackgroundColor(String){
    
    var Black = "\u001b[40m";
    var Red = "\u001b[41m";
    var Green = "\u001b[42m";
    var Yellow = "\u001b[43m";
    var Blue = "\u001b[44m";
    var Magenta = "\u001b[45m";
    var Cyan = "\u001b[46m";
    var White = "\u001b[47m    ";
    var BrightBlack = "\u001b[40;1m";
    var BrightRed = "\u001b[41;1m";
    var BrightGreen = "\u001b[42;1m";
    var BrightYellow = "\u001b[43;1m";
    var BrightBlue = "\u001b[44;1m";
    var BrightMagenta = "\u001b[45;1m";
    var BrightCyan = "\u001b[46;1m";
    var BrightWhite = "\u001b[47;1m";
}

@:enum
abstract TextStyle(String){
    var Bold = "\u001b[1m";
    var Underline = "\u001b[4m";
    var Reversed = "\u001b[7m";
}