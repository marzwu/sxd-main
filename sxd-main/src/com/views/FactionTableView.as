package com.views
{
    import com.assist.*;
    import com.assist.view.interfaces.factionWar.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.text.*;
    import flash.utils.*;

    public class FactionTableView extends Base implements IView
    {
        private var _target:IFactionWarTable;

        public function FactionTableView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            this.cup_list();
            return;
        }// end function

        public function update() : void
        {
            if (inStage == false)
            {
                return;
            }
            this.cup_list();
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadComplete() : void
        {
            var _loc_2:String = null;
            var _loc_3:TextField = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("FactionTable", "MCFactionWarTable") as IFactionWarTable;
                this._target.onClose = this.close;
                this._target.onInto = this.onInto;
                this._target.onSeeClick = this.onSeeClick;
                this._target.onTextLink = this.onTextLink;
                this._target.buttonEffect = _view.activities.buttonEffectObj();
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                _loc_2 = htmlFormat(FactionTableViewLang.OpenGift, 12, 16777215) + htmlFormat(FactionTableViewLang.PurpleReel, 12, 16711935) + "，" + htmlFormat(FactionTableViewLang.SixReel, 12, 44783) + "，" + htmlFormat(FactionTableViewLang.SixImmortality, 12, 44783) + "，" + htmlFormat(FactionTableViewLang.FiveImmortality, 12, 44783);
                _loc_2 = htmlFormat(FactionTableViewLang.ChampionGift + "\n", 12, 16773376) + _loc_2 + FactionTableViewLang.Comma + htmlFormat(FactionTableViewLang.ChampionRide, 12, 16773376) + FactionTableViewLang.Period;
                _loc_3 = new TextField();
                _loc_3.textColor = 16777215;
                _loc_3.wordWrap = true;
                _loc_3.width = 150;
                _loc_3.htmlText = _loc_2;
                _loc_3.height = _loc_3.textHeight + 5;
                _view.tip.iTip.com.assist.view.interfaces:ITip::addTarget(this._target.jueSaiBtn, _loc_3);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            var _loc_1:* = _ctrl.factionWarMap.cupObj;
            this._target.cupObj = _loc_1;
            if (_view.factionWarMap.inStage && _ctrl.factionWarMap.intoTime > 0)
            {
                this._target.intoVisible = false;
            }
            return;
        }// end function

        private function onInto() : void
        {
            _view.factionWarMap.gotoFactionWar();
            return;
        }// end function

        private function onSeeClick(param1:Object) : void
        {
            this.get_versus_rank_list(param1.round, param1.id1, param1.id2);
            return;
        }// end function

        private function get_versus_rank_list(param1:int, param2:int, param3:int) : void
        {
            _data.call(Mod_FactionWar_Base.get_versus_rank_list, this.get_versus_rank_list_back, [1, param1, param2, param3]);
            return;
        }// end function

        private function get_versus_rank_list_back() : void
        {
            this._target.heroRank = _ctrl.factionWarMap.heroRank;
            this._target.heroRankTip = _ctrl.factionWarMap.heroRankTip;
            return;
        }// end function

        private function onTextLink(param1:int, param2:String) : void
        {
            var _loc_5:Array = null;
            if (param1 == _ctrl.player.playerId)
            {
                return;
            }
            if (param2.indexOf(FactionTableViewLang.FactonBoss))
            {
                _loc_5 = [FactionTableViewLang.QueryData, FactionTableViewLang.AddAttention];
            }
            var _loc_3:Array = [[TextLinkType.SeeMsg, param1].join("_"), [TextLinkType.AddFocus, param1, param2].join("_")];
            var _loc_4:* = new ClickTipList(_loc_5, _loc_3, _view.toolbar.onTextLink);
            setTimeout(_view.tip.iTip.clickToOpen, 50, _loc_4);
            return;
        }// end function

        private function cup_list() : void
        {
            _data.call(Mod_FactionWar_Base.cup_list, this.cup_list_back, [1]);
            return;
        }// end function

        private function cup_list_back() : void
        {
            loadAssets("FactionTable", null, FactionTableViewLang.LoadInfo, true, false, this.loadComplete);
            return;
        }// end function

    }
}
