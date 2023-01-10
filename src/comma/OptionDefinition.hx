package comma;

class OptionDefinition{
    var name = "";
    var alias = "";
    var description = "";
    public function new(name:String, alias:String="",description:String = ""){
        this.name = name;
        this.alias = alias;
        this.description = description;
    }

    public function getName(){
        return name;
    }
    public function getAlias(){
        return alias;
    }
    public function getDescription(){
        return description;
    }
}