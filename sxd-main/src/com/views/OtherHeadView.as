package com.views
{
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.haloer.display.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class OtherHeadView extends Base implements IView
    {
        public var info:PlayerInfo;
        private var _target:MovieClip;
        private var _pid:int = 0;
        private var _icon:Sprite;

        public function OtherHeadView()
        {
            this._icon = new Sprite();
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._target && this._target.stage != null;
        }// end function

        public function show() : void
        {
            if (this.info == null || this.info.isMine == true)
            {
                this.info = null;
                this.close();
            }
            else if (this._pid != this.info.id)
            {
                this._pid = this.info.id;
                loadAssets("OtherHead", null, OtherHeadViewLang.LoadInfo, true, false, this.loadComplete);
            }
            return;
        }// end function

        public function close() : void
        {
            this._pid = 0;
            if (this._target && this._target.parent)
            {
                this._target.parent.removeChild(this._target);
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadComplete() : void
        {
            var _loc_1:Shape = null;
            if (this._target == null)
            {
                _loc_1 = new Shape();
                _loc_1.graphics.beginFill(0, 1);
                _loc_1.graphics.drawCircle(36, 37, 37);
                _loc_1.x = 14;
                _loc_1.y = 14;
                this._icon.x = 13;
                this._icon.y = 14;
                this._icon.graphics.clear();
                this._icon.graphics.beginFill(0, 1);
                this._icon.graphics.drawRect(0, 0, 76, 76);
                this._icon.mask = _loc_1;
                this._target = _view.getAssetsObject("OtherHead", "MCHead") as MovieClip;
                this._target.addChildAt(this._icon, 2);
                this._target.addChildAt(_loc_1, 3);
                this._target.BtnMsg.addEventListener(MouseEvent.CLICK, this.clickMsg);
                this._target.BtnFocus.addEventListener(MouseEvent.CLICK, this.clickFocus);
                this._target.BtnTalk.addEventListener(MouseEvent.CLICK, this.clickTalk);
                this._target.BtnFlower.addEventListener(MouseEvent.CLICK, this.clickFlower);
                this._target.x = 250;
                this._target.y = 5;
            }
            if (this._pid == 0)
            {
                return;
            }
            _popup.addChild(this._target);
            _data.call(Mod_Player_Base.get_other_player_info, this.get_other_player_info_back, [this._pid]);
            this._target.TFName.text = this.info.name;
            this.headImgUrl = this.info.fullHeadUrl;
            this.FlowerVisible = FunctionType.isOpened(FunctionType.SendFlower);
            this.FriendVisible = FunctionType.isOpened(FunctionType.Friend);
            _view.tip.iTip.removeTarget(this._icon);
            this.player_info_contrast();
            return;
        }// end function

        private function set FlowerVisible(param1:Boolean) : void
        {
            this._target.BtnFlower.visible = param1;
            this._target.BtnTalk.x = param1 ? (156) : (96);
            return;
        }// end function

        private function set FriendVisible(param1:Boolean) : void
        {
            this._target.BtnFocus.visible = param1;
            this._target.BtnTalk.visible = param1;
            return;
        }// end function

        private function set headImgUrl(param1:String) : void
        {
            while (this._icon.numChildren)
            {
                
                this._icon.removeChildAt(0);
            }
            this._icon.addChild(new Image(param1));
            return;
        }// end function

        private function clickFocus(event:Event) : void
        {
            _view.friendList.addFriend("", this.info.id);
            return;
        }// end function

        private function clickMsg(event:Event) : void
        {
            _view.otherRoleMsg.init(this.info.id, this.info.name);
            _view.otherRoleMsg.show();
            return;
        }// end function

        private function clickFlower(event:Event) : void
        {
            this._view.sendFlower.sendPlayerID = this._pid;
            this._view.sendFlower.show();
            return;
        }// end function

        private function clickTalk(event:Event) : void
        {
            _view.friendChat.get_friendinfo_chatrecord_list(this.info.id);
            return;
        }// end function

        private function get_other_player_info_back() : void
        {
            this._target.TFLevel.text = _ctrl.player.otherPlayerLv + "";
            return;
        }// end function

        private function player_info_contrast() : void
        {
            if (_view.toolbar.isShowPlayerInfo == false)
            {
                return;
            }
            _data.call(Mod_Player_Base.player_info_contrast, this.player_info_contrast_back, [this._pid], false);
            return;
        }// end function

        private function player_info_contrast_back() : void
        {
            var _loc_1:* = this._ctrl.player.playerInfoContrastData;
            var _loc_2:* = OtherHeadViewLang.RankIng + _loc_1.rankIng + "\n" + (_loc_1.factionName == "" ? ("") : (OtherHeadViewLang.FactionName + _loc_1.factionName + "\n")) + OtherHeadViewLang.Combat + _loc_1.combat + "\n" + OtherHeadViewLang.Fame + _loc_1.fame + "\n" + OtherHeadViewLang.AchievmentPoints + _loc_1.achievmentPoints + "\n" + OtherHeadViewLang.FirstAttack + _loc_1.firstAttack + "\n" + OtherHeadViewLang.FlowerCount + _loc_1.flowerCount;
            _loc_2 = "<textformat leading=\'8\'><font color=\'#ffffff\'>" + _loc_2 + "</font></textformat>";
            var _loc_3:* = new TextField();
            _loc_3.mouseEnabled = false;
            _loc_3.wordWrap = true;
            _loc_3.multiline = true;
            _loc_3.textColor = 16777215;
            _loc_3.htmlText = _loc_2;
            _loc_3.width = _loc_3.textWidth + 5;
            _loc_3.height = _loc_3.textHeight + 5;
            _view.tip.iTip.addTarget(this._icon, _loc_3);
            return;
        }// end function

    }
}
