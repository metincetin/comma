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

    public function getOptionDefinitions(){
        return optionDefinitions;
    }
    public function getValueDefinitions(){
        return valueDefinitions;
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
        trace(values);
        if (values.length != valueDefinitions.length){
            app.println("Usage:");
            var help = Table.create()
                .addRow()
                .addColumn(getName())
                .addColumn(getDescription()).toString();
            app.println(help);
            return;
        }
        onExecuted(app, values, options);
    }

    function onExecuted(app, value, options){}
}