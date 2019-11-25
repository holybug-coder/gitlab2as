package {

import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.ui.Keyboard;

public class Main extends Sprite {
    public function Main() {
        var input:TextField = new TextField();
        input.name = "input";
        input.type = TextFieldType.INPUT;
        input.text = "Hello, World";
        input.width = 500;
        addChild(input);

        var output:TextField = new TextField();
        output.y += input.height + 10;
        output.name = "output";
        output.width = 500;
        addChild(output);
        this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onDownKey);
    }

    private function onDownKey(evt:KeyboardEvent):void {
        if (evt.keyCode == Keyboard.ENTER) {
            //测试用例：{"test0":[{"id":0,"num":1},{"id":5,"num":10}],"test1":[{"id":10,"num":100},{"id":50,"num":30}]}
            var temp:Object = StringToObject.parseObject(TextField(this.getChildByName("input")).text);
            TextField(this.getChildByName("output")).text = temp["test1"][0].id + ", " + temp["test1"][0].num;
        }
    }
}
}
