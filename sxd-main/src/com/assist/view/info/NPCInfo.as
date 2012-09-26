package com.assist.view.info
{

    public class NPCInfo extends Object
    {
        public var id:int;
        public var name:String;
        public var x:int;
        public var y:int;
        public var sign:String;
        public var type:int;
        public var lock:int;
        public static const NPC_Default:int = 0;
        public static const NPC_Acceptable:int = 1;
        public static const NPC_Complete:int = 2;
        public static const NPC_Accepted:int = 3;

        public function NPCInfo(param1:Object) : void
        {
            this.x = param1.x;
            this.y = param1.y;
            this.name = param1.name;
            this.id = param1.id;
            this.type = param1.type;
            this.sign = param1.sign;
            return;
        }// end function

        public function get nameHtml() : String
        {
            return "<font size=\'13\' color=\'#fff200\'>" + this.name + "</font>";
        }// end function

    }
}
