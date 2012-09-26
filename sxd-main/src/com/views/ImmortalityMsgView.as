package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.pack.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class ImmortalityMsgView extends Base implements IView
    {
        public var roleLv:int = 0;
        public var roleName:String = "";
        public var playerRoleId:int = 0;
        private var _target:IImmortalityMsg;
        private var _info:ImmortalityInfo;
        private static var nullFun:Function = new Function();

        public function ImmortalityMsgView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (this._target != null)
            {
                this._target.onFuYong = nullFun;
            }
            this.get_player_role_elixir_record();
            return;
        }// end function

        public function close() : void
        {
            this.playerRoleId = 0;
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
                this._target = _view.getAssetsObject("ImmortalityMsg", "MCImmortalityMsg") as IImmortalityMsg;
                this._target.onClose = this.close;
                this._target.onTip = this.onTip;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._info = new ImmortalityInfo();
            this._info.listWuli = _ctrl.item.danyaoList[ItemType.WuLiDan];
            this._info.listJueJi = _ctrl.item.danyaoList[ItemType.JueJiDan];
            this._info.listFaShu = _ctrl.item.danyaoList[ItemType.FaShuDan];
            this._info.roleLv = this.roleLv;
            this._info.roleName = this.roleName;
            this._info.inogteat = _ctrl.player.vipLevel >= 5;
            this._info.inogteatLv6 = _ctrl.player.vipLevel >= 7;
            this._info.inogteatLv7 = _ctrl.player.vipLevel >= 7;
            this._target.onFuYong = this.onFuYong;
            this._target.initData(this._info);
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2) : void
        {
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
            }
            return;
        }// end function

        private function onFuYong(param1:Object) : void
        {
            var obj:* = param1;
            var basic:* = ItemBasically.getBasic(obj.itemId);
            var count:* = (obj.c + 1);
            var add:* = String(obj.a - obj.c * 5);
            var str:String;
            if (basic.type_id == ItemType.WuLiDan)
            {
                add = ImmortalityMsgViewLang.WuLi + HtmlText.yellow("+" + add);
            }
            else if (basic.type_id == ItemType.FaShuDan)
            {
                add = ImmortalityMsgViewLang.FaShu + HtmlText.yellow("+" + add);
            }
            else if (basic.type_id == ItemType.JueJiDan)
            {
                add = ImmortalityMsgViewLang.JueJi + HtmlText.yellow("+" + add);
            }
            if (obj.num != 0)
            {
                str = Lang.sprintf(ImmortalityMsgViewLang.AskEatTip, HtmlText.yellow(this.roleName), HtmlText.yellow(count + ""), HtmlText.yellow(basic.name), add);
                _view.alert.showYesNoMsg(HtmlText.white(str), ImmortalityMsgViewLang.Eat, ImmortalityMsgViewLang.UnEat, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    player_use_grid_elixir(obj.gid);
                }
                return;
            }// end function
            );
            }
            else if (_view.ingotEnough(obj.ingot))
            {
                str = Lang.sprintf(ImmortalityMsgViewLang.AskEatTipIngot, HtmlText.yellow(obj.ingot + ImmortalityMsgViewLang.Ingot), HtmlText.yellow(this.roleName), HtmlText.yellow(count + ""), HtmlText.yellow(basic.name), add);
                this.checkBoxSelect(ConsumeAlertSetType.ImmortalityCookie, HtmlText.white(str), function () : void
            {
                player_use_ingot_elixir(obj.itemId);
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function showSee(param1:ImmortalityInfo) : void
        {
            this.roleLv = param1.roleLv;
            this.roleName = param1.roleName;
            this._info = param1;
            this._info.isSee = true;
            loadAssets("ImmortalityMsg", null, ImmortalityMsgViewLang.LaodingImmortalityTip, false, false, this.loadComplete2);
            return;
        }// end function

        private function loadComplete2() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("ImmortalityMsg", "MCImmortalityMsg") as IImmortalityMsg;
                this._target.onClose = this.close;
                this._target.onTip = this.onTip;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._target.onFuYong = new Function();
            this._target.initData(this._info);
            return;
        }// end function

        private function checkBoxSelect(param1:int, param2:String, param3:Function) : void
        {
            var cookieId:* = param1;
            var msg:* = param2;
            var callback:* = param3;
            if (_view.consumeAlertSetting.isAlert(cookieId))
            {
                this.callback();
            }
            else
            {
                _view.alert.iAlert.hasCheckbox = true;
                _view.alert.showYesNoMsg(msg, ImmortalityMsgViewLang.Eat, ImmortalityMsgViewLang.UnEat, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    callback();
                    if (_view.alert.iAlert.checked == true)
                    {
                        _view.consumeAlertSetting.saveSetting(cookieId, true);
                    }
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function get_player_role_elixir_record() : void
        {
            _data.call(Mod_Item_Base.get_player_role_elixir_record, this.get_player_role_elixir_record_back, [this.playerRoleId]);
            return;
        }// end function

        private function get_player_role_elixir_record_back() : void
        {
            if (_ctrl.item.playerRoleId != this.playerRoleId)
            {
                return;
            }
            loadAssets("ImmortalityMsg", null, ImmortalityMsgViewLang.LaodingImmortalityTip, false, false, this.loadComplete);
            return;
        }// end function

        private function player_use_grid_elixir(param1:int) : void
        {
            _data.call(Mod_Item_Base.player_use_grid_elixir, this.player_use_grid_elixir_back, [param1, this.playerRoleId]);
            return;
        }// end function

        private function player_use_ingot_elixir(param1:int) : void
        {
            _data.call(Mod_Item_Base.player_use_ingot_elixir, this.player_use_grid_elixir_back, [param1, this.playerRoleId]);
            return;
        }// end function

        private function player_use_grid_elixir_back() : void
        {
            if (_ctrl.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.showTip(ImmortalityMsgViewLang.EatImmortalitySuccess, "", TipType.Success);
                _view.roleMsg.updateSimpe();
                this.get_player_role_elixir_record2();
            }
            else
            {
                _view.showTip(ImmortalityMsgViewLang.EatImmortalityFails);
            }
            return;
        }// end function

        private function get_player_role_elixir_record2() : void
        {
            _data.call(Mod_Item_Base.get_player_role_elixir_record, this.get_player_role_elixir_record2_back, [this.playerRoleId]);
            return;
        }// end function

        private function get_player_role_elixir_record2_back() : void
        {
            if (_ctrl.item.playerRoleId != this.playerRoleId)
            {
                return;
            }
            if (inStage == false)
            {
                return;
            }
            this._info.listWuli = _ctrl.item.danyaoList[ItemType.WuLiDan];
            this._info.listJueJi = _ctrl.item.danyaoList[ItemType.JueJiDan];
            this._info.listFaShu = _ctrl.item.danyaoList[ItemType.FaShuDan];
            this._info.roleLv = this.roleLv;
            this._info.roleName = this.roleName;
            this._info.inogteat = _ctrl.player.vipLevel >= 5;
            this._target.initData(this._info);
            return;
        }// end function

    }
}
