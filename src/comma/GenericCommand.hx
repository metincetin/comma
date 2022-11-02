package comma;

import comma.ParsedOptions;
import comma.ParsedOptions;
import comma.ParsedOptions;

class GenericCommand extends Command{
    var f:(CliApp, Array<String>, ParsedOptions)->Void;
    var name = "";
    var description = "";
    
    public function new(name:String, description:String, func:(CliApp, Array<String>, ParsedOptions)->Void){
        super();
        this.name = name;
        this.description = description;
        this.f = func;
    }

    override function getName():String {
        return name;
    }
    override function getDescription():String {
        return description;
    }

    override function onExecuted(app:CliApp, values:Array<String>,  options:ParsedOptions) {
        f(app, values, options);
    }
}