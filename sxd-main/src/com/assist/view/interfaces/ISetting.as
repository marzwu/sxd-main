package com.assist.view.interfaces
{

    public interface ISetting extends IContent, IDragTitleBar
    {

        public function ISetting();

        function set onVolume(param1:Function) : void;

        function set onCount(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onMute(param1:Function) : void;

        function set onConsume(param1:Function) : void;

        function openSound() : void;

        function closeSound() : void;

        function set bgVolume(param1:int) : void;

        function set gameVolume(param1:int) : void;

        function setHadFollowSet(param1:Boolean, param2:Boolean, param3:Boolean) : void;

        function setFollowState(param1:Boolean, param2:Boolean, param3:Boolean) : void;

        function set onStateChange(param1:Function) : void;

    }
}
