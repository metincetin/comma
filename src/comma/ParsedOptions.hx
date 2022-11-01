package comma;

class ParsedOptions{
    var options = new Map<String, Array<String>>();
    function new(){}
    public static function parse(options:Array<String>){
        var ret = new ParsedOptions();
        var currentOption = "";
        var currentValues = new Array<String>();
        for (option in options){
            if (option.charAt(0) == "-"){
                currentOption = trimDashes(option);
                currentValues = [];
            }else{
                currentValues.push(option);
                ret.options.set(currentOption, currentValues);
            }
        }
        return ret;
    }

    static function trimDashes(str:String){
        while(str.charAt(0) == "-"){
            str = str.substr(1);
        }
        return str;
    }

    public function get(optionName:String, alias:String = ""){
        if (options.exists(optionName)){
            return options.get(optionName);
        }
        if (alias != "" && options.exists(alias)){
            return options.get(alias);
        }
        return new Array<String>();
    }
    public function exists(optionName:String, alias:String){
        return options.exists(optionName) || options.exists(alias);
    }

    public function getFromDefinition(definitions:Array<OptionDefinition>, option:String){
        for (def in definitions){
            if (def.getName() == option || def.getAlias() == option){
                return def;
            }
        }
        return null;
    }
}