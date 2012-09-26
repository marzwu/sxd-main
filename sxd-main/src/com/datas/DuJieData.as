package com.datas
{
    import com.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class DuJieData extends Base
    {
        public var resultTip:String = "";
        public var result:int = 0;
        public var dujieState:int = 0;
        public var pointState:int = 0;
        public var dujieName:String = "";
        public var nowStateLevel:int = 0;
        public var addLife:String = "";
        public var pointTip:String = "";
        public var dujieTip:String = "";
        public var playerRoleId:int = 0;
        public var playerRoleLv:int = 0;
        public var warData:WarData;
        public var addHealth:int;
        public var roleId:int;
        public var spiritStateId:int;
        public var spiritStateLevel:int;
        public var awardAura:int;

        public function DuJieData()
        {
            return;
        }// end function

        public function dujie_info(param1:Array) : void
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["player_role_id", "now_state", "now_state_level", "next_state", "next_state_level", "need_player_role_level", "need_state_point", "player_role_state_point", "player_state_point", "function_open"]);
            this.playerRoleId = _loc_2.player_role_id;
            this.playerRoleLv = 70;
            this.dujieTip = "";
            this.pointTip = "";
            this.dujieName = "";
            this.dujieState = 0;
            this.pointState = 0;
            this.nowStateLevel = _loc_2.now_state_level;
            if (_loc_2.function_open == 0)
            {
                return;
            }
            this.addLife = HtmlText.green(DuJieType.getRequireHealth(_loc_2.next_state, _loc_2.next_state_level) + "");
            var _loc_3:* = _loc_2.need_state_point - _loc_2.player_role_state_point;
            var _loc_4:* = DuJieType.getSpiritName(_loc_2.next_state) + DuJieType.getSpiritLevelInfo(_loc_2.next_state_level);
            _loc_4 = HtmlText.format(_loc_4, DuJieType.getSpiritColor(_loc_2.next_state));
            this.dujieTip = Lang.sprintf(DuJieDataLang.StartDuJie, _loc_4, this.addLife);
            this.dujieTip = HtmlText.white(this.dujieTip);
            if (_loc_2.now_state_level == 3)
            {
                this.pointTip = Lang.sprintf(DuJieDataLang.UsePoint3, HtmlText.yellow(_loc_3 + ""), _loc_4, this.addLife, HtmlText.yellow(_loc_2.player_state_point));
            }
            else
            {
                this.pointTip = Lang.sprintf(DuJieDataLang.UsePoint1, HtmlText.yellow(_loc_3 + ""), _loc_4, this.addLife, HtmlText.yellow(_loc_2.player_state_point));
            }
            this.pointTip = HtmlText.white(this.pointTip);
            if (_loc_2.now_state == 0)
            {
                this.dujieState = 1;
            }
            else if (_loc_2.next_state == 0)
            {
                this.dujieName = DuJieType.getSpiritName(_loc_2.now_state) + DuJieType.getSpiritLevelInfo(_loc_2.now_state_level);
                this.dujieName = HtmlText.format(this.dujieName, DuJieType.getSpiritColor(_loc_2.now_state));
            }
            else
            {
                this.dujieName = DuJieType.getSpiritName(_loc_2.now_state) + DuJieType.getSpiritLevelInfo(_loc_2.now_state_level);
                this.dujieName = HtmlText.format(this.dujieName, DuJieType.getSpiritColor(_loc_2.now_state));
                this.playerRoleLv = DuJieType.getRequireRoleLevel(_loc_2.next_state, _loc_2.next_state_level);
                if (_loc_2.player_role_state_point >= _loc_2.need_state_point)
                {
                    this.dujieState = 1;
                    if (_loc_2.now_state_level != 3)
                    {
                        if (int(_loc_2.player_state_point) < _loc_3)
                        {
                            this.pointState = 2;
                        }
                        else
                        {
                            this.pointState = 1;
                        }
                    }
                }
                else if (int(_loc_2.player_state_point) < _loc_3)
                {
                    this.pointState = 2;
                }
                else
                {
                    this.pointState = 1;
                }
            }
            return;
        }// end function

        public function add_player_role_state_point(param1:Array) : void
        {
            this.playerRoleId = param1[0];
            this.result = param1[1];
            return;
        }// end function

        public function role_list(param1:Array) : void
        {
            return;
        }// end function

        public function go_dujie(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.playerRoleId = param1[0];
            this.result = param1[1];
            if (this.result == Mod_Dujie_Base.SUCCESS || this.result == Mod_Dujie_Base.FAIL)
            {
                if (param1[2].length > 0)
                {
                    _loc_2 = [].concat(param1[2][0]);
                    this.warData = new WarData();
                    this.warData.format([0, 0, 0, [_loc_2]]);
                    this.addHealth = param1[3];
                    this.roleId = param1[4];
                    this.spiritStateId = param1[5];
                    this.spiritStateLevel = param1[6];
                    this.awardAura = param1[7];
                }
            }
            else if (this.result == Mod_Dujie_Base.CD_TIME)
            {
                this.resultTip = DuJieDataLang.WarCD;
            }
            else
            {
                this.resultTip = DuJieDataLang.WarError;
            }
            return;
        }// end function

    }
}
