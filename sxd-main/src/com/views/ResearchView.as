package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.sound.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class ResearchView extends Base implements IView
    {
        private var _research:IResearch;
        private var _dialog:IAlert;
        private var _blnInResearchUpgrade:Boolean = false;
        private var clearCdTimeForOutsideCallBack:Function = null;

        public function ResearchView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
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
            if (this._dialog != null)
            {
                this._dialog.hide();
            }
            this._research.clear();
            return;
        }// end function

        public function clearCdTime(param1:Function = null) : void
        {
            this.clearCdTimeForOutsideCallBack = param1;
            this.clear_cd_time_show();
            return;
        }// end function

        public function researchUpgrade(param1:int, param2:Function) : void
        {
            this.research_upgrade(param1, param2);
            return;
        }// end function

        private function loadData() : void
        {
            this.research_list(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            var callBack:* = function () : void
            {
                render();
                researchListCallBack();
                showUI();
                return;
            }// end function
            ;
            loadAssets("Research", callBack, ResearchViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            if (this._research == null)
            {
                this._research = _view.getAssetsObject("Research", "Research") as IResearch;
            }
            this.init();
            this._research.init();
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._research.content);
            _view.center(sign, this._research.content);
            return;
        }// end function

        private function init() : void
        {
            this._research.iconUrl = URI.researchIconUrl;
            if (this._dialog == null)
            {
                this._dialog = this._view.alert.iAlert;
            }
            this._research.dialog = this._view.alert.iAlert;
            this._research.tip = this._view.tip.iTip;
            this._research.drag = this._view.drag.iDrag;
            this._research.myLevel = this._ctrl.player.level;
            this._research.onCloseBtn = this.close;
            this._research.onLevelUpBtn = this.lvevlUpResearch;
            this._research.onResearchData = this.researchList;
            return;
        }// end function

        private function getPageCount(param1:Array) : int
        {
            return Math.ceil(param1.length / 12);
        }// end function

        private function lvevlUpResearch() : void
        {
            this.research_upgrade(this._research.researchID, this.researchUpgradeCallBack);
            SoundEffect.play(SoundEffect.ResearchUpgrade);
            return;
        }// end function

        private function researchList() : void
        {
            this.research_list(this.researchListCallBack);
            return;
        }// end function

        public function research_list(param1:Function) : void
        {
            this._data.call(Mod_Research_Base.research_list, param1, [ResearchType.All]);
            return;
        }// end function

        private function researchListCallBack() : void
        {
            this._research.mySkill = this._ctrl.research.getMySkill();
            var _loc_1:* = this._ctrl.research.getResearchList();
            this._research.renderGetResearchData(_loc_1);
            return;
        }// end function

        private function research_upgrade(param1:int, param2:Function) : void
        {
            if (this._blnInResearchUpgrade)
            {
                return;
            }
            this._blnInResearchUpgrade = true;
            this._data.call(Mod_Research_Base.research_upgrade, param2, [param1]);
            return;
        }// end function

        private function researchUpgradeCallBack() : void
        {
            var _loc_1:* = this._ctrl.research.ResearchUpgrade();
            if (_loc_1.result != Mod_Research_Base.SUCCEED)
            {
                _view.showTip(this.message(_loc_1.result));
            }
            else
            {
                this._research.renderLevelUpBtnClick(_loc_1);
                this._view.toolbar.getResearchInfo();
            }
            this._blnInResearchUpgrade = false;
            return;
        }// end function

        private function clear_cd_time_show() : void
        {
            if (!_view.vipEnabled)
            {
                return;
            }
            this._data.call(Mod_Research_Base.clear_cd_time_show, this.clearCdTimeShowCallBack, []);
            return;
        }// end function

        private function clearCdTimeShowCallBack() : void
        {
            return;
        }// end function

        private function clear_cd_time() : void
        {
            this._data.call(Mod_Research_Base.clear_cd_time, this.clearCdTimeCallBack, []);
            return;
        }// end function

        private function clearCdTimeCallBack() : void
        {
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Research_Base.SUCCEED:
                {
                    _loc_2 = ResearchViewLang.Succeed;
                    break;
                }
                case Mod_Research_Base.FAILED:
                {
                    _loc_2 = ResearchViewLang.Failed;
                    break;
                }
                case Mod_Research_Base.FULL:
                {
                    _loc_2 = ResearchViewLang.Full;
                    break;
                }
                case Mod_Research_Base.CDTIME:
                {
                    _loc_2 = ResearchViewLang.CdTime2;
                    break;
                }
                case Mod_Research_Base.NOENOUGHSKILL:
                {
                    _loc_2 = ResearchViewLang.NoEnoughSkill;
                    break;
                }
                case Mod_Research_Base.LIMITLEVELSTRUCT:
                {
                    _loc_2 = ResearchViewLang.LimitLevelStruct;
                    break;
                }
                case Mod_Research_Base.NOENOUGHLEVEL:
                {
                    _loc_2 = ResearchViewLang.NoEnoughLevel;
                    break;
                }
                case Mod_Research_Base.NOENOUGHINGOT:
                {
                    _loc_2 = ResearchViewLang.NoEnoughIngot;
                    break;
                }
                default:
                {
                    _loc_2 = ResearchViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
