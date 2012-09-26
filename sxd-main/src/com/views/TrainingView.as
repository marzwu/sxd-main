package com.views
{
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.guide.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.controllers.*;
    import com.haloer.display.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class TrainingView extends Base implements IView
    {
        private var _target:ITraining;
        public var roleInfo:RoleInfo;
        private var _favItemNum:int;
        private var _bFavPeiYang:Boolean;
        private static const _NeedFavItemNum:int = 1;

        public function TrainingView()
        {
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:int = 0;
            if (RoleType.getRoleType(this.roleInfo.roleId) != 0)
            {
                _loc_1 = FurnaceType.NvWaShiItemId;
                _data.call(Mod_Item_Base.get_the_item_num, this.getFavItemBack, [_loc_1]);
            }
            else
            {
                this._favItemNum = 0;
                this.panel_show();
            }
            return;
        }// end function

        public function getFavItemBack() : void
        {
            this._favItemNum = _ctrl.item.getTheItemNum["total_num"];
            if (this._target)
            {
                this._target.favItemNum = this._favItemNum;
            }
            this.panel_show();
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            this.onCancelForGuide();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            var _loc_3:Sprite = null;
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
                _loc_3 = param1 as Sprite;
            }
            return;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("Training", "MCTraining") as ITraining;
                this._target.onClose = this.close;
                this._target.onPeiyang = this.onPeiyang;
                this._target.onSave = this.onSave;
                this._target.onCancel = this.onCancel;
                this._target.tfIngot1.htmlText = HtmlText.purple(TrainingViewLang.Training1) + HtmlText.format(TrainingViewLang.Ingot2, 15963904);
                this._target.tfIngot2.htmlText = HtmlText.purple(TrainingViewLang.Training2) + HtmlText.format(TrainingViewLang.Ingot10, 15963904);
                this._target.tfIngot3.htmlText = HtmlText.purple(TrainingViewLang.Training3) + HtmlText.format(TrainingViewLang.Ingot20, 15963904);
                this._target.tfIngot4.htmlText = HtmlText.yellow(TrainingViewLang.Training4) + HtmlText.format(TrainingViewLang.Ingot100, 15963904);
                this._target.onTip = this.onTip;
                _view.drag.iDrag.com.assist.view.interfaces:IDrag::addTarget(this._target.dragTitleBar, this._target.content);
            }
            _popup.addView(this, this._target.content);
            var _loc_1:* = new Image(this.roleInfo.headUrl);
            _loc_1.onComplete = this.laodHeadIconComplete;
            this._target.headIcon = _loc_1;
            if (RoleType.getRoleType(this.roleInfo.roleId) != 0)
            {
                this._target.tfName.htmlText = HtmlText.format(this.roleInfo.name, RoleType.getRoleColorById(this.roleInfo.roleId));
                this._target.favItemVisible = true;
            }
            else
            {
                this._target.tfName.text = this.roleInfo.name;
                this._target.favItemVisible = false;
            }
            this._target.tfLv.text = this.roleInfo.lv + TrainingViewLang.Lv;
            this._target.tfCoin.htmlText = TrainingViewLang.Training0 + this.rolemsg.coin + TrainingViewLang.Coin;
            this._target.radio = this.rolemsg.radio;
            var _loc_2:* = FurnaceType.NvWaShiItemId;
            var _loc_3:* = new ItemInfo();
            _loc_3.parseSee(_loc_2);
            this._target.tfIngot5.htmlText = HtmlText.blue2(TrainingViewLang.Training5) + HtmlText.format(_loc_3.name + "x" + _NeedFavItemNum, 15963904);
            this.updateOldProperty(this.rolemsg.trainingBase, this.rolemsg.trainingOld, this.rolemsg.trainingNew);
            this._view.guide.trackTraining(3, this._target.content);
            this._target.favItemNum = this._favItemNum;
            return;
        }// end function

        private function laodHeadIconComplete(param1:Image) : void
        {
            var _loc_2:int = 50;
            param1.height = 50;
            param1.width = _loc_2;
            return;
        }// end function

        private function updateOldProperty(param1:Array, param2:Array, param3:Array) : void
        {
            this.roleInfo.pWuLi = param1[0] + param2[0];
            this.roleInfo.pJueJi = param1[1] + param2[1];
            this.roleInfo.pFaShu = param1[2] + param2[2];
            var _loc_4:* = this.roleInfo.lv * 4 + 20;
            var _loc_5:Boolean = true;
            var _loc_6:Array = ["", "", ""];
            var _loc_7:Array = ["", "", ""];
            var _loc_8:Array = [0, 0, 0];
            var _loc_9:Array = [3, 3, 3];
            var _loc_10:int = 0;
            while (_loc_10 < 3)
            {
                
                if (param2[_loc_10] == _loc_4)
                {
                    _loc_6[_loc_10] = param2[_loc_10] + "/" + _loc_4 + HtmlText.yellow2(TrainingViewLang.Full);
                    _loc_8[_loc_10] = 100;
                }
                else
                {
                    _loc_6[_loc_10] = param2[_loc_10] + "/" + _loc_4;
                    _loc_5 = false;
                    _loc_8[_loc_10] = int(100 * param2[_loc_10] / _loc_4);
                }
                _loc_10++;
            }
            _loc_10 = param3.length;
            while (_loc_10 > 0)
            {
                
                _loc_10 = _loc_10 - 1;
                if (param3[_loc_10] > param2[_loc_10])
                {
                    _loc_9[_loc_10] = 2;
                    _loc_7[_loc_10] = HtmlText.green("+" + (param3[_loc_10] - param2[_loc_10]));
                }
                else if (param3[_loc_10] < param2[_loc_10])
                {
                    _loc_9[_loc_10] = 1;
                    _loc_7[_loc_10] = HtmlText.red((param3[_loc_10] - param2[_loc_10]).toString());
                }
                else
                {
                    _loc_7[_loc_10] = HtmlText.green("+" + (param3[_loc_10] - param2[_loc_10]));
                }
                if (param3[_loc_10] == _loc_4)
                {
                    _loc_7[_loc_10] = HtmlText.green("+" + (param3[_loc_10] - param2[_loc_10])) + HtmlText.yellow2(TrainingViewLang.Full);
                }
            }
            this._target.setProperty(_loc_6[0], _loc_6[1], _loc_6[2], _loc_8[0], _loc_8[1], _loc_8[2], _loc_7[0], _loc_7[1], _loc_7[2], _loc_9[0], _loc_9[1], _loc_9[2], _loc_5, this._favItemNum >= _NeedFavItemNum);
            return;
        }// end function

        private function onPeiyang() : void
        {
            this.training(this._target.radioIdx);
            this.onTrainingForGuide();
            return;
        }// end function

        private function onSave() : void
        {
            var cookie:String;
            var checked:Boolean;
            if (_ctrl.rolemsg.hasLower == true)
            {
                cookie = this + "Save";
                checked = _view.getCookie(cookie) == 1;
                if (checked == true)
                {
                    this.modify_role_data();
                }
                else
                {
                    _view.alert.iAlert.hasCheckbox = true;
                    _view.alert.showYesNoMsg(TrainingViewLang.SaveShuXing, TrainingViewLang.Yes, TrainingViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    modify_role_data();
                    if (_view.alert.iAlert.checked == true)
                    {
                        _view.setCookie(cookie, 1);
                    }
                }
                else
                {
                    updateOldProperty(rolemsg.trainingBase, rolemsg.trainingOld, rolemsg.trainingNew);
                }
                return;
            }// end function
            );
                }
            }
            else
            {
                this.modify_role_data();
            }
            return;
        }// end function

        private function onCancel() : void
        {
            this.onCancelForGuide();
            this.updateOldProperty(this.rolemsg.trainingBase, this.rolemsg.trainingOld, []);
            return;
        }// end function

        private function get rolemsg() : RoleMsgController
        {
            return _ctrl.rolemsg;
        }// end function

        private function panel_show() : void
        {
            _data.call(Mod_Training_Base.panel_show, this.panel_show_back, [this.roleInfo.playerRoleId]);
            return;
        }// end function

        private function panel_show_back() : void
        {
            loadAssets("Training", null, TrainingViewLang.LoadTrainingTip, false, false, this.loadComplete);
            return;
        }// end function

        private function training(param1:int) : void
        {
            if (param1 == 5)
            {
                this._bFavPeiYang = true;
            }
            else
            {
                this._bFavPeiYang = false;
            }
            _data.call(Mod_Training_Base.training, this.training_back, [this.roleInfo.playerRoleId, param1]);
            return;
        }// end function

        private function training_back() : void
        {
            this.updateOldProperty(this.rolemsg.trainingBase, this.rolemsg.trainingOld, this.rolemsg.trainingNew);
            if (this.rolemsg.result == Mod_Training_Base.SUCCEED)
            {
                if (this._bFavPeiYang)
                {
                    this._favItemNum = this._favItemNum - _NeedFavItemNum;
                    this._target.favItemNum = this._favItemNum;
                }
            }
            else if (this.rolemsg.result == Mod_Training_Base.NOENOUGHCOINS)
            {
                _view.showTip(TrainingViewLang.CoinLack);
            }
            else if (this.rolemsg.result == Mod_Training_Base.NOENOUGHINGOT)
            {
                _view.showTip(TrainingViewLang.IngotLack);
            }
            else
            {
                _view.showTip(TrainingViewLang.TrainingFails);
            }
            return;
        }// end function

        private function modify_role_data() : void
        {
            _data.call(Mod_Training_Base.modify_role_data, this.modify_role_data_back, [this.roleInfo.playerRoleId]);
            return;
        }// end function

        private function modify_role_data_back() : void
        {
            if (this.rolemsg.result == Mod_Training_Base.SUCCEED)
            {
                _view.showTip(TrainingViewLang.SaveSucess, "", TipType.Success);
                this.updateOldProperty(this.rolemsg.trainingBase, this.rolemsg.trainingOld, this.rolemsg.trainingNew);
                this._target.playSaveOK();
                this._view.roleMsg.updateSimpe();
                this.onCancelForGuide();
            }
            else
            {
                _view.showTip(TrainingViewLang.TrainingFails);
            }
            return;
        }// end function

        private function onTrainingForGuide() : void
        {
            this._view.guide.trackTraining(4, this._target.content);
            return;
        }// end function

        private function onCancelForGuide() : void
        {
            _view.guide.setCookie(GuideType.Training);
            _view.guide.stopTrainingGuides();
            return;
        }// end function

    }
}
