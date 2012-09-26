package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class MultiWarView extends WarView implements IView
    {

        public function MultiWarView() : void
        {
            _type = WarType.MultiWar;
            return;
        }// end function

        override public function show() : void
        {
            if (_view.campWar.inStageWithTip)
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
            isLastMonster = false;
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(MultiWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            this.loadData();
            return;
        }// end function

        override protected function loadData() : void
        {
            opened = true;
            _data.call(Mod_MultipleMission_Base.get_war_result, this.loadResources, []);
            return;
        }// end function

        override protected function loadResources() : void
        {
            var lr:LoadResponder;
            if (_view.hasResource("MultiWar"))
            {
                this.loadRoleResource();
            }
            else
            {
                lr = new LoadResponder(this.loadRoleResource, function (param1:String, param2:int) : void
            {
                _view.showLoading(MultiWarViewLang.LoadInfo, param2);
                return;
            }// end function
            );
                _view.loadResources(["MultiWar"], lr);
            }
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            super.loadRoleResource();
            return;
        }// end function

        override protected function extractRoleData() : Array
        {
            var _loc_1:Array = [];
            var _loc_2:Array = [];
            var _loc_3:* = _ctrl.multiMission.multiWarData;
            var _loc_4:* = this.getOriginSigns(_loc_1, _loc_2, _loc_3.attackerInfo, false);
            var _loc_5:* = this.getOriginSigns(_loc_1, _loc_2, _loc_3.defenderInfo, true);
            extractStuntData(_loc_1, _loc_2, _loc_4, false);
            extractStuntData(_loc_1, _loc_2, _loc_5, true);
            addonRole(_loc_1, _loc_2);
            var _loc_6:* = _ctrl.multiMission.multiWarData.multipleMissionId;
            var _loc_7:* = URI.mapUrl + "multi_mission/";
            _loc_1.push("WarIcon");
            _loc_2.push(_loc_7 + _loc_6 + ".png");
            _loc_1.push("Background");
            _loc_2.push(_loc_7 + _loc_6 + ".swf");
            return [_loc_1, _loc_2];
        }// end function

        protected function getOriginSigns(param1:Array, param2:Array, param3:Array, param4:Boolean) : Array
        {
            var _loc_7:Object = null;
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_10:Object = null;
            var _loc_11:String = null;
            var _loc_12:String = null;
            var _loc_5:Array = [];
            var _loc_6:int = 0;
            while (_loc_6 < param3.length)
            {
                
                _loc_7 = param3[_loc_6]["roleList"];
                _loc_8 = param3[_loc_6]["mainRoleSign"];
                _loc_9 = param3[_loc_6]["mainRoleSuffix"];
                for each (_loc_10 in _loc_7)
                {
                    
                    _loc_11 = _loc_10["sign"];
                    _loc_12 = param4 ? (MonsterType.sameResource(_loc_11)) : (_loc_11);
                    if (param1.indexOf(_loc_12) == -1)
                    {
                        if (_loc_12 == _loc_8)
                        {
                            _loc_12 = _loc_12 + _loc_9;
                        }
                        _loc_12 = _loc_12 + WarType.getMiniSuffix(_type);
                        if (param1.indexOf(_loc_12) == -1)
                        {
                            param1.push(_loc_12);
                            param2.push(URI.warRolesUrl + _loc_12 + ".swf");
                        }
                    }
                    if (_loc_5.indexOf(_loc_11) == -1)
                    {
                        _loc_5.push(_loc_11);
                    }
                }
                _loc_6++;
            }
            return _loc_5;
        }// end function

        override protected function render() : void
        {
            super.render();
            _view.hideLoading();
            return;
        }// end function

        override protected function createTarget() : void
        {
            _war = _view.getAssetsObject("MultiWar", "MultiWar") as IMultiWar;
            (_war as IMultiWar).multiWarData = _ctrl.multiMission.multiWarData;
            return;
        }// end function

        override protected function onCloseHandler(param1:Boolean) : void
        {
            var _loc_2:int = 0;
            var _loc_3:MultiWarData = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            var _loc_7:String = null;
            if (WarType.MultiWar == _type)
            {
                _loc_2 = _ctrl.multiMission.multiWarData.multipleTeamId;
                _data.call(Mod_MultipleMission_Base.leave_multiple_mission_war, new Function(), [_loc_2]);
                _loc_3 = _ctrl.multiMission.multiWarData;
                _loc_4 = _loc_3.awardItems.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = _loc_3.awardItems[_loc_5];
                    _loc_7 = Lang.sprintf(MultiWarViewLang.Get, _loc_6.name, _loc_6.count);
                    _view.chat.addSystemMessage(_loc_7);
                    _loc_5++;
                }
            }
            clearRoles();
            super.onCloseHandler(param1);
            return;
        }// end function

        override protected function loadStudyStunt(param1:Function) : void
        {
            var _loc_6:String = null;
            this.param1();
            return;
            loadStudyStuntResources(_loc_4, _loc_3, param1);
            return;
        }// end function

        override public function reposition(param1:Boolean = true) : void
        {
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                super.reposition(false);
            }
            return;
        }// end function

    }
}
