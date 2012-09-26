package com.assist.server
{

    public class WarAttributeType extends Object
    {
        private static const Data:Object = {1:["health", "生命"], 2:["attack", "普攻"], 3:["defense", "普防"], 4:["magic_attack", "法攻"], 5:["magic_defense", "法防"], 6:["stunt_attack", "绝攻"], 7:["stunt_defense", "绝防"], 8:["hit", "命中等级"], 9:["block", "格挡等级"], 10:["dodge", "闪避等级"], 11:["critical", "暴击等级"], 12:["momentum", "气势"], 13:["break_block", "破击等级"], 14:["break_critical", "韧性等级"], 15:["kill", "必杀等级"]};

        public function WarAttributeType()
        {
            return;
        }// end function

        public static function getSign(param1:int) : String
        {
            return Data[param1] ? (Data[param1][0]) : ("");
        }// end function

        public static function getName(param1:int) : String
        {
            return Data[param1] ? (Data[param1][1]) : ("");
        }// end function

    }
}
