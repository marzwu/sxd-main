package com.views.structure
{
    import flash.display.*;

    public class Base extends Sprite
    {

        public function Base()
        {
            return;
        }// end function

        public function closeAll() : void
        {
            while (numChildren > 0)
            {
                
                removeChildAt(0);
            }
            return;
        }// end function

        private function hasChild(param1:DisplayObject) : Boolean
        {
            return param1 && param1.parent == this;
        }// end function

    }
}
