package com.views
{
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class TopThroneView extends Base implements IView
    {
        private var _target:ITopThrone;

        public function TopThroneView()
        {
            return;
        }// end function

        public function show() : void
        {
            _data.call(Mod_NewTopWar_Base.throne, this.loadUi, []);
            return;
        }// end function

        public function close() : void
        {
            _view.chat.resetDepth();
            _popup.closeView(this);
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
                loadAssets("TopThrone", this.render, TopThroneViewLang.Open);
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
                this._target = _view.getAssetsObject("TopThrone", "McTopThrone") as ITopThrone;
                this._target.onSeeTeamInfo = this.onSeeTeamInfo;
                this._target.onCloseWindow = this.close;
                this._target.onOpenTeam = this.onOpenTeam;
            }
            this._target.teamList = _ctrl.newTopWar.topThroneList;
            _view.chat.updateDepth(this);
            _popup.addView(this, this._target.content);
            this.reposition();
            return;
        }// end function

        public function onSeeTeamInfo(param1:int, param2:Object) : void
        {
            if (param2)
            {
                this._target.sigleTeamInfo = param2;
            }
            else
            {
                _view.otherTeamInfo.teamId = param1;
            }
            return;
        }// end function

        private function onSeeTeamInfoBack() : void
        {
            this._target.sigleTeamInfo = _ctrl.newTopWar.otherTeamInfoObj;
            return;
        }// end function

        private function onOpenTeam() : void
        {
            this.close();
            _view.newTopWar.show();
            return;
        }// end function

        public function reposition() : void
        {
            if (!inStage || !this._target)
            {
                return;
            }
            var _loc_1:* = Math.max(900, Math.min(Structure.maxStageWidth, this._target.content.stage.stageWidth));
            var _loc_2:* = Math.max(450, Math.min(Structure.maxStageHeight, this._target.content.stage.stageHeight));
            var _loc_3:* = _loc_2 - 650;
            var _loc_4:* = _loc_1 - 1250;
            this._target.content.y = _loc_3 / 2;
            this._target.content.x = _loc_4 / 2;
            this._target.reposition(_loc_4 / 2, _loc_3 / 2);
            return;
        }// end function

    }
}
