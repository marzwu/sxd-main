package com.assist.server
{

    public class ZodiacType extends Object
    {
        private static const Levels:Object = {1:["一重天"], 2:["二重天"], 3:["三重天"], 4:["四重天"], 5:["五重天"], 6:["六重天"], 7:["七重天"], 8:["八重天"], 9:["九重天"]};

        public function ZodiacType()
        {
            return;
        }// end function

        public static function getZodiaName(param1:int) : String
        {
            return Levels[param1] ? (Levels[param1][0]) : ("");
        }// end function

    }
}
