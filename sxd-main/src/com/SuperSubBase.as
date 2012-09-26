package com
{
    import flash.utils.*;

    public class SuperSubBase extends Object
    {

        public function SuperSubBase()
        {
            return;
        }// end function

        public function get sign() : String
        {
            return getQualifiedClassName(this);
        }// end function

        public function settle(param1:String, param2:View, param3:Controller, param4:Data, param5:SuperBase) : void
        {
            return;
        }// end function

        protected function inheritError() : String
        {
            return "请检查 " + this.sign + " 是否继承了正确的基类！";
        }// end function

    }
}
