package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class FindImmortalView extends Base implements IView
    {
        private var _findImmortal:IFindImmortal;
        private var _state:int;
        private var _needIngot:Array;
        private var url:String;
        private var _turn_big_file:File;
        private var _green_born_file:File;
        private var _green_wait_file:File;
        private var _blue_born_file:File;
        private var _blue_wait_file:File;
        private var _purple_born_file:File;
        private var _purple_wait_file:File;
        private var _gold_born_file:File;
        private var _gold_wait_file:File;
        private var _greenFailed:File;
        private var _blueFailed:File;
        private var _purpleFailed:File;
        private var _goldFailed:File;
        private var _waitToBig:File;

        public function FindImmortalView()
        {
            this._needIngot = [10, 50, 50, 100, 200];
            this.url = URI.findImmortalUrl;
            return;
        }// end function

        public function showBtn() : void
        {
            var _loc_1:* = _ctrl.player.level;
            if (_loc_1 >= 60)
            {
                _view.activities.addActivity(FunctionType.FindImmortal);
            }
            return;
        }// end function

        public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (_view.worldBossMap.inStageWithTip)
            {
                return;
            }
            if (_view.missionMap.inStageWithTip)
            {
                return;
            }
            _view.closeEvent();
            _view.screen.stopPlayerRun();
            this.open();
            return;
        }// end function

        public function close() : void
        {
            _view.openEvent();
            _popup.closeView(this);
            this.clear();
            return;
        }// end function

        public function clear() : void
        {
            this._state = 0;
            this._findImmortal.clear();
            return;
        }// end function

        private function open() : void
        {
            _data.call(Mod_FindImmortal_Base.open_find_immortal, this.openCallBack, []);
            return;
        }// end function

        private function summon() : void
        {
            _data.call(Mod_FindImmortal_Base.start_find_immortal, this.summonCallBack, []);
            return;
        }// end function

        private function goad() : void
        {
            _data.call(Mod_FindImmortal_Base.goad, this.goadCallBack, []);
            return;
        }// end function

        private function pickup() : void
        {
            _data.call(Mod_FindImmortal_Base.pickup_award, this.pickUpCallBack, []);
            return;
        }// end function

        public function summonTimes() : void
        {
            _data.call(Mod_FindImmortal_Base.get_xun_xian_ling_number, this.summonTimesCallBack, []);
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function openCallBack() : void
        {
            this.loadResource();
            return;
        }// end function

        private function render(param1:Array) : void
        {
            var list:* = param1;
            if (this._findImmortal == null)
            {
                this._findImmortal = (list[0] as File).getClassObject("FindImmortal") as IFindImmortal;
            }
            _popup.addView(this, this._findImmortal.content);
            this._findImmortal.tip = _view.tip.iTip;
            this._findImmortal.drag = _view.drag.iDrag;
            this.ingot = _ctrl.player.ingot;
            this.coins = _ctrl.player.coins;
            this.fame = _ctrl.player.fame;
            this.skill = _ctrl.player.skill;
            this._findImmortal.onClose = this.close;
            this._findImmortal.onSummon = this.summon;
            this._findImmortal.onGoad = function () : void
            {
                var callback:Function;
                var info:* = Lang.sprintf(FindImmortalViewLang.GoadCostTip, HtmlText.yellow(_needIngot[_state] + FindImmortalViewLang.Ingot));
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.JiJiangYuanBaoXiaoFei))
                {
                    dialog.yesLabel = FindImmortalViewLang.Sure;
                    dialog.cancelLabel = FindImmortalViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        goad();
                    }
                    else
                    {
                        _findImmortal.resetMoving = false;
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.JiJiangYuanBaoXiaoFei, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(info, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    goad();
                }
                return;
            }// end function
            ;
            this._findImmortal.onPickUp = this.pickup;
            this._findImmortal.onShowTip = this.showMessage;
            _view.chat.updateDepth(this);
            this._findImmortal.isOpen = true;
            this._findImmortal.purpleWait = (list[1] as File).getClassObject("PurpleWait") as MovieClip;
            this._findImmortal.purpleBorn = (list[2] as File).getClassObject("PurpleBorn") as MovieClip;
            this._findImmortal.turnBig = (list[3] as File).getClassObject("TurnBig") as MovieClip;
            this._findImmortal.purpleFailed = (list[4] as File).getClassObject("PurpleFailed") as MovieClip;
            this._findImmortal.waitToBig = (list[5] as File).getClassObject("WaitToBig") as MovieClip;
            this._findImmortal.loadEffect();
            var data:* = _ctrl.findImmortal.openFindImmortal;
            this._findImmortal.godId = 3;
            this._findImmortal.award = data.award;
            this._findImmortal.state = data.state;
            this._findImmortal.summonTimes = data.can_buy_number;
            this._findImmortal.render();
            this.reposition();
            return;
        }// end function

        private function loadResource() : void
        {
            if (this._waitToBig != null)
            {
                return;
            }
            var _loc_1:Array = [];
            _loc_1.push(_view.getAssetsUrl("FindImmortal"));
            _loc_1.push(this.url + "purple_wait.swf");
            _loc_1.push(this.url + "purple_born.swf");
            _loc_1.push(this.url + "turn_big.swf");
            _loc_1.push(this.url + "purple_failed.swf");
            _loc_1.push(this.url + "wait_to_big.swf");
            loadAssetsList(_loc_1, this.render, FindImmortalViewLang.Open);
            return;
        }// end function

        private function summonCallBack() : void
        {
            var _loc_1:* = _ctrl.findImmortal.start;
            if (_loc_1.type == Mod_FindImmortal_Base.SUCCESS)
            {
                this._findImmortal.isOpen = false;
                this._findImmortal.godId = 3;
                this._findImmortal.award = _loc_1.award;
                this._findImmortal.state = _loc_1.state;
                this._findImmortal.summonTimes = _loc_1.remain_number;
                this._state = _loc_1.state;
                this._findImmortal.bornEffect(3);
            }
            else
            {
                this.showMessage(_loc_1.type);
            }
            return;
        }// end function

        private function goadCallBack() : void
        {
            var _loc_1:* = _ctrl.findImmortal.goad;
            this._findImmortal.award = _loc_1.award;
            this._findImmortal.state = _loc_1.state;
            this._findImmortal.isGoad = _loc_1.type == Mod_FindImmortal_Base.SUCCESS;
            this._state = _loc_1.state;
            return;
        }// end function

        private function pickUpCallBack() : void
        {
            var _loc_1:* = _ctrl.findImmortal.pickUpAward;
            if (_loc_1.type == Mod_FindImmortal_Base.SUCCESS)
            {
                this._findImmortal.pickUpAward = _loc_1.award;
                this._findImmortal.state = 0;
            }
            else
            {
                this.showMessage(_loc_1.type);
            }
            return;
        }// end function

        private function summonTimesCallBack() : void
        {
            var _loc_1:int = 0;
            if (inStage)
            {
                _loc_1 = _ctrl.findImmortal.flagNum;
                this._findImmortal.summonTimes = _loc_1;
            }
            return;
        }// end function

        private function renderAward(param1:Object) : void
        {
            return;
        }// end function

        public function set ingot(param1:int) : void
        {
            if (inStage && this._findImmortal)
            {
                this._findImmortal.ingot = param1;
            }
            return;
        }// end function

        public function set coins(param1:Number) : void
        {
            if (inStage && this._findImmortal)
            {
                this._findImmortal.coins = param1;
            }
            return;
        }// end function

        public function set fame(param1:int) : void
        {
            if (inStage && this._findImmortal)
            {
                this._findImmortal.fame = param1;
            }
            return;
        }// end function

        public function set skill(param1:int) : void
        {
            if (inStage && this._findImmortal)
            {
                this._findImmortal.skill = param1;
            }
            return;
        }// end function

        private function showMessage(param1:int) : void
        {
            _view.showTip(this.message(param1));
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_FindImmortal_Base.NOT_ENOUGH_INGOT:
                {
                    _loc_2 = FindImmortalViewLang.NotEnoughIngot;
                    break;
                }
                case Mod_FindImmortal_Base.GOADING:
                {
                    _loc_2 = FindImmortalViewLang.Goading;
                    break;
                }
                case Mod_FindImmortal_Base.FAILED:
                {
                    _loc_2 = FindImmortalViewLang.Failed;
                    break;
                }
                case Mod_FindImmortal_Base.HAVE_NOT_FIND:
                {
                    _loc_2 = FindImmortalViewLang.HaveNotFind;
                    break;
                }
                case Mod_FindImmortal_Base.HAVE_NOT_NUMBER:
                {
                    _loc_2 = FindImmortalViewLang.XunXianLing;
                    break;
                }
                case 99:
                {
                    _loc_2 = FindImmortalViewLang.Summoning;
                    break;
                }
                case Mod_FindImmortal_Base.NOT_ENOUGH_COIN:
                {
                    _loc_2 = FindImmortalViewLang.NotEnoughCoin;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function reposition() : void
        {
            if (!inStage || !this._findImmortal)
            {
                return;
            }
            var _loc_1:* = Math.max(800, Math.min(Structure.maxStageWidth, this._findImmortal.content.stage.stageWidth));
            var _loc_2:* = Math.max(400, Math.min(Structure.maxStageHeight, this._findImmortal.content.stage.stageHeight));
            var _loc_3:* = _loc_2 - 650;
            var _loc_4:* = _loc_1 - 1250;
            this._findImmortal.content.y = _loc_3 / 2;
            this._findImmortal.content.x = _loc_4 / 2;
            this._findImmortal.reposition(_loc_4 / 2, _loc_3 / 2);
            return;
        }// end function

    }
}
