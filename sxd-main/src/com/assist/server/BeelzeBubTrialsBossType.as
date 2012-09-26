package com.assist.server
{

    public class BeelzeBubTrialsBossType extends Object
    {
        public static var DaMoWangBoss:String = "DaMoWangBoss";
        public static var DongHuangTaiYiBoss:String = "DongHuangTaiYiBoss";
        public static var MoWangChiYouBoss:String = "MoWangChiYouBoss";
        public static var BaoZiWangBoss:String = "BaoZiWangBoss";
        public static var ChiGuiWangBoss:String = "ChiGuiWangBoss";
        public static var BaoYaBoss:String = "BaoYaBoss";
        public static const Bosses:Object = {1:["大魔王", "DaMoWangBoss", 0, 500000, 100, "队长，想挑战我，就点一下我吧！|赶紧叫人吧，都不够3个人啊！|哈哈哈，想杀我，没那么容易的！"], 2:["东皇太一", "DongHuangTaiYiBoss", 0, 1000000, 120, "队长，想挑战我，就点一下我吧！|赶紧叫人吧，都不够3个人啊！|我乃万妖之王，没那么容易死的。"], 3:["魔王蚩尤", "MoWangChiYouBoss", 0, 1000000, 150, "队长，想挑战我，就点一下我吧！|赶紧叫人吧，都不够3个人啊！|千万人来也一样，我蚩尤照杀不误。"], 4:["孢子王", "BaoZiWangBoss", 0, 1000000, 130, "队长，想挑战我，就点一下我吧！|赶紧叫人吧，都不够3个人啊！|愚蠢的人类，醒醒吧。"], 5:["赤鬼王", "ChiGuiWangBoss", 0, 1000000, 140, "队长，想挑战我，就点一下我吧！|赶紧叫人吧，都不够3个人啊！|我赤鬼王再次强势归来，颤抖吧，弱小的人类。"], 6:["龅牙", "BaoYaBoss", 0, 1000000, 150, "队长，想挑战我，就点一下我吧！|赶紧叫人吧，都不够3个人啊！|龅牙，龅牙，我叫龅牙，怕了吧。"]};

        public function BeelzeBubTrialsBossType()
        {
            return;
        }// end function

        public static function getAwardByBossId(param1:int) : Array
        {
            var _loc_2:* = Bosses[param1];
            if (_loc_2)
            {
                return [_loc_2[2], _loc_2[3]];
            }
            return [0, 0];
        }// end function

        public static function getBossNameById(param1:int) : String
        {
            var _loc_2:* = Bosses[param1];
            if (_loc_2)
            {
                return _loc_2[0];
            }
            return "";
        }// end function

        public static function getBossLvById(param1:int) : int
        {
            var _loc_2:* = Bosses[param1];
            if (_loc_2)
            {
                return _loc_2[4];
            }
            return 0;
        }// end function

        public static function getBossTalkById(param1:int) : Array
        {
            var _loc_2:* = Bosses[param1];
            var _loc_3:String = "";
            if (_loc_2)
            {
                _loc_3 = _loc_2[5];
            }
            return _loc_3.split("|");
        }// end function

    }
}
