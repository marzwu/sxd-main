package com.views
{
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class ConsumeAlertSettingView extends Base implements IView
    {
        private var _consumeAlertSetting:IConsumeAlertSetting;
        private var _aryData:Array;

        public function ConsumeAlertSettingView()
        {
            this._aryData = [];
            return;
        }// end function

        public function show() : void
        {
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._consumeAlertSetting.clear();
            return;
        }// end function

        public function isAlert(param1:int) : Boolean
        {
            var _loc_2:Object = null;
            for each (_loc_2 in this._aryData)
            {
                
                if (_loc_2["id"] == param1)
                {
                    return _loc_2["state"] == 1;
                }
            }
            return false;
        }// end function

        public function saveSetting(param1:int, param2:Boolean) : void
        {
            var _loc_3:Object = null;
            for each (_loc_3 in this._aryData)
            {
                
                if (_loc_3["id"] == param1)
                {
                    _loc_3["state"] = param2 ? (1) : (0);
                    break;
                }
            }
            this.player_consume_alert_set(param1, param2 ? (1) : (0));
            return;
        }// end function

        public function loadSettingInfo() : void
        {
            var loadSettingInfoCallBack:Function;
            loadSettingInfoCallBack = function () : void
            {
                _aryData = _ctrl.consumeAlertSetting.playerConsumeAlertSetInfo;
                return;
            }// end function
            ;
            this.player_consume_alert_set_info(loadSettingInfoCallBack);
            return;
        }// end function

        private function loadData() : void
        {
            this.player_consume_alert_set_info(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("ConsumeAlertSetting", this.render, ConsumeAlertSettingViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._consumeAlertSetting.content);
            _view.center(sign, this._consumeAlertSetting.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._consumeAlertSetting == null)
            {
                this._consumeAlertSetting = _view.getAssetsObject("ConsumeAlertSetting", "ConsumeAlertSetting") as IConsumeAlertSetting;
            }
            this.init();
            this.playerConsumeAlertSetInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._consumeAlertSetting.tip = this._view.tip.iTip;
            this._consumeAlertSetting.drag = this._view.drag.iDrag;
            this._consumeAlertSetting.onClose = this.close;
            this._consumeAlertSetting.onSubmit = this.saveData;
            this._consumeAlertSetting.init();
            return;
        }// end function

        private function saveData(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            for each (_loc_2 in param1)
            {
                
                for each (_loc_3 in this._aryData)
                {
                    
                    if (_loc_2["id"] == _loc_3["id"] && _loc_2["state"] != _loc_3["state"])
                    {
                        _loc_3["state"] = _loc_2["state"];
                        this.player_consume_alert_set(_loc_3["id"], _loc_3["state"]);
                        break;
                    }
                }
            }
            _view.showTip(ConsumeAlertSettingViewLang.SaveSuccess, null, TipType.Success);
            this._consumeAlertSetting.renderSubmit();
            this.close();
            return;
        }// end function

        private function getIsOpen(param1:int) : Boolean
        {
            var _loc_2:Boolean = false;
            switch(param1)
            {
                case ConsumeAlertSetType.BatchRune:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Rune);
                    break;
                }
                case ConsumeAlertSetType.FarmRefreshHerbsSeed:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Farm);
                    break;
                }
                case ConsumeAlertSetType.FarmGetTopHerbsSeed:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Farm);
                    break;
                }
                case ConsumeAlertSetType.FarmClearFarmlandCD:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Farm);
                    break;
                }
                case ConsumeAlertSetType.BuyCoinTreeCount:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.CoinTree);
                    break;
                }
                case ConsumeAlertSetType.FarmFieldLevelUp:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Farm);
                    break;
                }
                case ConsumeAlertSetType.FarmBatPlant:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Farm);
                    break;
                }
                case ConsumeAlertSetType.AddChallenge:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SuperSport);
                    break;
                }
                case ConsumeAlertSetType.SportClearCd:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SuperSport);
                    break;
                }
                case ConsumeAlertSetType.RefreshDailyQuest:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.DailyQuest);
                    break;
                }
                case ConsumeAlertSetType.RefineZhiZhuo1001:
                {
                    _loc_2 = this._ctrl.player.townKey >= TownType.getLock(TownType.getId(TownType.JingCheng));
                    break;
                }
                case ConsumeAlertSetType.ImmortalityCookie:
                {
                    _loc_2 = this._ctrl.player.townKey >= TownType.getLock(TownType.getId(TownType.JingCheng));
                    break;
                }
                case ConsumeAlertSetType.RefineZhiZhuo1002:
                {
                    _loc_2 = this._ctrl.player.townKey >= TownType.getLock(TownType.getId(TownType.JingCheng));
                    break;
                }
                case ConsumeAlertSetType.CampWarIngotBuyBuff:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.CampWar);
                    break;
                }
                case ConsumeAlertSetType.BossCookie1:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.WorldBoss);
                    break;
                }
                case ConsumeAlertSetType.BossCookie4:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.WorldBoss);
                    break;
                }
                case ConsumeAlertSetType.BossCookie3:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.WorldBoss);
                    break;
                }
                case ConsumeAlertSetType.BuyFateNpc:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Fate);
                    break;
                }
                case ConsumeAlertSetType.BuyHeroChallenge:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.HeroMission);
                    break;
                }
                case ConsumeAlertSetType.TravelEventCD:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TravelEvent);
                    break;
                }
                case ConsumeAlertSetType.FactionSealCallNpc:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Faction);
                    break;
                }
                case ConsumeAlertSetType.TakeBibleSpeedUp:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.TakeBibleRefreshAngel:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.TakeBibleInspire:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.TakeBibleMaxSpeedUp:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.SummerTS:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.TakeBibleClearCd:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.CanBaiRuLai:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.ZhaoHuanSanXian:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.SoulSuccinct:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SealSoul);
                    break;
                }
                case ConsumeAlertSetType.SoulActivation:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SealSoul);
                    break;
                }
                case ConsumeAlertSetType.SoulTraining2:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SealSoul);
                    break;
                }
                case ConsumeAlertSetType.TowerViewReset:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Tower);
                    break;
                }
                case ConsumeAlertSetType.BackFreeSealTraining:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SealSoul);
                    break;
                }
                case ConsumeAlertSetType.BackCampSalary:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.CampSalary);
                    break;
                }
                case ConsumeAlertSetType.BackDailyQuest:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.DailyQuest);
                    break;
                }
                case ConsumeAlertSetType.BackFactionBlessing:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Faction) && ActivityType.FactionLevel > 0;
                    break;
                }
                case ConsumeAlertSetType.BackTakeBible:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.BackFateFree:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Fate);
                    break;
                }
                case ConsumeAlertSetType.BackFateIngot:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Fate);
                    break;
                }
                case ConsumeAlertSetType.BackSendFlower:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SendFlower);
                    break;
                }
                case ConsumeAlertSetType.BackCoinTree:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.CoinTree);
                    break;
                }
                case ConsumeAlertSetType.BackRollCake:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.RollCake);
                    break;
                }
                case ConsumeAlertSetType.BackWorshipMars:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.WorshipMars);
                    break;
                }
                case ConsumeAlertSetType.RobelRedirection:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.TakeBible);
                    break;
                }
                case ConsumeAlertSetType.BackGetPeach:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.GetPeach);
                    break;
                }
                case ConsumeAlertSetType.RefreshLuckyShop:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.LuckyShop);
                    break;
                }
                case ConsumeAlertSetType.BackSealStone:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SealSoul);
                    break;
                }
                case ConsumeAlertSetType.GetSealStoneTwo:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SealSoul);
                    break;
                }
                case ConsumeAlertSetType.GetSealStoneThree:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.SealSoul);
                    break;
                }
                case ConsumeAlertSetType.BackPetAnimal:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.PetAnimal);
                    break;
                }
                case ConsumeAlertSetType.ThreeFurnace:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.Furnace);
                    break;
                }
                case ConsumeAlertSetType.XunXianYuanBaoXiaoFei:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.FindImmortal);
                    break;
                }
                case ConsumeAlertSetType.JiJiangYuanBaoXiaoFei:
                {
                    _loc_2 = FunctionType.isOpened(FunctionType.FindImmortal);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function player_consume_alert_set_info(param1:Function) : void
        {
            _data.call(Mod_Player_Base.player_consume_alert_set_info, param1, []);
            return;
        }// end function

        private function playerConsumeAlertSetInfoCallBack() : void
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            this._aryData = this._ctrl.consumeAlertSetting.playerConsumeAlertSetInfo;
            var _loc_1:Array = [];
            for each (_loc_2 in this._aryData)
            {
                
                _loc_4 = {};
                _loc_4["id"] = _loc_2["id"];
                _loc_4["state"] = _loc_2["state"];
                _loc_4["text"] = _loc_2["text"];
                _loc_4["vip"] = _loc_2["vip"];
                _loc_1.push(_loc_4);
            }
            _loc_3 = _loc_1.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_5 = _loc_1[_loc_3] as Object;
                _loc_5["isOpened"] = this.getIsOpen(_loc_5["id"]);
                if (!VIPType.check(_loc_5["vip"]) || _loc_5["isOpened"] == false)
                {
                    _loc_1.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            this._consumeAlertSetting.render(_loc_1);
            return;
        }// end function

        private function player_consume_alert_set(param1:int, param2:int) : void
        {
            _data.call(Mod_Player_Base.player_consume_alert_set, this.playerConsumeAlertSetCallBack, [param1, param2]);
            return;
        }// end function

        private function playerConsumeAlertSetCallBack() : void
        {
            return;
        }// end function

    }
}
