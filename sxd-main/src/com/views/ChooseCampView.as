package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class ChooseCampView extends Base implements IView
    {
        private var _chooseCamp:IChooseCamp;

        public function ChooseCampView()
        {
            return;
        }// end function

        public function show() : void
        {
            loadAssets("ChooseCamp", this.render, ChooseCampViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            this._chooseCamp = _view.getAssetsObject("ChooseCamp", "ChooseCamp") as IChooseCamp;
            _popup.addView(this, this._chooseCamp.content);
            this._chooseCamp.tip = _view.tip.iTip;
            this._chooseCamp.drag = _view.drag.iDrag;
            this._chooseCamp.onClose = this.close;
            this._chooseCamp.onGotoTown = function (param1:String) : void
            {
                close();
                var _loc_2:* = FactionType.campId(param1);
                _data.call(Mod_Player_Base.set_player_camp, setPlayerCampCallback(_loc_2, param1), [_loc_2]);
                return;
            }// end function
            ;
            _view.center(sign, this._chooseCamp.content);
            return;
        }// end function

        private function setPlayerCampCallback(param1:int, param2:String) : Function
        {
            var campId:* = param1;
            var townType:* = param2;
            return function () : void
            {
                var _loc_1:* = undefined;
                _view.toolbar.loadQuestTrace();
                switch(_ctrl.player.campResult)
                {
                    case Mod_Player_Base.SUCCESS:
                    {
                        _ctrl.player.campId = campId;
                        _loc_1 = TownType.getId(townType);
                        _view.world.autoEnterTown(_ctrl.player.mapId, _loc_1);
                        break;
                    }
                    case Mod_Player_Base.CAMP_ERR:
                    {
                        _view.alert.confirm(ChooseCampViewLang.CampErr);
                        break;
                    }
                    case Mod_Player_Base.CANT_CHANGE_CAMP:
                    {
                        _view.alert.confirm(ChooseCampViewLang.CantChangeCamp);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            ;
        }// end function

        public function loginToChoose() : void
        {
            var _loc_1:* = _ctrl.player.campId;
            if (FactionType.campSign(_loc_1) == FactionType.WeiXuanZe)
            {
                this.show();
            }
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._chooseCamp.close();
            return;
        }// end function

    }
}
