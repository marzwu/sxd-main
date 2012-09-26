package com.views
{
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class TopWarCreateView extends Base implements IView
    {
        private var _topWarCreate:ITopWarCreate;
        public var isOpenTopWar:Boolean;
        private var _teamId:int;
        private var _joinTeamId:int;
        private var _openType:int = 0;
        private var FastJoin:int = 50;

        public function TopWarCreateView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.tower.inStageWithTip)
            {
                return;
            }
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            if (!this.isOpenTopWar)
            {
                return;
            }
            this.open();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            _data.cancelPatch(Mod_TopWar_Base.notify_new_team);
            _data.cancelPatch(Mod_TopWar_Base.notify_drop_team);
            _data.cancelPatch(Mod_TopWar_Base.notify_update_team);
            this.closePanel();
            return;
        }// end function

        public function clear() : void
        {
            this._topWarCreate.clear();
            return;
        }// end function

        public function open() : void
        {
            _data.call(Mod_TopWar_Base.open_top_war, this.openCallBack, []);
            return;
        }// end function

        public function closePanel() : void
        {
            _data.call(Mod_TopWar_Base.open_top_war, new Function(), []);
            return;
        }// end function

        public function create() : void
        {
            _data.call(Mod_TopWar_Base.create_team, this.createCallBack, []);
            return;
        }// end function

        public function join(param1:int) : void
        {
            this._joinTeamId = param1;
            _data.call(Mod_TopWar_Base.join_team, this.joinCallBack, [param1]);
            return;
        }// end function

        public function scoreBoard() : void
        {
            _data.call(Mod_TopWar_Base.score_rank, this.scoreRankCallBack, []);
            return;
        }// end function

        private function render() : void
        {
            if (this._topWarCreate == null)
            {
                this._topWarCreate = _view.getAssetsObject("TopWarCreate", "TopWarCreate") as ITopWarCreate;
            }
            _popup.addView(this, this._topWarCreate.content);
            this._topWarCreate.tip = _view.tip.iTip;
            this._topWarCreate.onClose = this.close;
            this._topWarCreate.onCreate = this.create;
            this._topWarCreate.onFastJoin = this.join;
            this._topWarCreate.onJoin = this.join;
            this._topWarCreate.onScoreBoard = this.scoreBoard;
            this._topWarCreate.showMessage = this.showMessage;
            this._topWarCreate.onBody = _view.roleMsg.switchSelf;
            this._topWarCreate.onPack = _view.pack.switchSelf;
            this._topWarCreate.onUpgrade = _view.upgrade.switchSelf;
            this._topWarCreate.onResearch = _view.research.switchSelf;
            this._topWarCreate.onDeploy = _view.superDeploy.switchSelf;
            this._topWarCreate.onFate = _view.fate.switchSelf;
            this._topWarCreate.onSealSoul = _view.sealSoul.switchSelf;
            this._topWarCreate.onCheckHero = function (param1:Object) : void
            {
                if (param1.player_id == _ctrl.player.playerId)
                {
                    return;
                }
                _view.otherRoleMsg.init(param1.player_id, param1.nickname);
                _view.otherRoleMsg.show();
                return;
            }// end function
            ;
            this._topWarCreate.onSendFlower = function (param1:Object) : void
            {
                if (param1.player_id == _ctrl.player.playerId)
                {
                    return;
                }
                _view.sendFlower.sendPlayerID = param1.player_id;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._topWarCreate.onAddFriend = function (param1:Object) : void
            {
                if (param1.player_id == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendList.addFriend(param1.nickname);
                return;
            }// end function
            ;
            this._topWarCreate.openType = this._openType;
            if (this._openType == 0)
            {
                _view.chat.updateDepth(this);
            }
            this._topWarCreate.score = _ctrl.topWar.myScore;
            this._topWarCreate.teamList = _ctrl.topWar.teamList;
            this._topWarCreate.timesIsUse = _ctrl.topWar.timesIsUse;
            this._topWarCreate.teamId = this._teamId;
            this._topWarCreate.render();
            _data.patch(Mod_TopWar_Base.notify_new_team, this.newTeamCallBack);
            _data.patch(Mod_TopWar_Base.notify_drop_team, this.dropTeamCallBack);
            _data.patch(Mod_TopWar_Base.notify_update_team, this.updateTeamCallBack);
            this.reposition();
            return;
        }// end function

        public function set openType(param1:int) : void
        {
            this._openType = param1;
            this._teamId = 0;
            if (inStage && this._openType == 0)
            {
                this.close();
            }
            return;
        }// end function

        private function openCallBack() : void
        {
            loadAssets("TopWarCreate", this.render, TopWarCreateViewLang.Open, false, true);
            return;
        }// end function

        private function createCallBack() : void
        {
            var _loc_1:* = _ctrl.topWar.isCreate;
            if (_loc_1 == Mod_TopWar_Base.SUCCESS)
            {
                this.close();
                _view.topWarMap.gotoTown();
                this._openType = 1;
                this._topWarCreate.openType = this._openType;
                this._teamId = _ctrl.player.playerId;
            }
            else
            {
                this.showMessage(_loc_1);
            }
            return;
        }// end function

        private function joinCallBack() : void
        {
            var _loc_1:* = _ctrl.topWar.isJoin;
            if (_loc_1 == Mod_TopWar_Base.SUCCESS)
            {
                this.close();
                _view.topWarMap.gotoTown();
                this._openType = 1;
                this._topWarCreate.openType = this._openType;
                this._teamId = this._joinTeamId;
            }
            else
            {
                this.showMessage(_loc_1);
            }
            return;
        }// end function

        private function newTeamCallBack() : void
        {
            var _loc_1:* = _ctrl.topWar.newTeam;
            this._topWarCreate.addNewTeam(_loc_1);
            return;
        }// end function

        private function dropTeamCallBack() : void
        {
            var _loc_1:* = _ctrl.topWar.dropTeam;
            this._topWarCreate.dropTeam(_loc_1);
            return;
        }// end function

        private function updateTeamCallBack() : void
        {
            var _loc_1:* = _ctrl.topWar.updateTeam;
            this._topWarCreate.updateTeam(_loc_1);
            return;
        }// end function

        private function scoreRankCallBack() : void
        {
            this._topWarCreate.scoreList = _ctrl.topWar.scoreList;
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
                case Mod_TopWar_Base.TOP_WAR_NOT_OPEN:
                {
                    _loc_2 = TopWarCreateViewLang.TOP_WAR_NOT_OPEN;
                    break;
                }
                case Mod_TopWar_Base.NOT_ENOUGTH_LEVEL:
                {
                    _loc_2 = TopWarCreateViewLang.NOT_ENOUGTH_LEVEL;
                    break;
                }
                case Mod_TopWar_Base.HAVE_TEAM:
                {
                    _loc_2 = TopWarCreateViewLang.HAVE_TEAM;
                    break;
                }
                case Mod_TopWar_Base.IN_TEAM:
                {
                    _loc_2 = TopWarCreateViewLang.IN_TEAM;
                    break;
                }
                case Mod_TopWar_Base.FULL_TEAM_NUMBER:
                {
                    _loc_2 = TopWarCreateViewLang.FULL_TEAM_NUMBER;
                    break;
                }
                case Mod_TopWar_Base.TIMES_USE:
                {
                    _loc_2 = TopWarCreateViewLang.TIMES_USE;
                    break;
                }
                case Mod_TopWar_Base.INVALID_TEAM_ID:
                {
                    _loc_2 = TopWarCreateViewLang.INVALID_TEAM_ID;
                    break;
                }
                case Mod_TopWar_Base.FULL_MEMBER:
                {
                    _loc_2 = TopWarCreateViewLang.FULL_MEMBER;
                    break;
                }
                case Mod_TopWar_Base.FAILED:
                {
                    _loc_2 = TopWarCreateViewLang.FAILED;
                    break;
                }
                case this.FastJoin:
                {
                    _loc_2 = TopWarCreateViewLang.FastJoin;
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
            if (!inStage || !this._topWarCreate)
            {
                return;
            }
            var _loc_1:* = Math.max(800, Math.min(Structure.maxStageWidth, this._topWarCreate.content.stage.stageWidth));
            var _loc_2:* = Math.max(400, Math.min(Structure.maxStageHeight, this._topWarCreate.content.stage.stageHeight));
            var _loc_3:* = _loc_2 - 650;
            var _loc_4:* = _loc_1 - 1250;
            this._topWarCreate.content.y = _loc_3;
            this._topWarCreate.content.x = _loc_4;
            return;
        }// end function

    }
}
