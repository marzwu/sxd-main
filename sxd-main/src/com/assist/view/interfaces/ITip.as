package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public interface ITip
    {

        public function ITip();

        function toString() : String;

        function get stageOffset() : Point;

        function set oParent(param1:Sprite) : void;

        function get oParent() : Sprite;

        function get targets() : Dictionary;

        function addChild(param1:DisplayObject) : DisplayObject;

        function addChildAt(param1:DisplayObject, param2:int) : DisplayObject;

        function addTarget(param1:DisplayObject, param2 = null) : void;

        function addTargetMoreTips(param1:DisplayObject, ... args) : void;

        function addFixedTarget(param1:DisplayObject, param2, param3:Point, param4:Boolean = true) : void;

        function removeTarget(param1:DisplayObject) : void;

        function updateTarget(param1:DisplayObject = null) : void;

        function hide() : void;

        function clickToOpen(param1, param2:Event = null) : Sprite;

        function hideOpened() : void;

        function textTip(param1:DisplayObject, param2:String, param3:uint = 16776960, param4:int = 18) : void;

    }
}
