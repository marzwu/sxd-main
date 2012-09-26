package com.assist.view.pack
{
    import flash.events.*;

    public class JuanZhouEvent extends Event
    {
        public var id:int = 0;
        public var list:Array;
        public static const Item_Req:String = "Item_Req";

        public function JuanZhouEvent(param1:Array, param2:int = 0, param3:String = "", param4:Boolean = false, param5:Boolean = false)
        {
            super(param3, param4, param5);
            this.list = param1;
            this.id = param2;
            return;
        }// end function

    }
}
