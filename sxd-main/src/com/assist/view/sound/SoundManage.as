package com.assist.view.sound
{
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;

    public class SoundManage extends Object
    {
        private static var _mute:int = 1;
        private static var _bgVolume:int = 100;
        private static var _gameVolume:int = 100;
        private static var _soundList:Object = {};
        private static var _bgSound:soundObj = null;
        public static var getVersion:Function;
        private static var _sayChannel:SoundChannel;

        public function SoundManage()
        {
            return;
        }// end function

        public static function set bgVolume(param1:int) : void
        {
            _bgVolume = param1;
            upVolume();
            return;
        }// end function

        public static function get bgVolume() : int
        {
            return _bgVolume;
        }// end function

        public static function set gameVolume(param1:int) : void
        {
            _gameVolume = param1;
            return;
        }// end function

        public static function get gameVolume() : int
        {
            return _gameVolume;
        }// end function

        public static function set mute(param1:int) : void
        {
            _mute = param1;
            upVolume();
            return;
        }// end function

        public static function get mute() : int
        {
            return _mute;
        }// end function

        private static function upVolume() : void
        {
            var _loc_1:* = _bgVolume * _mute;
            if (_bgSound != null)
            {
                _bgSound.updateSoundTransform(_loc_1);
            }
            return;
        }// end function

        public static function playBgSound(param1:String) : void
        {
            var _loc_2:soundObj = null;
            if (param1 == "")
            {
                stopBgSound();
                return;
            }
            if (param1.indexOf("?") == -1)
            {
                param1 = param1 + "?v=" + SoundManage.getVersion(param1);
            }
            var _loc_3:* = _bgVolume * _mute;
            if (_soundList[param1] != null)
            {
                _loc_2 = _soundList[param1];
                _loc_2.updateSoundTransform(_loc_3);
            }
            else
            {
                var _loc_4:* = new soundObj();
                _loc_2 = new soundObj();
                _soundList[param1] = _loc_4;
                _loc_2.PlayerUrl(param1, _loc_3);
            }
            if (_bgSound != null && _bgSound != _loc_2)
            {
                _bgSound.stopSound();
            }
            _bgSound = _loc_2;
            return;
        }// end function

        private static function stopBgSound() : void
        {
            if (_bgSound != null)
            {
                _bgSound.stopSound();
            }
            _bgSound = null;
            return;
        }// end function

        public static function playGameSound(param1) : SoundChannel
        {
            var _loc_2:* = _gameVolume * _mute;
            if (_loc_2 < 5)
            {
                return null;
            }
            var _loc_3:* = param1 as Sound;
            if (param1 is String)
            {
                _loc_3 = new Sound(new URLRequest(param1));
            }
            else if (param1 is Class)
            {
                _loc_3 = new param1;
            }
            if (_loc_3 == null)
            {
                return null;
            }
            return _loc_3.play(0, 1, soundObj.getSTF(_loc_2));
        }// end function

        public static function playSaySound(param1, param2:int = 0) : SoundChannel
        {
            var _loc_3:* = param1 as Sound;
            if (param1 is String)
            {
                _loc_3 = new Sound(new URLRequest(param1));
            }
            else if (param1 is Class)
            {
                _loc_3 = new param1;
            }
            if (_loc_3 == null)
            {
                return null;
            }
            if (_sayChannel != null)
            {
                _sayChannel.stop();
            }
            _sayChannel = _loc_3.play(param2, 1, null);
            _sayChannel.addEventListener(Event.SOUND_COMPLETE, onSayComplete);
            var _loc_4:* = _bgVolume * _mute;
            if (_bgSound != null && _loc_4 > 20)
            {
                _bgSound.updateSoundTransform(20);
            }
            return _sayChannel;
        }// end function

        private static function onSayComplete(event:Event) : void
        {
            if (_sayChannel != event.currentTarget)
            {
                return;
            }
            _sayChannel = null;
            var _loc_2:* = _bgVolume * _mute;
            if (_bgSound != null && _loc_2 > 20)
            {
                _bgSound.updateSoundTransform(_loc_2);
            }
            return;
        }// end function

    }
}

