package com.views
{
    import com.assist.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.utils.*;

    public class NewTopWarView extends Base implements IView
    {
        private var _target:INewTopWar;
        private var _openFlag:int = 0;
        private var _step:int = 0;
        private var _signState:int = 0;
        private var applyId:int;
        private var _opId:int;
        private var tmpObj:Object;
        private var _onWarTime:int = 0;

        public function NewTopWarView()
        {
            this.tmpObj = {id:0, name:""};
            return;
        }// end function

        public function show() : void
        {
            this.onOpenMyTeam();
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            _view.chat.resetDepth();
            this.clear();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadUi() : void
        {
            if (!this._target)
            {
                loadAssets("NewTopWarCreate", this.render, NewTopWarViewLang.Open);
            }
            else
            {
                this.render();
            }
            return;
        }// end function

        private function render() : void
        {
            if (!this._target)
            {
                this._target = _view.getAssetsObject("NewTopWarCreate", "McNewTopWarMain") as INewTopWar;
                this._target.onTip = this.onTip;
                this._target.onSeePlayerInfo = this.showPlayerInfoView;
                this._target.onSeeTeamInfo = this.onSeeTeamInfo;
                this._target.onCreat = this.onCreatTeam;
                this._target.onReg = this.onReg;
                this._target.onDeploy = this.onDeploy;
                this._target.onDeployChange = this.onDeployChange;
                this._target.onExitTeam = this.onExitTeam;
                this._target.onQuitTeam = this.onQuitTeam;
                this._target.onExamine = this.onExamine;
                this._target.onOpenRoleChange = this.onOpenRoleChange;
                this._target.onChangeRole = this.onChangeRole;
                this._target.onSkip = this.onSkip;
                this._target.onPass = this.onPass;
                this._target.onNotPass = this.onNotPass;
                this._target.onSelect = this.onOpenOther;
                this._target.onApply = this.onApply;
                this._target.onOtherTeam = this.onOpenOther;
                this._target.onMemberOut = this.onMemberOut;
                this._target.onMyTeam = this.onOpenMyTeam;
                this._target.onRegList = this.onRegList;
                this._target.onSeeMyWar = this.onSeeMyWar;
                this._target.onSeeWar = this.onSeeWar;
                this._target.onOpenTeamRank = this.onOpenTeamRank;
                this._target.onOpenTopThone = this.onOpenTopThone;
                this._target.onBody = _view.roleMsg.switchSelf;
                this._target.onPack = _view.pack.switchSelf;
                this._target.onUpgrade = _view.upgrade.switchSelf;
                this._target.onResearch = _view.research.switchSelf;
                this._target.onDeployMain = _view.superDeploy.switchSelf;
                this._target.onFate = _view.fate.switchSelf;
                this._target.onSealSoul = _view.sealSoul.switchSelf;
                this._target.onCloseWindow = this.close;
            }
            _popup.addView(this, this._target.content);
            _view.chat.updateDepth(this);
            if (this._openFlag == 0)
            {
                this._target.myTeamInfo = _ctrl.newTopWar.myTeamObj;
            }
            else if (this._openFlag == 1)
            {
                this._target.haveTeam = _ctrl.newTopWar.myTeamObj.teamId != 0;
                this._target.teamCreatObj = _ctrl.newTopWar.otherTeamObj;
            }
            this._target.stepState(this._step, this._signState);
            this.reposition();
            return;
        }// end function

        private function get isRaceBegin() : Boolean
        {
            if (this._signState == 2 || this._step == Mod_NewTopWar_Base.SIGN_CLOSE || this._step == Mod_NewTopWar_Base.TAOTAI || this._step == Mod_NewTopWar_Base.TAOTAI_END || this._step == Mod_NewTopWar_Base.WORLD_1 || this._step == Mod_NewTopWar_Base.WORLD_1_END || this._step == Mod_NewTopWar_Base.WORLD_2 || this._step == Mod_NewTopWar_Base.WORLD_2_END || this._step == Mod_NewTopWar_Base.WORLD_3 || this._step == Mod_NewTopWar_Base.WORLD_3_END || this._step == Mod_NewTopWar_Base.WORLD_4 || this._step == Mod_NewTopWar_Base.WORLD_4_END)
            {
                _view.showTip(NewTopWarViewLang.InRace);
                return true;
            }
            return false;
        }// end function

        public function onCreatTeam(param1:String) : void
        {
            if (this.isRaceBegin)
            {
                return;
            }
            if (param1 == "")
            {
                _view.showTip(NewTopWarViewLang.TeamNameCannotNull);
                return;
            }
            _data.call(Mod_NewTopWar_Base.create_team, this.onCreatTeamBack, [param1]);
            return;
        }// end function

        private function onCreatTeamBack() : void
        {
            switch(_ctrl.newTopWar.result)
            {
                case Mod_NewTopWar_Base.SUCCESS:
                {
                    this._target.creatResult = true;
                    this.onOpenMyTeam();
                    _data.call(Mod_NewTopWar_Base.get_top_war_step, this.stepState, []);
                    break;
                }
                case Mod_NewTopWar_Base.REQUIRE_LEVEL:
                {
                    _view.showTip(NewTopWarViewLang.NotEnoughLevel);
                    break;
                }
                case Mod_NewTopWar_Base.TEAM_NAME_INVALID:
                {
                    _view.showTip(NewTopWarViewLang.TeamNameErr);
                    break;
                }
                case Mod_NewTopWar_Base.TEAM_NAME_EXISTED:
                {
                    this._target.creatResult = false;
                    break;
                }
                case Mod_NewTopWar_Base.NOT_ENOUGTH_COIN:
                {
                    _view.showTip(NewTopWarViewLang.NotEnoughCoin);
                    break;
                }
                case Mod_NewTopWar_Base.IN_OTHER_TEAM:
                {
                    _view.showTip(NewTopWarViewLang.InTeam);
                    break;
                }
                case Mod_NewTopWar_Base.NOT_OPEN:
                {
                    _view.showTip(NewTopWarViewLang.NotOpen);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function onOpenMyTeam() : void
        {
            _data.call(Mod_NewTopWar_Base.my_team_info, this.onOpenMyTeamBack, []);
            return;
        }// end function

        private function onOpenMyTeamBack() : void
        {
            if (_ctrl.newTopWar.myTeamObj.teamId == 0)
            {
                this.onOpenOther("", "", 1);
            }
            else
            {
                this._openFlag = 0;
                this.loadUi();
            }
            return;
        }// end function

        private function onApply(param1:Boolean, param2:int) : void
        {
            this.applyId = param2;
            if (param1)
            {
                _data.call(Mod_NewTopWar_Base.request, this.onApplyTrueBack, [param2]);
            }
            else
            {
                _data.call(Mod_NewTopWar_Base.cancel_request, this.onApplyFalseBack, [param2]);
            }
            return;
        }// end function

        private function onApplyTrueBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.SUCCESS)
            {
                this._target.setInApply(this.applyId, 1);
            }
            else if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.IN_OTHER_TEAM)
            {
                _view.showTip(NewTopWarViewLang.InTeam);
                this._target.setInApply(this.applyId, 0);
            }
            else if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.NOT_OPEN)
            {
                _view.showTip(NewTopWarViewLang.NotOpen);
            }
            else
            {
                this.onOpenOther("", "", _ctrl.newTopWar.otherTeamObj.curPage);
                _view.showTip(NewTopWarViewLang.TeamErr);
            }
            return;
        }// end function

        private function onApplyFalseBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.SUCCESS)
            {
                this._target.setInApply(this.applyId, 0);
            }
            else if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.REQUEST_NOT_EXISTED)
            {
                _view.showTip(NewTopWarViewLang.ShenQingBuCunZai);
                this.onOpenOther("", "", _ctrl.newTopWar.otherTeamObj.curPage);
            }
            return;
        }// end function

        public function onOpenOther(param1:String, param2:String, param3:int) : void
        {
            _data.call(Mod_NewTopWar_Base.team_list, this.onOpenOtherBack, [param1, param2, param3]);
            return;
        }// end function

        private function onOpenOtherBack() : void
        {
            if (_ctrl.newTopWar.searchTeamName != "")
            {
                _view.showTip(NewTopWarViewLang.NotThisTeam);
            }
            this._openFlag = 1;
            this.loadUi();
            return;
        }// end function

        private function onOpenTopThone() : void
        {
            this.close();
            _view.topThrone.show();
            return;
        }// end function

        private function onReg() : void
        {
            if (_ctrl.newTopWar.myTeamObj.memberList.length == 3)
            {
                _data.call(Mod_NewTopWar_Base.sign, this.onRegBack, []);
            }
            else
            {
                _view.showTip(NewTopWarViewLang.RenShuBuZu);
            }
            return;
        }// end function

        private function onRegBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.SUCCESS)
            {
                this._signState = 2;
                this._target.stepState(this._step, this._signState);
                _view.showTip(NewTopWarViewLang.BaoMingChengGong, null, TipType.Success);
            }
            return;
        }// end function

        private function onDeploy() : void
        {
            if (_ctrl.newTopWar.myTeamObj.memberList.length == 3)
            {
                _data.call(Mod_NewTopWar_Base.deploy_list, this.onDeployBack, []);
            }
            else
            {
                _view.showTip(NewTopWarViewLang.RenShuBuZu);
            }
            return;
        }// end function

        private function onDeployBack() : void
        {
            this._target.setDeployList(_ctrl.newTopWar.deployList, _ctrl.newTopWar.firstAttack);
            return;
        }// end function

        private function onDeployChange(param1:int, param2:int) : void
        {
            _data.call(Mod_NewTopWar_Base.change_position, this.onDeployChangeBack, [param1, param2]);
            return;
        }// end function

        private function onDeployChangeBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.FAILED)
            {
                this.onDeploy();
            }
            return;
        }// end function

        private function onExitTeam() : void
        {
            if (this.isRaceBegin)
            {
                return;
            }
            _view.alert.iAlert.hasCheckbox = false;
            _view.alert.showYesNoMsg(NewTopWarViewLang.QueDingJieSanDuiWu, NewTopWarViewLang.Yes, NewTopWarViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    _data.call(Mod_NewTopWar_Base.disband_team, onExitTeamBack, []);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function onExitTeamBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.SUCCESS)
            {
                _ctrl.newTopWar.myTeamObj.teamId = 0;
                this.onOpenOther("", "", 1);
            }
            else if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.NOT_OPEN)
            {
                _view.showTip(NewTopWarViewLang.NotOpen);
            }
            return;
        }// end function

        private function onQuitTeam() : void
        {
            if (this.isRaceBegin)
            {
                return;
            }
            _view.alert.iAlert.hasCheckbox = false;
            _view.alert.showYesNoMsg(NewTopWarViewLang.QueDingTuiChuDuiWu, NewTopWarViewLang.Yes, NewTopWarViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    _data.call(Mod_NewTopWar_Base.quit_team, onQuitTeamBack, []);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function onQuitTeamBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.SUCCESS)
            {
                _ctrl.newTopWar.myTeamObj.teamId = 0;
                this.onOpenOther("", "", 1);
            }
            else if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.TEAM_IS_SIGN)
            {
                _view.showTip(NewTopWarViewLang.DuiWuYiBaoMing);
            }
            return;
        }// end function

        private function onExamine() : void
        {
            if (this.isRaceBegin)
            {
                return;
            }
            _data.call(Mod_NewTopWar_Base.request_list, this.onExamineBack, []);
            return;
        }// end function

        private function onExamineBack() : void
        {
            this._target.examineList = _ctrl.newTopWar.requestList;
            return;
        }// end function

        private function onSkip() : void
        {
            _data.call(Mod_NewTopWar_Base.batch_deny_request, this.onSkipBack, []);
            return;
        }// end function

        private function onSkipBack() : void
        {
            this._target.clearItemById(0);
            return;
        }// end function

        private function onPass(param1:int) : void
        {
            this._opId = param1;
            _data.call(Mod_NewTopWar_Base.accept_request, this.onPassBack, [param1]);
            return;
        }// end function

        private function onPassBack() : void
        {
            switch(_ctrl.newTopWar.result)
            {
                case Mod_NewTopWar_Base.SUCCESS:
                {
                    this._target.clearItemById(this._opId);
                    this.onOpenMyTeam();
                    this._target.stepState(this._step, this._signState);
                    break;
                }
                case Mod_NewTopWar_Base.FULL_MEMBER:
                {
                    _view.showTip(NewTopWarViewLang.FullTeam);
                    break;
                }
                case Mod_NewTopWar_Base.NOT_OPEN:
                {
                    _view.showTip(NewTopWarViewLang.NotOpen);
                    break;
                }
                case Mod_NewTopWar_Base.REQUEST_NOT_EXISTED:
                {
                    _view.showTip(NewTopWarViewLang.ShenQingBuCunZai);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onNotPass(param1:int) : void
        {
            this._opId = param1;
            _data.call(Mod_NewTopWar_Base.deny_request, this.onNotPassBack, [param1]);
            return;
        }// end function

        private function onNotPassBack() : void
        {
            this._target.clearItemById(this._opId);
            return;
        }// end function

        private function onMemberOut(param1:int) : void
        {
            _data.call(Mod_NewTopWar_Base.kickout_member, this.onMemberOutBack, [param1]);
            return;
        }// end function

        private function onMemberOutBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.SUCCESS || _ctrl.newTopWar.result == Mod_NewTopWar_Base.MEMBER_NOT_EXISTED)
            {
                this.onOpenMyTeam();
            }
            else if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.NOT_OPEN)
            {
                _view.showTip(NewTopWarViewLang.NotOpen);
            }
            else if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.TEAM_IS_SIGN)
            {
                _view.showTip(NewTopWarViewLang.DuiWuYiBaoMing);
            }
            return;
        }// end function

        private function onOpenRoleChange() : void
        {
            _data.call(Mod_NewTopWar_Base.helper_role_list, this.onOpenRoleChangeBack, []);
            return;
        }// end function

        private function onOpenRoleChangeBack() : void
        {
            if (_ctrl.newTopWar.myRoleList.length == 0)
            {
                _view.showTip(NewTopWarViewLang.NoRoleCanChoose);
                return;
            }
            this._target.roleList = _ctrl.newTopWar.myRoleList;
            return;
        }// end function

        private function onChangeRole(param1:int) : void
        {
            _data.call(Mod_NewTopWar_Base.choose_helper_role, this.onChangeRoleBack, [param1]);
            return;
        }// end function

        private function onChangeRoleBack() : void
        {
            if (_ctrl.newTopWar.result == Mod_NewTopWar_Base.SUCCESS)
            {
                this.onOpenMyTeam();
            }
            return;
        }// end function

        private function onRegList() : void
        {
            _data.call(Mod_NewTopWar_Base.sign_list, this.onRegListBack, []);
            return;
        }// end function

        private function onRegListBack() : void
        {
            this._target.regList = _ctrl.newTopWar.signList;
            return;
        }// end function

        private function onSeeTeamInfo(param1:int, param2:Object = null) : void
        {
            if (param2)
            {
                _view.otherTeamInfo.teamInfo = param2;
            }
            else
            {
                _view.otherTeamInfo.teamId = param1;
            }
            return;
        }// end function

        private function showPlayerInfoView(param1:int, param2:String) : void
        {
            var id:* = param1;
            var name:* = param2;
            this.tmpObj.id = id;
            this.tmpObj.name = name;
            if (id == _ctrl.player.playerId)
            {
                return;
            }
            setTimeout(function () : void
            {
                var _loc_1:Array = [NewTopWarViewLang.ShowInfo, NewTopWarViewLang.AddFriend, NewTopWarViewLang.SendFlower];
                var _loc_2:* = new ClickTipList(_loc_1, _loc_1, onTextClick);
                _view.tip.iTip.clickToOpen(_loc_2);
                return;
            }// end function
            , 100);
            return;
        }// end function

        private function onTextClick(param1:String) : void
        {
            switch(param1)
            {
                case NewTopWarViewLang.ShowInfo:
                {
                    _view.otherRoleMsg.init(this.tmpObj.id, this.tmpObj.name);
                    _view.otherRoleMsg.show();
                    break;
                }
                case NewTopWarViewLang.AddFriend:
                {
                    _view.friendList.addFriend(this.tmpObj.name);
                    break;
                }
                case NewTopWarViewLang.SendFlower:
                {
                    _view.sendFlower.sendPlayerID = this.tmpObj.id;
                    _view.sendFlower.show();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onSeeMyWar() : void
        {
            _data.call(Mod_NewTopWar_Base.local_war_report_list, this.onSeeMyWarBack, []);
            return;
        }// end function

        private function onSeeMyWarBack() : void
        {
            this._target.setWarRecordInfo(_ctrl.newTopWar.warList);
            return;
        }// end function

        private function onSeeWar(param1:int, param2:String, param3:Boolean) : void
        {
            if (this._onWarTime > getTimer())
            {
                return;
            }
            this._onWarTime = getTimer() + 2000;
            _view.chat.changePoint = 0;
            _view.chat.resetDepth();
            _view.strategyWar.isServerWar = !param3;
            _view.strategyWar.sameServer = param3;
            _view.strategyWar.warType = WarType.TopWarWar;
            _view.strategyWar.version = param2;
            _view.strategyWar.reportId = param1;
            _view.strategyWar.onClose = this.onWarClose;
            _view.strategyWar.show();
            return;
        }// end function

        private function onWarClose() : void
        {
            return;
        }// end function

        private function onSeeWarBack() : void
        {
            return;
        }// end function

        public function onOpenTeamRank() : void
        {
            _data.call(Mod_NewTopWar_Base.rank_list, this.onOpenTeamRankBack, []);
            return;
        }// end function

        private function onOpenTeamRankBack() : void
        {
            this._target.teamRankList = _ctrl.newTopWar.rankList;
            return;
        }// end function

        public function stepState() : void
        {
            this._step = _ctrl.newTopWar.topWarStep;
            this._signState = _ctrl.newTopWar.signState;
            if (this._target)
            {
                this._target.stepState(this._step, this._signState);
            }
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

        public function reposition() : void
        {
            if (!inStage || !this._target)
            {
                return;
            }
            var _loc_1:* = Math.max(800, Math.min(Structure.maxStageWidth, this._target.content.stage.stageWidth));
            var _loc_2:* = Math.max(400, Math.min(Structure.maxStageHeight, this._target.content.stage.stageHeight));
            var _loc_3:* = _loc_2 - 650;
            var _loc_4:* = _loc_1 - 1250;
            this._target.content.y = _loc_3;
            this._target.content.x = _loc_4;
            return;
        }// end function

    }
}
