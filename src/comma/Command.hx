package comma;

class Command{
    
    public function new(){}

    var optionDefinitions = new Array<OptionDefinition>();
    var valueDefinitions = new Array<ValueDefinition>();

    public function getName(){
        return "";
    }

    public function addOptionDefinition(def:OptionDefinition){
        optionDefinitions.push(def);
    }
    public function addValueDefinition(def:ValueDefinition){
        valueDefinitions.push(def);
    }


    public function getDescription(){
        return "";
    }

    function getOptionDefinitionOfName(name:String){
        for (def in optionDefinitions){
            if (def.getName() == name){
                return def;
            }
        }
        return null;
    }

    public final function execute(app:CliApp,values:Array<String>, options:ParsedOptions){
        if (values.length != valueDefinitions.length){
            app.println("Usage:");
            app.println(Style.tab(1,true) + getHelpString());
            return;
        }
        onExecuted(app, values, options);
    }

    function onExecuted(app, value, options){}
    
    public function getHelpString(){
        var valuesDescription = "";
        for (i in 0...valueDefinitions.length){
            if (i == 0){
                valuesDescription += " [";
            }
            valuesDescription += valueDefinitions[i].name;
            if (i == valueDefinitions.length - 1){
                valuesDescription += "]";
            }
        }
        var ret = getName() + valuesDescription +": " + "\t\t\t\t" + getDescription();
        if (optionDefinitions.length != 0){
            ret += Style.tab(3, true) + "Options:\n";
            for (def in optionDefinitions){
                ret += Style.tab(4,true) + def.getHelpString();
            }
        }
        return ret;
    }
}