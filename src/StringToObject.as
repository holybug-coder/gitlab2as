/**
 * Created by yangdi on 2019/11/25.
 */
package {
public class StringToObject {
    public function StringToObject() {
    }

    /**
     * 测试用例：{"test0":[{"id":0,"num":1},{"id":5,"num":10}],"test1":[{"id":10,"num":100},{"id":50,"num":30}]}
     * var temp:Object = StringToObject.parseObject(TextField(this.getChildByName("input")).text);
     * TextField(this.getChildByName("output")).text = temp["test1"][0].id + ", " + temp["test1"][0].num;
     */

    public static function parseObject(str:String):Object {
        if (str.charAt(0)=="[" && str.charAt(str.length-1)=="]") {
            return getArray(str);
        } else if (str.charAt(0)=="{" && str.charAt(str.length-1)=="}") {
            return getObject(str);
        } else if (str.charAt(0)=="\"" && str.charAt(str.length-1)=="\"") {
            return str.substr(1, str.length-2);
        }
        return Number(str);
    }

    private static function getArray(str:String):Array {
        var arr:Array = [];
        str = str.substr(1, str.length-2);
        var objArr:Array = getObjectArray(str);
        for each(var str:String in objArr) {
            arr.push(parseObject(str));
        }
        return arr;
    }

    private static function getSpace(num:int):String {
        var str:String = "";
        for (var i:int=0; i<num; ++i) {
            str += " ";
        }
        return str;
    }

    private static function getObject(temp:String):Object {
        var tempParams:Object = {};
        temp = temp.substr(1, temp.length-2);
        var arr:Array = getObjectArray(temp);
        for each(var str:String in arr) {
            var index:int = str.indexOf(":");
            var key:String = str.substr(1, index-2);
            tempParams[key] = parseObject(str.substr(index+1));
        }
        return tempParams;
    }

    private static function getObjectArray(str:String):Array {
        var objPos:Array = [];
        var arrPos:Array = [];
        var newStr:String = str.concat();
        var pos:int = 0;
        for (var i:int=0; i<str.length; ++i) {
            if (str.charAt(i) == "{") {
                objPos.push(i);
            } else if (str.charAt(i) == "}") {
                pos = objPos.pop();
                str = str.substr(0, pos+1) + getSpace(i-pos-1) + str.substr(i);
            }
            if (str.charAt(i) == "[") {
                arrPos.push(i);
            } else if (str.charAt(i) == "]") {
                pos = arrPos.pop();
                str = str.substr(0, pos+1) + getSpace(i-pos-1) + str.substr(i);
            }
        }

        var parts:Array = str.split(",");
        var save:Array = [];
        var index:int = 0;
        for each(var part:String in parts) {
            save.push(newStr.substr(index, part.length));
            index += part.length + 1;
        }
        return save;
    }
}
}
