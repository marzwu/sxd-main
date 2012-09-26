package com.protocols
{
    import com.*;

    public class Mod_CatHunt extends Object
    {

        public function Mod_CatHunt()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_CatHunt_Base.auto_search_bonus, param1.catHunt.auto_search_bonus);
            param1.registerDataCallback(Mod_CatHunt_Base.use_map_search, param1.catHunt.use_map_search);
            return;
        }// end function

    }
}
