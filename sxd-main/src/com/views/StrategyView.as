package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class StrategyView extends Base implements IView
    {
        private var _iStrategy:IStrategy;
        private var _playerList:Array;
        public var missionId:int;
        public var monsterTeamId:int;
        public var background:BitmapData;

        public function StrategyView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            _data.call(Mod_Mission_Base.get_monster_strategy_list, this.loadResources, [this.monsterTeamId]);
            return;
        }// end function

        private function loadResources() : void
        {
            loadAssets("Strategy", this.render, StrategyViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            this._iStrategy = _view.getAssetsObject("Strategy", "Strategy") as IStrategy;
            this._iStrategy.drag = _view.drag.iDrag;
            this._iStrategy.onClose = this.close;
            this._iStrategy.showStrategyWar = this.showStrategyWar;
            var _loc_1:* = _ctrl.mission.masterMonsterId;
            var _loc_2:* = MonsterType.getMonsterNameById(_loc_1);
            this._playerList = _ctrl.mission.strategyList;
            this._iStrategy.renderPlayerList(this._playerList, _loc_2);
            _popup.addView(this, this._iStrategy.content);
            _view.center(sign, this._iStrategy.content);
            return;
        }// end function

        private function showStrategyWar(param1:int, param2:String, param3:String) : void
        {
            _view.strategyWar.warType = WarType.War;
            _view.strategyWar.version = param3;
            _view.strategyWar.reportId = param1;
            _view.strategyWar.missionId = this.missionId;
            _view.strategyWar.background = this.background;
            _view.strategyWar.show();
            return;
        }// end function

        public function close() : void
        {
            if (inStage == false)
            {
                return;
            }
            this.clear();
            this._playerList = null;
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._iStrategy.clear();
            return;
        }// end function

    }
}
