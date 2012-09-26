package com.views
{
    import com.assist.view.interfaces.*;
    import com.assist.view.sound.*;
    import com.protocols.*;
    import flash.net.*;

    public class SettingView extends Base implements IView
    {
        private var _target:ISetting;
        private var _cookie:SharedObject;

        public function SettingView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            loadAssets("Setting", this.loadComplete, "", true);
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("Setting", "Setting") as ISetting;
                this._target.onClose = this.close;
                this._target.onVolume = this.onVolume;
                this._target.onMute = this.onMute;
                this._target.onCount = this.onCount;
                this._target.onConsume = this.onConsume;
                this._target.onStateChange = this.onStateChange;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                if (SoundManage.mute == 0)
                {
                    this.closeSound();
                }
                if (_view.getCookie("Sound_bgVolume") != null)
                {
                    this._target.bgVolume = int(_view.getCookie("Sound_bgVolume"));
                    this._target.gameVolume = int(_view.getCookie("Sound_gameVolume"));
                    SoundManage.bgVolume = int(_view.getCookie("Sound_bgVolume"));
                    SoundManage.gameVolume = int(_view.getCookie("Sound_gameVolume"));
                }
            }
            this._target.setHadFollowSet(_ctrl.player.vipLevel >= 3, _ctrl.player.playerInfo.petLv > 0, _ctrl.player.playerInfo.is_have_cat);
            this.onStateChangeBack();
            _popup.addView(this, this._target.content);
            return;
        }// end function

        private function onVolume(param1:int, param2:int) : void
        {
            SoundManage.bgVolume = param1;
            SoundManage.gameVolume = param2;
            _view.setCookie("Sound_bgVolume", param1);
            _view.setCookie("Sound_gameVolume", param2);
            return;
        }// end function

        private function onMute(param1:Boolean) : void
        {
            if (param1)
            {
                this.closeSound();
            }
            else
            {
                this.openSound();
            }
            return;
        }// end function

        private function onCount(param1:int) : void
        {
            if (_view.townMap.inStage)
            {
                _view.townMap.otherCount = param1;
            }
            return;
        }// end function

        private function onConsume() : void
        {
            this._view.consumeAlertSetting.show();
            return;
        }// end function

        private function onStateChange(param1:int, param2:int) : void
        {
            _data.call(Mod_Player_Base.player_follow_setting, this.onStateChangeBack, [param1, param2]);
            return;
        }// end function

        private function onStateChangeBack() : void
        {
            this._target.setFollowState(_ctrl.player.playerInfo.is_role_follow, _ctrl.player.playerInfo.is_pet_follow, _ctrl.player.playerInfo.is_cat_follow);
            return;
        }// end function

        public function closeSound() : void
        {
            _view.toolbar.soundMute(true);
            _view.setCookie("Sound_Mute", 2);
            SoundManage.mute = 0;
            if (this._target != null)
            {
                this._target.closeSound();
            }
            return;
        }// end function

        public function openSound() : void
        {
            _view.toolbar.soundMute(false);
            _view.setCookie("Sound_Mute", 1);
            SoundManage.mute = 1;
            if (this._target != null)
            {
                this._target.openSound();
            }
            return;
        }// end function

        public function loadInitSound() : void
        {
            var _loc_1:* = int(_view.getCookie("Sound_Mute"));
            if (_loc_1 == 2)
            {
                this.closeSound();
            }
            return;
        }// end function

    }
}
