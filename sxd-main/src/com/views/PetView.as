package com.views
{
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;

    final public class PetView extends Base implements IView
    {
        private var _target:IPetLong;
        private var _info:PetLongInfo;

        public function PetView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            this.pet_animal_info();
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            this.clearPetAnimal();
            return;
        }// end function

        public function clear() : void
        {
            this.clearPetAnimal();
            return;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("Pet", "MCPetLong") as IPetLong;
                this._target.onClose = this.close;
                this._target.onCoin = this.onCoin;
                this._target.onIngot = this.onIngot;
                this._target.onUpLv = this.onUpLv;
                this._target.onTip = this.onTip;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (!this._info)
            {
                this._info = _ctrl.pet.info;
                this._info.addEventListener(PetLongInfo.FEEDNUMCHANGE, this.feedNumChangeFun);
            }
            this._info.vipLv = _ctrl.player.vipLevel;
            this._info.playerLv = _ctrl.player.level;
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            _view.screen.currentMap.updatePetLv(this._info.lv);
            this.updatePet();
            this.feedNumChangeFun();
            return;
        }// end function

        private function onUpLv() : void
        {
            this.up_pet_animal();
            return;
        }// end function

        private function onCoin() : void
        {
            this.feed_pet_animal(0);
            return;
        }// end function

        private function onIngot() : void
        {
            this.feed_pet_animal(1);
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            if (param2 == null || param2 == "")
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
            }
            return;
        }// end function

        private function updatePet(param1:Boolean = false, param2:Boolean = false) : void
        {
            if (param2)
            {
                _view.screen.currentMap.updatePetLv(this._info.lv);
                this._target.updatePet(this._info);
            }
            return;
        }// end function

        private function feedNumChangeFun(event:Event = null) : void
        {
            if (this._target != null)
            {
                this._target.updatePet(this._info);
            }
            return;
        }// end function

        public function getPetAnimalInfo() : void
        {
            _data.call(Mod_PetAnimal_Base.pet_animal_info, this.getPetAnimalInfoBack, [_ctrl.player.playerId]);
            return;
        }// end function

        private function getPetAnimalInfoBack() : void
        {
            this._info = _ctrl.pet.info;
            this._info.addEventListener(PetLongInfo.FEEDNUMCHANGE, this.feedNumChangeFun);
            _view.screen.currentMap.updatePetLv(this._info.lv);
            return;
        }// end function

        private function pet_animal_info() : void
        {
            _data.call(Mod_PetAnimal_Base.pet_animal_info, this.pet_animal_info_back, [_ctrl.player.playerId]);
            return;
        }// end function

        private function pet_animal_info_back() : void
        {
            loadAssets("Pet", null, PetViewLang.Loading, false, false, this.loadComplete);
            return;
        }// end function

        private function feed_pet_animal(param1:int) : void
        {
            if (this._info.feedNum == 0)
            {
                _view.showTip(PetViewLang.EatNumOver);
                return;
            }
            _data.call(Mod_PetAnimal_Base.feed_pet_animal, this.feed_pet_animal_back, [param1]);
            return;
        }// end function

        private function feed_pet_animal_back() : void
        {
            if (_ctrl.pet.result == Mod_PetAnimal_Base.SUCCESS)
            {
                _view.gameHelper.loader_first_info();
                this.updatePet(true);
            }
            else if (_ctrl.pet.result == Mod_PetAnimal_Base.NOENOUGH_INGOT)
            {
                _view.showTip(PetViewLang.IngotNoenough);
            }
            else if (_ctrl.pet.result == Mod_PetAnimal_Base.NOENOUGH_COIN)
            {
                _view.showTip(PetViewLang.CoinNoenough);
            }
            else
            {
                _view.showTip(PetViewLang.EatError);
            }
            return;
        }// end function

        private function up_pet_animal() : void
        {
            _data.call(Mod_PetAnimal_Base.up_pet_animal, this.up_pet_animal_back, []);
            return;
        }// end function

        private function up_pet_animal_back() : void
        {
            this.updatePet(false, true);
            return;
        }// end function

        public function get_pet_animal_info() : void
        {
            _data.call(Mod_PetAnimal_Base.pet_animal_info, this.clearPetAnimal, [_ctrl.player.playerId]);
            return;
        }// end function

        private function clearPetAnimal() : void
        {
            if (_ctrl.pet.info.feedNum == 0 || _ctrl.pet.info.isFull)
            {
                _view.activities.removeActivity(FunctionType.PetAnimal);
            }
            return;
        }// end function

    }
}
