package com.views
{
    import com.assist.view.war.*;

    public class WorldFactionWarView extends Base
    {

        public function WorldFactionWarView()
        {
            return;
        }// end function

        public function init() : void
        {
            _view.strategyWar.warType = WarType.WorldFactionWar;
            _view.strategyWar.reportId = 1739;
            _view.strategyWar.missionId = 1;
            _view.strategyWar.show();
            return;
        }// end function

        private function aa() : void
        {
            return;
        }// end function

    }
}
