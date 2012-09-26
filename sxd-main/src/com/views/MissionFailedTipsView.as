package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;

    public class MissionFailedTipsView extends Base implements IView
    {
        private var _tipsUrl:String;
        private var _tip:IMissionFailedTips;
        public var missionId:int;
        private var _list:Array;
        private var _infos:Array;
        private var _tipArray:Array;

        public function MissionFailedTipsView()
        {
            this._tipsUrl = URI.assetsUrl + "icons/mission_failed_tips/";
            return;
        }// end function

        public function showSport() : void
        {
            var _loc_1:Array = [5, 7, 8, 9, 12];
            this._tipArray = MissionFailedTipsType.renderTip(_loc_1);
            this.show();
            return;
        }// end function

        public function showTower(param1:int, param2:int) : void
        {
            var _loc_3:* = TowerFailedTipsType.getTipsList(param1, param2);
            this._tipArray = MissionFailedTipsType.renderTip(_loc_3);
            this.show();
            return;
        }// end function

        public function showPeach(param1:int) : void
        {
            var _loc_2:* = PeachFailedTipsType.getTipsList(param1);
            this._tipArray = MissionFailedTipsType.renderTip(_loc_2);
            this.show();
            return;
        }// end function

        public function showMission(param1:int) : void
        {
            this._tipArray = MissionFailedTipsType.getTipsByMissionId(param1);
            this.show();
            return;
        }// end function

        public function show() : void
        {
            var _loc_2:Object = null;
            if (this._tipArray.length == 0)
            {
                return;
            }
            this._list = [];
            this._infos = [];
            var _loc_1:int = 0;
            while (_loc_1 < this._tipArray.length)
            {
                
                this._list[_loc_1] = this._tipsUrl + this._tipArray[_loc_1][0] + ".swf";
                _loc_2 = {};
                _loc_2.sign = this._tipArray[_loc_1][0];
                _loc_2.info = this._tipArray[_loc_1][1];
                this._infos.push(_loc_2);
                _loc_1++;
            }
            this._list.unshift(_view.getAssetsUrl("MissionFailedTips"));
            this.loadResources(this._list);
            return;
        }// end function

        private function loadResources(param1:Array) : void
        {
            var list:* = param1;
            var error:* = function (param1:int) : void
            {
                _view.alert.confirm(Lang.sprintf(MissionFailedTipsViewLang.Lost, list[param1].replace(/^[\s\S]+\/""^[\s\S]+\//, "")));
                return;
            }// end function
            ;
            File.loadList(list, this.render, null, null, error);
            return;
        }// end function

        public function render(param1:Array) : void
        {
            var list:* = param1;
            if (inStage == true)
            {
                return;
            }
            this._tip = list[0].getClassObject("MissionFailedTips") as IMissionFailedTips;
            this._tip.onClose = this.close;
            this._tip.onFunctionOpen = function (param1:String) : void
            {
                openFunction(param1);
                return;
            }// end function
            ;
            _popup.addView(this, this._tip.content);
            var temp:Array;
            var len:* = list.length;
            var i:int;
            while (i < len)
            {
                
                temp.push((list[i] as File).loader.content);
                i = (i + 1);
            }
            this._tip.renderImages(temp, this._infos);
            this.reposition();
            return;
        }// end function

        private function openFunction(param1:String) : void
        {
            switch(param1)
            {
                case MissionFailedTipsType.QiangHua:
                {
                    _view.upgrade.switchSelf();
                    break;
                }
                case MissionFailedTipsType.MingGe:
                {
                    _view.lodge.switchSelf();
                    break;
                }
                case MissionFailedTipsType.PeiYang:
                {
                    _view.roleMsg.switchSelf();
                    break;
                }
                case MissionFailedTipsType.ZhenXing:
                {
                    _view.superDeploy.switchSelf();
                    break;
                }
                case MissionFailedTipsType.QiShu:
                {
                    _view.research.switchSelf();
                    break;
                }
                case MissionFailedTipsType.YaoYuan:
                {
                    _view.farm.switchSelf();
                    break;
                }
                case MissionFailedTipsType.XueXiJueJi:
                {
                    _view.studyStunt.switchSelf();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            this._tip.clear();
            return;
        }// end function

        public function close() : void
        {
            if (inStage == false)
            {
                return;
            }
            this.clear();
            _popup.closeView(this);
            this._list = null;
            this._infos = null;
            this._tip = null;
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._tip.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

    }
}
