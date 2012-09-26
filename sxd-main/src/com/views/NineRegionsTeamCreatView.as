package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class NineRegionsTeamCreatView extends Base implements IView
    {
        public var targetUi:IMcNineRegionsTeamCreatMain;
        private var _jieId:int = 0;
        private var _chooseJie:int = 0;
        private var _chooseLv:int = 0;

        public function NineRegionsTeamCreatView()
        {
            return;
        }// end function

        public function set jieId(param1:int) : void
        {
            this._jieId = param1;
            return;
        }// end function

        public function show() : void
        {
            _data.call(Mod_NineRegions_Base.open_team_panel, this.getTeamInfoBack, [this._jieId]);
            return;
        }// end function

        public function close() : void
        {
            _data.cancelPatch(Mod_NineRegions_Base.notify_new_team);
            _data.cancelPatch(Mod_NineRegions_Base.notify_drop_team);
            _data.cancelPatch(Mod_NineRegions_Base.notify_update_member_number);
            _data.cancelPatch(Mod_NineRegions_Base.notify);
            _data.call(Mod_NineRegions_Base.close_team_panel, new Function(), []);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function getTeamInfoBack() : void
        {
            loadAssets("McNineRegionsTeamCreat", null, NineRegionsTeamCreatViewLang.LoadingInfo, false, false, this.loadComplete);
            return;
        }// end function

        private function loadComplete() : void
        {
            _data.patch(Mod_NineRegions_Base.notify_new_team, this.newTeamCreat);
            _data.patch(Mod_NineRegions_Base.notify_drop_team, this.delTeam);
            _data.patch(Mod_NineRegions_Base.notify_update_member_number, this.updateMemberNumber);
            _data.patch(Mod_NineRegions_Base.notify, this.notifyFun);
            if (!this.targetUi)
            {
                this.targetUi = _view.getAssetsObject("McNineRegionsTeamCreat", "McTeamCreatMain") as IMcNineRegionsTeamCreatMain;
                this.targetUi.onCloseWindow = this.onCloseWindow;
                this.targetUi.onAddTeam = this.onAddTeam;
                this.targetUi.onCreatTeam = this.onCreatTeam;
                _view.drag.iDrag.addTarget(this.targetUi.dragTitleBar, this.targetUi.content);
            }
            if (!inStage)
            {
                _popup.addView(this, this.targetUi.content);
                _view.center(sign, this.targetUi.content);
            }
            if (this._jieId < _ctrl.nineRegions.curJie)
            {
                this.targetUi.setMyJieLv(this._jieId, 3);
            }
            else if (this._jieId > _ctrl.nineRegions.curJie)
            {
                this.targetUi.setMyJieLv(this._jieId, 0);
            }
            else
            {
                this.targetUi.setMyJieLv(this._jieId, _ctrl.nineRegions.curLevel);
            }
            this.targetUi.initTeamList(_ctrl.nineRegions.teamList);
            return;
        }// end function

        private function notifyFun() : void
        {
            return;
        }// end function

        private function newTeamCreat() : void
        {
            this.targetUi.addTeam(_ctrl.nineRegions.newTeam);
            return;
        }// end function

        private function delTeam() : void
        {
            this.targetUi.clearTeamById(_ctrl.nineRegions.delTeamId);
            return;
        }// end function

        private function updateMemberNumber() : void
        {
            this.targetUi.updateMember(_ctrl.nineRegions.changeMemberObj.teamId, _ctrl.nineRegions.changeMemberObj.memberNum);
            return;
        }// end function

        private function onCloseWindow() : void
        {
            _popup.closeView(this);
            this.close();
            return;
        }// end function

        public function onAddTeam(param1:Object) : void
        {
            if (_ctrl.nineRegions.isCanJoin(param1.jieId, param1.lvId))
            {
                this._chooseJie = param1.jieId;
                this._chooseLv = param1.lvId;
                _data.call(Mod_NineRegions_Base.join_region_team, this.joinTeamBack, [param1.teamId]);
            }
            else
            {
                _view.showTip(NineRegionsMapViewLang.ERROR_REGION);
            }
            return;
        }// end function

        public function joinTeamBack() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (_ctrl.nineRegions.result == Mod_NineRegions_Base.SUCCESS)
            {
                _loc_1 = NineRegionsType.getMonsterId(this._chooseJie, this._chooseLv);
                _loc_2 = TownType.getId(TownType.JiuKongWuJie);
                _view.nineRegionsMap.gotoBossTown(_loc_2, _loc_1, this._chooseJie, this._chooseLv);
                this.onCloseWindow();
            }
            else if (_ctrl.nineRegions.result == Mod_NineRegions_Base.INVALID_TEAM_ID)
            {
                _view.showTip(NineRegionsMapViewLang.INVALID_TEAM_ID);
            }
            else if (_ctrl.nineRegions.result == Mod_NineRegions_Base.FULL_MEMBER)
            {
                _view.showTip(NineRegionsMapViewLang.FULL_MEMBER);
            }
            else if (_ctrl.nineRegions.result == Mod_NineRegions_Base.ERROR_REGION)
            {
                _view.showTip(NineRegionsMapViewLang.ERROR_REGION);
            }
            return;
        }// end function

        public function onCreatTeam(param1:int, param2:int) : void
        {
            this._chooseJie = param1;
            this._chooseLv = param2;
            _data.call(Mod_NineRegions_Base.create_region_team, this.creatTeamBack, [param1, param2]);
            return;
        }// end function

        private function creatTeamBack() : void
        {
            var _loc_1:* = NineRegionsType.getMonsterId(this._chooseJie, this._chooseLv);
            var _loc_2:* = TownType.getId(TownType.JiuKongWuJie);
            _view.nineRegionsMap.gotoBossTown(_loc_2, _loc_1, this._chooseJie, this._chooseLv);
            this.onCloseWindow();
            return;
        }// end function

    }
}
