package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.lang.client.com.views.processTips.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class ProcessTipsView extends Base implements IView
    {
        private var _tipsUrl:String;
        private var _tip:IProcessTips;
        private var _cacheList:Object;
        private var _timeOut:int = 0;
        private var _file:File;
        private var _loading:Boolean = false;
        private var _tempData:Object;
        private var _visible:Boolean = true;

        public function ProcessTipsView()
        {
            this._tipsUrl = URI.processTips;
            this._cacheList = {};
            return;
        }// end function

        public function open(param1:int, param2:Object = null) : void
        {
            if (this._cacheList[param1])
            {
                return;
            }
            var _loc_3:* = this.getTopPrior();
            var _loc_4:* = param2 || ProcessTipsType.getTip(param1);
            param2 = param2 || ProcessTipsType.getTip(param1);
            this._cacheList[param1] = _loc_4;
            if (param2["prior"] < _loc_3["prior"] || _loc_3["prior"] == 0)
            {
                this.loadAllResource(param2);
            }
            return;
        }// end function

        public function removeType(param1:int) : void
        {
            if (this._tempData && this._tempData["type"] == param1)
            {
                this.closeType(param1);
            }
            else
            {
                delete this._cacheList[param1];
            }
            return;
        }// end function

        private function nextTip() : void
        {
            var _loc_2:Object = null;
            var _loc_3:Function = null;
            var _loc_1:* = this.getTopPrior();
            if (_loc_1["type"] > 0)
            {
                _loc_2 = this._cacheList[_loc_1["type"]];
                _loc_3 = _loc_2["icon"] is String ? (this.loadAllResource) : (this.render);
                this._timeOut = setTimeout(_loc_3, 10000, _loc_2);
            }
            return;
        }// end function

        private function getTopPrior() : Object
        {
            var _loc_3:Object = null;
            var _loc_4:Number = NaN;
            var _loc_1:int = 0;
            var _loc_2:Number = 0;
            for (_loc_3 in this._cacheList)
            {
                
                _loc_4 = this._cacheList[_loc_3]["prior"];
                if (_loc_2 == 0)
                {
                    _loc_1 = _loc_3 as int;
                    _loc_2 = _loc_4;
                    continue;
                }
                if (_loc_2 > _loc_4)
                {
                    _loc_1 = _loc_3 as int;
                    _loc_2 = _loc_4;
                }
            }
            return {type:_loc_1, prior:_loc_2};
        }// end function

        public function test() : void
        {
            this.open(ProcessTipsType.Equipment);
            this.open(ProcessTipsType.Gift);
            this.open(ProcessTipsType.LuckyShop);
            this.open(ProcessTipsType.Practice);
            this.open(ProcessTipsType.Partners);
            this.open(ProcessTipsType.PartnersCount);
            var handler:* = function (event:MouseEvent) : void
            {
                return;
            }// end function
            ;
            _view.stage.addEventListener(MouseEvent.CLICK, handler);
            return;
        }// end function

        private function loadAllResource(param1:Object) : void
        {
            var tipData:* = param1;
            if (this._file == null)
            {
                this._file = new File();
                this._file.onComplete = function () : void
            {
                _tip = _file.getClassObject("ProcessTips") as IProcessTips;
                _tip.oParent = _popup;
                _tip.onAction = onActionHandler;
                _tip.onClose = closeType;
                loadResource(tipData);
                return;
            }// end function
            ;
                this._file.load(_view.getAssetsUrl("ProcessTips"));
            }
            else if (this._tip != null)
            {
                this.loadResource(tipData);
            }
            return;
        }// end function

        private function loadResource(param1:Object) : void
        {
            var file:File;
            var url:String;
            var tipData:* = param1;
            if (this._loading == true)
            {
                return;
            }
            this._loading = true;
            clearTimeout(this._timeOut);
            if (tipData["icon"] is String == false)
            {
                this.nextTip();
                return;
            }
            file = new File();
            url = tipData["iconUrl"] || this._tipsUrl + tipData["icon"];
            file.onComplete = function () : void
            {
                _loading = false;
                loaded(file.loader.content, tipData);
                return;
            }// end function
            ;
            file.onError = function () : void
            {
                _view.alert.confirm("[ProcessTips] : " + tipData["type"] + ":" + url.replace(/^[\s\S]+\/""^[\s\S]+\//, ""));
                return;
            }// end function
            ;
            file.load(url);
            return;
        }// end function

        private function loaded(param1:DisplayObject, param2:Object) : void
        {
            var _loc_3:* = this.getTopPrior();
            if (param2["prior"] > _loc_3["prior"])
            {
                this.loadAllResource(this._cacheList[_loc_3["type"]]);
            }
            else
            {
                param2["icon"] = param1;
                this.render(param2);
            }
            return;
        }// end function

        private function render(param1:Object) : void
        {
            this._tempData = param1;
            this.checkVisible();
            this.reposition(false);
            this._tip.render(param1);
            return;
        }// end function

        private function onActionHandler(param1:Object) : void
        {
            delete this._cacheList[param1["type"]];
            switch(param1["type"])
            {
                case ProcessTipsType.Deplay:
                {
                    break;
                }
                case ProcessTipsType.Equipment:
                {
                    break;
                }
                case ProcessTipsType.Gift:
                {
                    _view.pack.show();
                    break;
                }
                case ProcessTipsType.Partners:
                {
                    this.gotoPartnersNPC();
                    break;
                }
                case ProcessTipsType.PartnersCount:
                {
                    this.gotoPartnersNPC();
                    break;
                }
                case ProcessTipsType.Research:
                {
                    this.showResearchUI();
                    break;
                }
                case ProcessTipsType.Practice:
                {
                    _view.toolbar.startPractice();
                    break;
                }
                case ProcessTipsType.CoinsInsufficient:
                {
                    this.showRuneUI();
                    break;
                }
                case ProcessTipsType.LuckyShop:
                {
                    this.gotoLuckyShopNPC();
                    break;
                }
                case ProcessTipsType.SuperDeploy:
                {
                    this.showSuperDeployUI();
                    break;
                }
                case ProcessTipsType.StudyStunt:
                {
                    this.showStudyStuntUI();
                    break;
                }
                case ProcessTipsType.TianDiYuPai:
                {
                    this.gotoNPCLuWu();
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.nextTip();
            return;
        }// end function

        private function closeType(param1:int) : void
        {
            delete this._cacheList[param1];
            this.nextTip();
            return;
        }// end function

        public function show() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._tip && this._tip.content.parent;
        }// end function

        private function gotoLuckyShopNPC() : void
        {
            this._view.quest.gotoNPCByFunc(NPCType.LuckyShopNPC);
            return;
        }// end function

        private function gotoPartnersNPC() : void
        {
            this._view.quest.gotoNPCByFunc(NPCType.PartnersNPC);
            return;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            this._visible = param1;
            param1 = this._visible && _view.townMap.inStage;
            if (this._tip != null)
            {
                this._tip.visible = param1;
            }
            return;
        }// end function

        public function checkVisible() : void
        {
            this.visible = this._visible;
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else if (this._tip != null)
            {
                this._tip.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function checkOpenGift() : void
        {
            var _loc_1:int = 0;
            var _loc_2:Object = null;
            if (this._ctrl.player.giftItemId != 0)
            {
                _loc_1 = ProcessTipsType.Gift;
                _loc_2 = ProcessTipsType.getTip(_loc_1);
                _loc_2.content = ItemType.getName(this._ctrl.player.giftItemId) + ProcessTipsViewLang.IsOpen;
                this.open(_loc_1, _loc_2);
            }
            return;
        }// end function

        public function openGiftTip() : void
        {
            var _loc_1:* = ProcessTipsType.Gift;
            var _loc_2:* = ProcessTipsType.getTip(_loc_1);
            this.open(_loc_1, _loc_2);
            return;
        }// end function

        public function openResearch() : void
        {
            var _loc_1:* = this._ctrl.notify.getNewResearch();
            var _loc_2:* = _loc_1[0] as Object;
            var _loc_3:* = ProcessTipsType.Research;
            var _loc_4:* = ProcessTipsType.getTip(_loc_3);
            ProcessTipsType.getTip(_loc_3)["iconUrl"] = URI.processTips + _loc_2["id"] + ".swf";
            _loc_4["content"] = Lang.sprintf(researchLang.OpenResearch, _loc_2["name"]);
            this.open(_loc_3, _loc_4);
            return;
        }// end function

        private function showResearchUI() : void
        {
            if (!_popup.hasView(this._view.research))
            {
                _view.research.switchSelf();
            }
            return;
        }// end function

        public function openPartnersCount() : void
        {
            var _loc_1:* = this._ctrl.notify.getRoleCount();
            if (_loc_1 <= 5)
            {
                return;
            }
            var _loc_2:* = ProcessTipsType.PartnersCount;
            var _loc_3:* = ProcessTipsType.getTip(_loc_2);
            _loc_3["content"] = Lang.sprintf(partnersLang.UpperLimit, this._ctrl.player.level, _loc_1);
            this.open(_loc_2, _loc_3);
            return;
        }// end function

        public function openPartners() : void
        {
            var _loc_1:* = this._ctrl.notify.getNewPartnersId();
            if (_loc_1 == RoleType.getRoleId(RoleType.ZhangMaZi) || _loc_1 == RoleType.getRoleId(RoleType.ChuChu))
            {
                return;
            }
            var _loc_2:* = ProcessTipsType.Partners;
            var _loc_3:* = ProcessTipsType.getTip(_loc_2);
            _loc_3["iconUrl"] = URI.processTips + RoleType.getRoleSign(_loc_1) + ".swf";
            this.open(_loc_2, _loc_3);
            return;
        }// end function

        public function openPracticeTip() : void
        {
            var _loc_1:* = ProcessTipsType.Practice;
            var _loc_2:* = ProcessTipsType.getTip(_loc_1);
            this.open(_loc_1, _loc_2);
            return;
        }// end function

        public function openCoinsInsufficient() : void
        {
            this.open(ProcessTipsType.CoinsInsufficient);
            return;
        }// end function

        private function showRuneUI() : void
        {
            this._view.rune.show();
            return;
        }// end function

        public function openSuperDeploy() : void
        {
            var _loc_1:* = ProcessTipsType.SuperDeploy;
            var _loc_2:* = ProcessTipsType.getTip(_loc_1);
            this.open(_loc_1, _loc_2);
            return;
        }// end function

        private function showSuperDeployUI() : void
        {
            if (!this._view.superDeploy.inStage)
            {
                this._view.superDeploy.switchSelf();
            }
            return;
        }// end function

        public function openStudyStunt() : void
        {
            var _loc_1:* = ProcessTipsType.StudyStunt;
            var _loc_2:* = ProcessTipsType.getTip(_loc_1);
            this.open(_loc_1, _loc_2);
            return;
        }// end function

        private function showStudyStuntUI() : void
        {
            if (!_popup.hasView(this._view.studyStunt))
            {
                _view.studyStunt.switchSelf();
            }
            return;
        }// end function

        public function openTianDiYuPai() : void
        {
            var _loc_1:* = ProcessTipsType.TianDiYuPai;
            var _loc_2:* = ProcessTipsType.getTip(_loc_1);
            this.open(_loc_1, _loc_2);
            return;
        }// end function

        public function gotoNPCLuWu() : void
        {
            var _loc_1:* = TownType.getTownIdByLock(this._ctrl.player.townKey);
            var _loc_2:* = TownType.getTownNPCIdByFunc(_loc_1, NPCType.CardBuyNPC);
            this._view.townMap.bGuide = true;
            this._view.townMap.moveToNPCByTownIdAndNpcId(_loc_1, _loc_2);
            return;
        }// end function

    }
}
