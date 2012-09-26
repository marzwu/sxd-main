package com.assist.view.interfaces
{

    public interface INewTopWar extends IContent
    {

        public function INewTopWar();

        function set onTip(param1:Function) : void;

        function set onBody(param1:Function) : void;

        function set onPack(param1:Function) : void;

        function set onUpgrade(param1:Function) : void;

        function set onResearch(param1:Function) : void;

        function set onDeployMain(param1:Function) : void;

        function set onFate(param1:Function) : void;

        function set onSealSoul(param1:Function) : void;

        function set onCloseWindow(param1:Function) : void;

        function set onSeePlayerInfo(param1:Function) : void;

        function set onSeeTeamInfo(param1:Function) : void;

        function set onMyTeam(param1:Function) : void;

        function stepState(param1:int, param2:int) : void;

        function set onCreat(param1:Function) : void;

        function set creatResult(param1:Boolean) : void;

        function set onSelect(param1:Function) : void;

        function set teamCreatObj(param1:Object) : void;

        function set onApply(param1:Function) : void;

        function setInApply(param1:int, param2:int) : void;

        function set haveTeam(param1:Boolean) : void;

        function set onOpenTopThone(param1:Function) : void;

        function set myTeamInfo(param1:Object) : void;

        function set onSeeMyWar(param1:Function) : void;

        function set btnExamineVisible(param1:Boolean) : void;

        function set btnRegVisible(param1:Boolean) : void;

        function set onReg(param1:Function) : void;

        function set onDeploy(param1:Function) : void;

        function set onDeployChange(param1:Function) : void;

        function set onExitTeam(param1:Function) : void;

        function set onQuitTeam(param1:Function) : void;

        function set onExamine(param1:Function) : void;

        function set onOtherTeam(param1:Function) : void;

        function set onMemberOut(param1:Function) : void;

        function setDeployList(param1:Array, param2:int) : void;

        function set examineList(param1:Array) : void;

        function clearItemById(param1:int) : void;

        function set onSkip(param1:Function) : void;

        function set onPass(param1:Function) : void;

        function set onNotPass(param1:Function) : void;

        function set onOpenRoleChange(param1:Function) : void;

        function set roleList(param1:Array) : void;

        function set onChangeRole(param1:Function) : void;

        function set onRegList(param1:Function) : void;

        function set regList(param1:Array) : void;

        function setWarRecordInfo(param1:Array) : void;

        function set onSeeWar(param1:Function) : void;

        function set onOpenTeamRank(param1:Function) : void;

        function set teamRankList(param1:Array) : void;

    }
}
