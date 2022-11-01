package comma;

class GenericCommand extends Command{
    var f:(CliApp, Array<String>)->Void;
    var name = "";
    var description = "";
    
    public function new(name:String, description:String, func:(CliApp, Array<String>)->Void){
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

    override function execute(app:CliApp, values:Array<String>,  options:Array<String>) {
        f(app, options);
    }
}