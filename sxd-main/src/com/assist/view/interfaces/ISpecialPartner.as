package com.assist.view.interfaces
{
    import com.assist.view.interfaces.map.*;
    import flash.display.*;

    public interface ISpecialPartner
    {

        public function ISpecialPartner();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set frameSprite(param1:IFrameSprite) : void;

        function set playerMissionLock(param1:int) : void;

        function init() : void;

        function clear() : void;

        function renderPartnerInfo(param1:Array) : void;

        function renderGetAward(param1:int) : void;

        function renderIngotCompleted(param1:Array) : void;

        function set onClose(param1:Function) : void;

        function set onInvite(param1:Function) : void;

        function set onIngotCompleted(param1:Function) : void;

        function set onGet(param1:Function) : void;

        function set onGotoMission(param1:Function) : void;

        function set onOpenVip(param1:Function) : void;

        function set onAddFrameSprite(param1:Function) : void;

    }
}
