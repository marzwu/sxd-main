package com.views
{

    public interface IView
    {

        public function IView();

        function get sign() : String;

        function get inStage() : Boolean;

        function get inStageWithTip() : Boolean;

        function get ignoreKeyboardEvent() : Boolean;

        function show() : void;

        function close() : void;

        function clear() : void;

    }
}
