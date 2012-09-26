package com.datas
{
    import com.assist.view.info.*;
    import com.protocols.*;

    public class PetAnimalData extends Base
    {
        public var result:int = 0;
        public var info:PetLongInfo;

        public function PetAnimalData()
        {
            this.info = new PetLongInfo();
            return;
        }// end function

        public function pet_animal_info(param1:Array) : void
        {
            this.info.reset(param1[1], param1[2], param1[3], param1[4]);
            return;
        }// end function

        public function feed_pet_animal(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result == Mod_PetAnimal_Base.SUCCESS)
            {
                this.info.feed(param1[1], param1[2], param1[3], param1[4], param1[5], param1[6], param1[7]);
            }
            return;
        }// end function

        public function change_name(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function up_pet_animal(param1:Array) : void
        {
            this.info.upLv(param1[0], param1[1], param1[2]);
            return;
        }// end function

    }
}
