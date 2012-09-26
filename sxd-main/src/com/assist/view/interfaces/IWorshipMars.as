package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IWorshipMars
    {

        public function IWorshipMars();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onTextLink(param1:Function) : void;

        function set onCloseBtn(param1:Function) : void;

        function set onIncenseBtn(param1:Function) : void;

        function render() : void;

        function clear() : void;

        function renderGod(param1:Object) : void;

        function renderRecordList(param1:Array) : void;

    }
}
