package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IHeroesWar
    {

        public function IHeroesWar();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set onJoinWar(param1:Function) : void;

        function set onExitWar(param1:Function) : void;

        function set onIngotInspire(param1:Function) : void;

        function set onSkillInspire(param1:Function) : void;

        function set onTextLink(param1:Function) : void;

        function set drag(param1:IDrag) : void;

        function set tip(param1:ITip) : void;

        function set playerLevel(param1:int) : void;

        function set playerID(param1:int) : void;

        function get WarReportType() : int;

        function get autoJoin() : Boolean;

        function clear() : void;

        function render() : void;

        function renderShuShanInfo(param1:Object) : void;

        function renderKunLunInfo(param1:Object) : void;

        function renderWinningList(param1:Array) : void;

        function renderPlayerHeroesWarInfo(param1:Object) : void;

        function renderHeroesWarEndTime(param1:String) : void;

        function renderWarReportList(param1:Array, param2:Array) : void;

        function renderWarReport(param1:Array, param2:Array, param3:Array) : void;

        function renderJoinWar(param1:int) : void;

        function renderExitWar() : void;

        function renderCanJoinWar() : void;

        function renderIntegral(param1:Object) : void;

        function renderHeroesLevelArea(param1:Array) : void;

        function renderBuyBuffSuccess(param1:String) : void;

        function renderBuyBuffFail(param1:String) : void;

        function updateSkill(param1:int) : void;

        function renderBuff(param1:Object) : void;

        function loadBtnCartoon(param1:Array) : void;

        function renderPlayer(param1:Object, param2:String) : void;

        function renderPlayerList(param1:Array, param2:String) : void;

        function renderAutoJoin() : void;

        function setShuShanPlayerList() : void;

        function setKunLunPlayerList() : void;

    }
}
