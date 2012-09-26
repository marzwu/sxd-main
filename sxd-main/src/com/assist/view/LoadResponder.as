package com.assist.view
{

    public class LoadResponder extends Object
    {
        public var callback:Function;
        public var progress:Function;

        public function LoadResponder(param1:Function = null, param2:Function = null) : void
        {
            this.callback = param1;
            this.progress = param2;
            return;
        }// end function

        public function lCallback() : void
        {
            this.callback();
            return;
        }// end function

        public function lProgress(param1:String, param2:int, param3:int, param4:int, param5:String) : void
        {
            if (this.progress is Function)
            {
                switch(this.progress.length)
                {
                    case 2:
                    {
                        this.progress(param1, param2);
                        break;
                    }
                    case 3:
                    {
                        this.progress(param1, param2, param3);
                        break;
                    }
                    case 4:
                    {
                        this.progress(param1, param2, param3, param5);
                        break;
                    }
                    case 5:
                    {
                        this.progress(param1, param2, param3, param4, param5);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}
