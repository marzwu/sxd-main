package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.guide.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class NPCDialogView extends Base implements IView
    {
        private var _dialog:INPCDialog;
        private var _questId:int;
        public var npcSign:String;
        public var townNPCId:int;
        public var relatedView:IView;
        public var guideCallBack:Function;
        private var _acceptList:Object;
        private var _completeList:Object;

        public function NPCDialogView()
        {
            this._acceptList = {};
            this._completeList = {};
            return;
        }// end function

        public function show() : void
        {
            if (_view.world.inStage || _view.newWorld.inStage || _view.takeBibleRoad.inStage || _view.superSport.inStage || _view.lodge.inStage)
            {
                return;
            }
            this._completeList = {};
            this.npc_info_by_npcid();
            return;
        }// end function

        public function clear() : void
        {
            if (this._dialog)
            {
                this._dialog.clear();
                this._dialog = null;
            }
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return super.inStage && (this._dialog && this._dialog.npcId == this.townNPCId || true);
        }// end function

        public function npc_info_by_npcid() : void
        {
            _data.call(Mod_Quest_Base.npc_info_by_npcid, this.loadResources, [this.townNPCId]);
            return;
        }// end function

        public function recall_npc_info_by_npcid(param1:Function = null) : void
        {
            var callback:* = param1;
            var handler:* = function () : void
            {
                renderData();
                if (callback is Function)
                {
                    callback();
                }
                return;
            }// end function
            ;
            _data.call(Mod_Quest_Base.npc_info_by_npcid, handler, [this.townNPCId]);
            return;
        }// end function

        private function loadResources() : void
        {
            loadAssets("NPCDialog", this.render, NPCDialogViewLang.LoadInfo);
            return;
        }// end function

        public function render() : void
        {
            this._dialog = _view.getAssetsObject("NPCDialog", "NPCDialog") as INPCDialog;
            _popup.addView(this, this._dialog.content);
            this._dialog.content.x = 100;
            this._dialog.content.y = 100;
            this._dialog.iconUrl = URI.assetsUrl + "icons/npc_dialog/" + this.npcSign + ".swf";
            this._dialog.npcId = this.townNPCId;
            this._dialog.npcSign = this.npcSign;
            this._dialog.npcName = NPCType.getNameBySign(this.npcSign);
            this._dialog.npcMessage = NPCType.getDialogBySign(this.npcSign);
            this.addFeature();
            this.addSlaveFeature();
            this._dialog.onClose = this.close;
            this._dialog.onFeature = this.onFeature;
            this._dialog.onSlaveFeature = this.onSlaveFeature;
            this._dialog.onAccept = this.onAccept;
            this._dialog.onComplete = this.onComplete;
            this._dialog.onAcceptNextForGuide = this.onAcceptNextForGuide;
            this._dialog.onAcceptLastForGuide = this.onAcceptLastForGuide;
            this.renderData();
            if (this.guideCallBack is Function)
            {
                setTimeout(this.guideCallBack, 200);
            }
            return;
        }// end function

        private function addFeature() : void
        {
            var _loc_1:* = NPCType.getFeatureBySign(this.npcSign);
            this._dialog.npcFeature = _loc_1;
            return;
        }// end function

        private function addSlaveFeature() : void
        {
            if (NPCType.getFunctionBySign(this.npcSign) == NPCType.CardBuyNPC && TownNPCType.getNPCSoulIdList(this.townNPCId).length > 0 && TownType.isOpened(TownType.YangZhouCheng))
            {
                this._dialog.npcSlaveFeature = NPCDialogViewLang.ReplaceSoul;
            }
            return;
        }// end function

        private function renderData() : void
        {
            if (!this._dialog)
            {
                return;
            }
            var _loc_1:* = _ctrl.quest.npcInfoByNPCId;
            this._dialog.data = _loc_1;
            this._dialog.show();
            _view.center(sign, this._dialog.content);
            switch(this.npcSign)
            {
                case NPCType.LiDaNiang:
                {
                    _view.guide.trackPartners(2, this._dialog.content);
                    break;
                }
                case NPCType.ShuiLing:
                {
                    _view.guide.trackBeginner(2, this._dialog.content);
                    break;
                }
                case NPCType.CunZhang:
                {
                    _view.guide.trackBeginner(5, this._dialog.content);
                    break;
                }
                case NPCType.TieSuanPan:
                {
                    _view.guide.setPartnersIndex2(_ctrl.quest.npcInfoByNPCId.length);
                    _view.guide.trackPartners2(2, this._dialog.content);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onFeature() : void
        {
            var _loc_1:* = TownType.getNPCSign(_ctrl.player.mapId, this.townNPCId);
            var _loc_2:* = NPCType.getFunctionBySign(_loc_1);
            this.relatedView = null;
            var _loc_3:String = "";
            switch(_loc_2)
            {
                case NPCType.ItemShopNPC:
                case NPCType.EquiShopNPC:
                case NPCType.CardBuyNPC:
                {
                    _view.shop.shopNpcId = this.townNPCId;
                    _view.shop.show();
                    this.relatedView = _view.shop;
                    break;
                }
                case NPCType.WarehouseNPC:
                {
                    if (FunctionType.isOpened(FunctionType.Warehouse) == false)
                    {
                        _loc_3 = Lang.sprintf(NPCDialogViewLang.ZhuYinShang, MissionType.getSectionNameBySign(MissionType.XuYuHuanJing_1) + "1");
                        _view.alert.confirm(_loc_3);
                    }
                    else
                    {
                        _view.warehouse.npcId = this.townNPCId;
                        _view.warehouse.show();
                        this.relatedView = _view.warehouse;
                    }
                    break;
                }
                case NPCType.PartnersNPC:
                {
                    this._view.partnersNew.switchSelf();
                    this.relatedView = _view.partnersNew;
                    break;
                }
                case NPCType.ChooseCampNPC:
                {
                    _view.chooseCamp.switchSelf();
                    this.relatedView = _view.chooseCamp;
                    break;
                }
                case NPCType.ActivationKeysNPC:
                {
                    _view.activationKeys.show();
                    break;
                }
                case NPCType.FateNPC:
                {
                    if (FunctionType.isOpened(FunctionType.Fate))
                    {
                        _view.lodge.switchSelf();
                    }
                    else
                    {
                        _loc_3 = Lang.sprintf(NPCDialogViewLang.XuYuHuanJing8, MissionType.getSectionNameBySign(MissionType.XuYuHuanJing_1));
                        _view.alert.confirm(_loc_3);
                    }
                    break;
                }
                case NPCType.LuckyShopNPC:
                {
                    if (FunctionType.isOpened(FunctionType.LuckyShop))
                    {
                        _view.luckyShop.show();
                    }
                    else
                    {
                        _loc_3 = Lang.sprintf(NPCDialogViewLang.XuYuHuanJing2, MissionType.getSectionNameBySign(MissionType.XuYuHuanJing_1));
                        _view.alert.confirm(_loc_3);
                    }
                    break;
                }
                case NPCType.FactionMangerNPC:
                {
                    _view.luckyWheel.isInJiHuiSuo = true;
                    _view.luckyWheel.enter();
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.close();
            return;
        }// end function

        private function onSlaveFeature() : void
        {
            if (NPCType.getFunctionBySign(this.npcSign) == NPCType.CardBuyNPC && TownNPCType.getNPCSoulIdList(this.townNPCId).length > 0 && TownType.isOpened(TownType.YangZhouCheng))
            {
                this._view.sealShop.npcId = this.townNPCId;
                this._view.sealShop.show();
            }
            this.close();
            return;
        }// end function

        private function onAccept(param1:int, param2:String, param3:int, param4:int, param5:int) : void
        {
            var questId:* = param1;
            var questName:* = param2;
            var npcTalk:* = param3;
            var endTownId:* = param4;
            var endNPCId:* = param5;
            if (this._acceptList[questId])
            {
                return;
            }
            this._acceptList[questId] = 1;
            this._questId = questId;
            var callback:* = function () : void
            {
                if (QuestType.FavoriteQuestId == questId)
                {
                    close();
                    _view.addToFavorite();
                    _view.toolbar.loadQuestTrace();
                    delete _acceptList[questId];
                    return;
                }
                _view.chat.addSystemMessage(Lang.sprintf(NPCDialogViewLang.AcceptQuest, questName), 16773632);
                var handler:* = function () : void
                {
                    delete _acceptList[questId];
                    return;
                }// end function
                ;
                if (npcTalk == 1)
                {
                    _view.quest.markWayFinding();
                    if (_questId == 60)
                    {
                        _view.townMap.playShuShangDrama();
                    }
                    else if (_questId == 856)
                    {
                        _view.townMap.playWoLongDrama();
                    }
                    else if (endTownId != _ctrl.player.mapId)
                    {
                        _view.quest.wayFinding("npc," + endTownId + "," + endNPCId);
                    }
                    else if (QuestType.getType(questId) == QuestType.Master)
                    {
                        _view.quest.moveToNPC(endTownId, endNPCId);
                        close();
                        new activation.handler();
                        return;
                    }
                }
                else if (QuestType.getType(questId) == QuestType.Master)
                {
                    _view.quest.markWayFinding();
                    _view.quest.moveToMission(endTownId, QuestType.getMissionId(questId));
                    close();
                    new activation.handler();
                    return;
                }
                if (_ctrl.quest.isTwoCanOperate)
                {
                    recall_npc_info_by_npcid(handler);
                }
                else
                {
                    close();
                    new activation.handler();
                }
                return;
            }// end function
            ;
            _view.quest.accept_quest(questId, callback);
            return;
        }// end function

        public function rfQuest(param1:int) : void
        {
            delete this._acceptList[param1];
            return;
        }// end function

        private function onComplete(param1:int, param2:String) : void
        {
            var questId:* = param1;
            var questName:* = param2;
            this._questId = questId;
            if (this._completeList[questId])
            {
                return;
            }
            this._completeList[questId] = 1;
            var callback:* = function () : void
            {
                var _loc_1:int = 0;
                _view.toolbar.loadQuestTrace();
                switch(_ctrl.quest.completedState)
                {
                    case 0:
                    {
                        _view.showTip(NPCDialogViewLang.PackFull);
                        close();
                        break;
                    }
                    case -1:
                    {
                        _view.showTip(NPCDialogViewLang.QuestItem);
                        close();
                        break;
                    }
                    default:
                    {
                        _loc_1 = _ctrl.quest.awardItemId;
                        if (_loc_1 > 0)
                        {
                            _view.toolbar.playGoodsEffect(URI.goodsIconUrl + _loc_1 + ".png");
                            _view.chat.addSystemMessage(Lang.sprintf(NPCDialogViewLang.QuestAward, ItemType.getName(_loc_1)));
                        }
                        completeQuestCallback(questId, questName);
                        return;
                        break;
                    }
                }
                delete _completeList[questId];
                _view.guide.hideAlongGuide();
                return;
            }// end function
            ;
            _view.quest.complete_quest(questId, callback);
            return;
        }// end function

        private function completeQuestCallback(param1:int, param2:String) : void
        {
            var questId:* = param1;
            var questName:* = param2;
            _view.chat.addSystemMessage(Lang.sprintf(NPCDialogViewLang.QuestCompleted, questName), 16773632);
            _view.townMap.showQuestOk();
            var callback:* = function () : void
            {
                delete _completeList[questId];
                return;
            }// end function
            ;
            if (_ctrl.quest.hasQuestForNPC || _ctrl.quest.isTwoCanOperate)
            {
                this.recall_npc_info_by_npcid(callback);
            }
            else
            {
                this.callback();
                this.close();
            }
            return;
        }// end function

        private function onAcceptNextForGuide() : void
        {
            this._view.guide.hideTrack(GuideType.Partners2);
            return;
        }// end function

        private function onAcceptLastForGuide() : void
        {
            if (this.npcSign == NPCType.ShuiLing)
            {
                _view.guide.trackBeginner(3, this._dialog.content);
            }
            if (this.npcSign == NPCType.CunZhang)
            {
                _view.guide.trackBeginner(6, this._dialog.content);
            }
            return;
        }// end function

    }
}
