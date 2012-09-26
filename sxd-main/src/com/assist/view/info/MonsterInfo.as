package com.assist.view.info
{

    public class MonsterInfo extends Object
    {
        public var x:int;
        public var y:int;
        public var id:int;
        public var name:String = "";
        public var sign:String = "";
        public var sayMsg:String = "";

        public function MonsterInfo()
        {
            return;
        }// end function

        public function get nameHtml() : String
        {
            return "<font size=\'13\' color=\'#ff0000\'>" + this.name + "</font>";
        }// end function

    }
}
