# comma

Haxe library for creating command line applications

## About

Haxe library to make command line applications with ease. Primarily created to power up dreamengine-cli project.

## Getting Started

Install it with `haxelib install comma`

then you can use it with `import comma.*`;

## Usage

Code example below will create a command line application without any commands.

```haxe
class Main{
    static function main(){
        // pass third parameter true for apps with single command
        var app = new CliApp("TestCliApp","0.1.0");
        app.start();
    }
}
```

To extend its behaviour, create command classes.

```haxe
class HelloWorldCommand extends comma.Command{
    override function getName(){
        return "hello";
    }
    override function getDescription(){
        return "Prints \"hello, world!\"";
    }

    override function onExecuted(app:CliApp, values:Array<String>,  options:ParsedOptions){
        app.println("Hello, world!");
    }
}
```

then, register your command to CliApp instance, before starting your application.

```haxe
var app = new CliApp("TestCliApp", "0.1.0");
app.addCommand(new HelloWorldCommand());
app.start();
```

To execute a find specific command, return value of `getName()` is used. The result would be

```text
~ yourApp hello
Hello, world!
```

### Command Options and Values

You can define options and values for commands using `addOptionDefinition(OptionDefinition)` and `addValueDefinition(ValueDefinition)` functions respectively. Call them in the constructor

```haxe
class HelloWorld extends comma.Command{
    public function new(){
        super();
        addValueDefinition(new ValueDefinition("name"));
        addOptionDefinition(new OptionDefinition("shout","s","Write the name with capital letters"));
    }
}
```

OptionDefinition takes a name, an alias and a description. This example option can be used either with `--shout` or `-s`

if number of value definitions and provided values do not match, execution will break and print help text for the command

```text
~ yourApp hello
Usage:
    hello [name]:                                 Prints "hello, world!"
```

to use options and values while executing the command use following:

```haxe
    override function onExecuted(app:CliApp, values:Array<String>,  options:ParsedOptions){
        var text = values[0] + ": Hello, world!";
        if (options.exists("shout")){
            text = text.toUpperCase();
        }
        app.println(text);
    }
```

result will be following:

```text
~ yourApp hello Haxe
Haxe: Hello, world!

~ yourApp hello Haxe --shout
HAXE: HELLO, WORLD!
```

commands can contain values. Anything provided after the option until another option is passed as array of strings

```haxe
if (options.exists("shout")){
    text = text.toUpperCase() + " " + option.get("shout").join("-");
}
```

will result as

```text
~ yourApp hello Haxe --shout some irrelevant values
HAXE: HELLO, WORLD! some-irrelevant-values
```

### Default Command

Default command is executed if no command is provided. By default, the first registered command is the default command, unless specified otherwise with `CliApp.setDefaultCommand(command)`


### Getting User Prompt

Use `CliApp.prompt(String)` function to request input from user.

```haxe
override function onExecuted(app:CliApp, values:Array<String>,  options:ParsedOptions){

    app.println("Hello there, " + app.prompt("What is your name?"));
}
```

```text
~ yourApp

What is your name?: Foo
Hello there, Foo
```

### Styling

`Style` class can be used to stylize the output.
`Style.color(String, TextColor)` converts given string to colored string
`Style.background(String, BackgroundColor)` sets the background color of the given string.
`Style.textStyle(String, TextStyle)` sets the style of the given string. (Bold, Underline, Reversed)
`Style.space(Int)` places space given times
`Style.tabs(Int, Bool=true)` places tabs given times, second parameter decides whether to use \t or 4x spaces.
`Style.compose(String)` creates a builder to combine multiple style functions. 

```haxe
var stylizedText = Style.compose("Hello, world!).setTextStyle(Bold).setTextColor(Red).setBackgroundColor(Blue).build();
cliApp.println(stylizedText);
```

### Printing Help

use `CliApp.printHelp()` to print help text.

## License

[MIT](https://github.com/metincetin/comma/blob/main/LICENSE)