package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.assist.view.info.*;
    import com.protocols.*;
    import flash.display.*;

    public class DreamSectionView extends Base implements IView
    {
        private var _dreamSection:IDreamSection;
        private var _bMsgPassing:Boolean;

        public function DreamSectionView()
        {
            return;
        }// end function

        public function show() : void
        {
            _data.call(Mod_DreamSection_Base.get_player_dream_section_info, this.getImmortalDreamInfoBack, []);
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function getImmortalDreamInfoBack() : void
        {
            loadAssets("DreamSection", null, DreamSectionInfoLang.DreamSectionLoading, false, false, this.loadComplete);
            return;
        }// end function

        private function loadComplete() : void
        {
            this._bMsgPassing = false;
            if (!this._dreamSection)
            {
                this._dreamSection = _view.getAssetsObject("DreamSection", "DreamSection") as IDreamSection;
                this._dreamSection.onWar = this.onWar;
                this._dreamSection.onClose = this.onClose;
                this._dreamSection.onChangeEnding = this.onChangeEnding;
                this._dreamSection.onRecruitmentRole = this.onRecruitmentRole;
                this._dreamSection.onTip = this.onTip;
                _view.drag.iDrag.addTarget(this._dreamSection.dragTitleBar, this._dreamSection.content);
            }
            this._dreamSection.setInfo(_ctrl.dreamSection.dreamSectionInfo);
            if (!inStage)
            {
                _popup.addView(this, this._dreamSection.content);
                _view.center(sign, this._dreamSection.content);
            }
            return;
        }// end function

        private function onWar(param1:int, param2:int) : void
        {
            _view.dreamSectionWar.opened = true;
            this._bMsgPassing = true;
            _ctrl.dreamSection.dreamSectionInfo.requestRoleId = param1;
            _data.call(Mod_DreamSection_Base.challenge_section, this.headPlotStart, [param1, param2]);
            return;
        }// end function

        private function headPlotStart() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Object = null;
            _loc_1 = _ctrl.dreamSection.requestRoleObj;
            _loc_2 = _ctrl.dreamSection.requestGuanObj;
            if (_loc_1.is_challenged == 0)
            {
                _view.drama.init(_loc_2.dreamId1, _loc_2.dreamName1);
                _view.drama.playdrama(_loc_2.dreamId1, this.headPlotOver, false);
                _loc_1.is_challenged = 1;
            }
            else
            {
                this.headPlotOver();
            }
            this._bMsgPassing = false;
            return;
        }// end function

        private function headPlotOver() : void
        {
            _view.dreamSectionWar.warData = _ctrl.dreamSection.warData;
            _view.dreamSectionWar.aura = _ctrl.dreamSection.aura;
            _view.dreamSectionWar.onClose = function (param1:Boolean) : void
            {
                _ctrl.dreamSection.bWin = param1;
                endPlotStart(param1);
                return;
            }// end function
            ;
            _view.dreamSectionWar.show();
            return;
        }// end function

        private function endPlotStart(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            if (!param1)
            {
                return;
            }
            _loc_2 = _ctrl.dreamSection.requestRoleObj;
            _loc_3 = _ctrl.dreamSection.requestGuanObj;
            _view.drama.init(_loc_3.dreamId2, _loc_3.dreamName2);
            _view.drama.playdrama(_loc_3.dreamId2, this.endPlotOver, false);
            return;
        }// end function

        private function endPlotOver() : void
        {
            var _loc_1:Object = null;
            if (_ctrl.dreamSection.bWin)
            {
                _loc_1 = _ctrl.dreamSection.requestRoleObj;
                if (_loc_1.lock != _ctrl.dreamSection.nextLock)
                {
                    _loc_1.is_challenged = 0;
                }
                _loc_1.lock = _ctrl.dreamSection.nextLock;
                this._dreamSection.setInfo(_ctrl.dreamSection.dreamSectionInfo);
            }
            return;
        }// end function

        private function onChangeEnding(param1:int, param2:int) : void
        {
            this._bMsgPassing = true;
            _ctrl.dreamSection.dreamSectionInfo.requestRoleId = param1;
            _data.call(Mod_DreamSection_Base.challenge_section, this.headPlotStart, [param1, param2]);
            return;
        }// end function

        private function onRecruitmentRole(param1:int) : void
        {
            this._bMsgPassing = true;
            _ctrl.dreamSection.dreamSectionInfo.requestRoleId = param1;
            _data.call(Mod_DreamSection_Base.recruit_partner, this.onRecruitmentRoleOver, [param1]);
            return;
        }// end function

        private function onRecruitmentRoleOver() : void
        {
            var _loc_1:Object = null;
            var _loc_2:String = null;
            var _loc_3:int = 0;
            this._bMsgPassing = false;
            if (_ctrl.dreamSection.result == Mod_DreamSection_Base.SUCCESS)
            {
                _loc_1 = _ctrl.dreamSection.requestRoleObj;
                _loc_1.is_recruited = 1;
                _loc_2 = DreamSectionInfoLang.ShowContent;
                _loc_2 = Lang.sprintf(_loc_2, _loc_1.roleName);
                _view.showTip(DreamSectionInfoLang.SystemName, _loc_2, TipType.Success);
                _loc_3 = 0;
                while (_loc_3 < _ctrl.dreamSection.dreamSectionInfo.roleList.length)
                {
                    
                    if (_ctrl.dreamSection.dreamSectionInfo.roleList[_loc_3].is_recruited == 0)
                    {
                        this._dreamSection.recruitmentOver(_loc_1.roleId);
                        return;
                    }
                    _loc_3++;
                }
                _view.activities.removeActivity(FunctionType.DreamSection);
            }
            return;
        }// end function

        private function onClose() : void
        {
            _popup.closeView(this);
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

    }
}