class soundObj extends Sound
{
    private var state:String = "stop";
    private var soundchannel:SoundChannel = null;
    private var soundurl:String = "";
    private var stf:int = 0;
    private var value:Number = 0;
    private var soundTime:int = 0;
    private var isWar:Boolean = false;
    private var isError:Boolean = false;
    private static var timer:Timer;
    private static var STFlist:Array = [];

    function soundObj()
    {
        return;
    }// end function

    public function PlayerUrl(param1:String, param2:int) : void
    {
        if (timer == null)
        {
            timer = new Timer(100);
            timer.start();
        }
        this.isWar = param1.indexOf("War.mp3") != -1;
        this.soundurl = param1;
        this.stf = param2;
        this.load(new URLRequest(param1));
        this.addEventListener(Event.COMPLETE, this.completeFun);
        this.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
        this.state = "play";
        return;
    }// end function

    public function stopSound() : void
    {
        this.state = "stop";
        if (this.soundchannel != null)
        {
            this.soundTime = this.soundchannel.position;
            this.value = this.stf - this.stf % 5;
            this.soundchannel.soundTransform = getSTF(this.value);
            timer.addEventListener(TimerEvent.TIMER, this.soundOut);
        }
        return;
    }// end function

    public function updateSoundTransform(param1:int) : void
    {
        this.stf = param1;
        if (this.soundchannel == null)
        {
            return;
        }
        if (this.state == "play")
        {
            if (this.isError == true)
            {
                return;
            }
            this.value = param1 - param1 % 5;
            this.soundchannel.soundTransform = getSTF(this.value);
        }
        else
        {
            this.state = "play";
            if (this.isError == true)
            {
                return;
            }
            this.value = 0;
            if (this.soundchannel != null)
            {
                this.soundchannel.stop();
            }
            this.soundchannel = play(this.isWar ? (0) : (this.soundTime), 1, getSTF(this.value));
            if (this.soundchannel == null)
            {
                return;
            }
            this.soundchannel.addEventListener(Event.SOUND_COMPLETE, this.playSoundComplete);
            timer.addEventListener(TimerEvent.TIMER, this.soundIn);
        }
        return;
    }// end function

    private function ioErrorHandler(event:Event) : void
    {
        this.isError = true;
        return;
    }// end function

    private function completeFun(event:Event) : void
    {
        if (this.state == "play")
        {
            this.value = 0;
            this.soundchannel = play(0, 1, getSTF(this.value));
            if (this.soundchannel == null)
            {
                return;
            }
            this.soundchannel.addEventListener(Event.SOUND_COMPLETE, this.playSoundComplete);
            timer.addEventListener(TimerEvent.TIMER, this.soundIn);
        }
        return;
    }// end function

    private function playSoundComplete(event:Event) : void
    {
        var _loc_2:* = event.currentTarget as SoundChannel;
        _loc_2.removeEventListener(Event.SOUND_COMPLETE, this.playSoundComplete);
        if (_loc_2 == this.soundchannel && this.state == "play")
        {
            this.soundchannel = play(50, 1, getSTF(this.value));
            if (this.soundchannel == null)
            {
                return;
            }
            this.soundchannel.addEventListener(Event.SOUND_COMPLETE, this.playSoundComplete);
        }
        return;
    }// end function

    private function soundIn(event:Event) : void
    {
        if (this.state == "play" && this.value < this.stf)
        {
            this.value = this.value + 5;
            this.soundchannel.soundTransform = getSTF(this.value);
            return;
        }
        timer.removeEventListener(TimerEvent.TIMER, this.soundIn);
        return;
    }// end function

    private function soundOut(event:Event) : void
    {
        if (this.state == "stop" && this.value > 0)
        {
            this.value = this.value - 10;
            this.soundchannel.soundTransform = getSTF(this.value);
            if (this.value <= 0)
            {
                this.soundchannel.stop();
            }
            return;
        }
        timer.removeEventListener(TimerEvent.TIMER, this.soundOut);
        return;
    }// end function

    public static function getSTF(param1:int) : SoundTransform
    {
        var _loc_2:* = new SoundTransform(param1 * 0.01);
        STFlist[param1] = new SoundTransform(param1 * 0.01);
        return STFlist[param1] || _loc_2;
    }// end function

}

