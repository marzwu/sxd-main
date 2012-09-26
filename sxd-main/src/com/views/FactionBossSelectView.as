package com.views
{
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.map.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class FactionBossSelectView extends Base implements IView
    {
        private var _target:IFactionBossSelect;
        public var isSee:Boolean = false;

        public function FactionBossSelectView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            this.faction_boss_time_list(BossInfo.BossDaoBaTu);
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
            var _loc_5:Object = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("FactionBossSelect", "FactionBossSelect") as IFactionBossSelect;
                this._target.onClose = this.close;
                this._target.onOk = this.onOk;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            var _loc_1:* = _ctrl.worldBossMap.bossList[BossInfo.BossDaoBaTu];
            if (_loc_1.state == -1)
            {
                return;
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            var _loc_2:Array = [5, 6];
            var _loc_3:* = _loc_1.setList;
            var _loc_4:int = 0;
            this._target.See = this.isSee;
            while (_loc_4 < 7)
            {
                
                _loc_5 = _loc_3[_loc_4];
                if (_loc_5.selected == 1)
                {
                    _loc_2.unshift(_loc_4);
                }
                if (this.isSee)
                {
                    if (_loc_5.isnext == 1)
                    {
                        if (_loc_5.selected == 1)
                        {
                            if (_loc_5.expired == 0)
                            {
                                this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNext + HtmlText.green(FactionBossSelectViewLang.IsChoose));
                            }
                            else
                            {
                                this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNext + HtmlText.red(FactionBossSelectViewLang.IsEnd));
                            }
                        }
                        else
                        {
                            this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNext);
                        }
                    }
                    else if (_loc_5.selected == 1)
                    {
                        if (_loc_5.expired == 0)
                        {
                            this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNow + HtmlText.green(FactionBossSelectViewLang.IsChoose));
                        }
                        else
                        {
                            this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNow + HtmlText.red(FactionBossSelectViewLang.IsEnd));
                        }
                    }
                    else
                    {
                        this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNow);
                    }
                }
                else if (_loc_5.isnext == 1)
                {
                    this._target.setSelectEnabled(_loc_4, true);
                    this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNext);
                }
                else
                {
                    this._target.setSelectEnabled(_loc_4, _loc_5.expired == 0);
                    this._target.setSelectMsg(_loc_4, _loc_5.msgWeekNow);
                }
                _loc_4++;
            }
            this._target.setSelectDefault(_loc_2[0], _loc_2[1]);
            return;
        }// end function

        private function onOk(param1:int, param2:int) : void
        {
            if (this.isSee == true)
            {
                this.close();
                return;
            }
            if (param1 == -1 && param2 == -1)
            {
                _view.showTip(FactionBossSelectViewLang.MoreTwo);
                return;
            }
            if (param1 == -1 || param2 == -1)
            {
                _view.showTip(FactionBossSelectViewLang.MoreOne);
                return;
            }
            var _loc_3:* = _ctrl.worldBossMap.bossList[BossInfo.BossDaoBaTu];
            var _loc_4:* = _loc_3.setList;
            this.select_faction_boss_time(_loc_4[param1].type_id, _loc_4[param2].type_id);
            return;
        }// end function

        private function faction_boss_time_list(param1:int) : void
        {
            _data.call(Mod_WorldBoss_Base.faction_boss_time_list, this.faction_boss_time_list_back, [param1]);
            return;
        }// end function

        private function faction_boss_time_list_back() : void
        {
            loadAssets("FactionBossSelect", this.loadComplete, FactionBossSelectViewLang.LoadInfo, true);
            return;
        }// end function

        private function select_faction_boss_time(param1:int, param2:int) : void
        {
            _data.call(Mod_WorldBoss_Base.select_faction_boss_time, this.select_faction_boss_time_back, [BossInfo.BossDaoBaTu, param1, param2]);
            return;
        }// end function

        private function select_faction_boss_time_back() : void
        {
            if (_ctrl.worldBossMap.result == -1)
            {
                _view.showTip(FactionBossSelectViewLang.SettingFail);
            }
            else
            {
                _view.alert.confirm(_ctrl.worldBossMap.notifyBoss.chatTips);
            }
            this.close();
            _view.factionWindow.get_world_boss_list();
            return;
        }// end function

    }
}
