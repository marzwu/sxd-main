package com.assist.view.sound
{
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;

    public class SoundEffect extends Object
    {
        public static const Button:int = 0;
        public static const MissionChest:int = 1;
        public static const SellItem:int = 2;
        public static const AcceptQuest:int = 3;
        public static const ResearchUpgrade:int = 4;
        public static const LevelUp:int = 5;
        public static const Equip:int = 6;
        public static const CompleteQuest:int = 7;
        public static const AchievementComplete:int = 8;
        public static var url:String;
        public static var onVersion:Function;
        private static var _sounds:Object = {};

        public function SoundEffect()
        {
            return;
        }// end function

        private static function init() : void
        {
            _sounds[Button] = {url:"ui/button.mp3", sound:null};
            _sounds[MissionChest] = {url:"ui/mission_chest.mp3", sound:null};
            _sounds[SellItem] = {url:"ui/sell_item.mp3", sound:null};
            _sounds[AcceptQuest] = {url:"ui/accept_quest.mp3", sound:null};
            _sounds[ResearchUpgrade] = {url:"ui/research_upgrade.mp3", sound:null};
            _sounds[LevelUp] = {url:"ui/level_up.mp3", sound:null};
            _sounds[Equip] = {url:"ui/equip.mp3", sound:null};
            _sounds[CompleteQuest] = {url:"ui/complete_quest.mp3", sound:null};
            _sounds[AchievementComplete] = {url:"ui/achievement_complete.mp3", sound:null};
            return;
        }// end function

        public static function load() : void
        {
            var _loc_1:String = null;
            var _loc_2:Sound = null;
            var _loc_3:String = null;
            for (_loc_1 in _sounds)
            {
                
                _loc_2 = new Sound();
                _sounds[_loc_1]["sound"] = _loc_2;
                _loc_2.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                _loc_2.addEventListener(Event.COMPLETE, completeHandler);
                _loc_3 = url + _sounds[_loc_1]["url"];
                _loc_2.load(new URLRequest(_loc_3 + "?v=" + onVersion(_loc_3)));
            }
            return;
        }// end function

        private static function ioErrorHandler(event:IOErrorEvent) : void
        {
            removeListener(event.currentTarget as Sound);
            return;
        }// end function

        private static function completeHandler(event:Event) : void
        {
            removeListener(event.currentTarget as Sound);
            return;
        }// end function

        private static function removeListener(param1:Sound) : void
        {
            param1.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            param1.removeEventListener(Event.COMPLETE, completeHandler);
            return;
        }// end function

        public static function play(param1:int) : void
        {
            var type:* = param1;
            if (SoundManage.mute == 0)
            {
                return;
            }
            var sound:* = _sounds[type]["sound"];
            if (sound)
            {
                try
                {
                    sound.play(0, 0, new SoundTransform(SoundManage.gameVolume * 0.01));
                }
                catch (e)
                {
                }
            }
            return;
        }// end function

        init();
    }
}
