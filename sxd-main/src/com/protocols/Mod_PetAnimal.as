package com.protocols
{
    import com.*;

    public class Mod_PetAnimal extends Object
    {

        public function Mod_PetAnimal()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_PetAnimal_Base.pet_animal_info, param1.pet.pet_animal_info);
            param1.registerDataCallback(Mod_PetAnimal_Base.change_name, param1.pet.change_name);
            param1.registerDataCallback(Mod_PetAnimal_Base.feed_pet_animal, param1.pet.feed_pet_animal);
            param1.registerDataCallback(Mod_PetAnimal_Base.up_pet_animal, param1.pet.up_pet_animal);
            return;
        }// end function

    }
}
