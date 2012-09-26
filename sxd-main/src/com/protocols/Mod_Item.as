package com.protocols
{
    import com.*;

    public class Mod_Item extends Object
    {

        public function Mod_Item()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Item_Base.dismount_transport, param1.item.dismount_transport);
            param1.registerDataCallback(Mod_Item_Base.avatar_card_off, param1.item.avatar_card_off);
            param1.registerDataCallback(Mod_Item_Base.classify_pack, param1.item.classify_pack);
            param1.registerDataCallback(Mod_Item_Base.classify_warehouse, param1.item.classify_warehouse);
            param1.registerDataCallback(Mod_Item_Base.add_pack_grid, param1.item.add_pack_grid);
            param1.registerDataCallback(Mod_Item_Base.add_warehouse_grid, param1.item.add_warehouse_grid);
            param1.registerDataCallback(Mod_Item_Base.get_empty_grid_number, param1.item.get_empty_grid_number);
            param1.registerDataCallback(Mod_Item_Base.get_item_basical_infos, param1.item.get_item_basical_infos);
            param1.registerDataCallback(Mod_Item_Base.get_player_warehouse_grids, param1.item.get_player_warehouse_grids);
            param1.registerDataCallback(Mod_Item_Base.get_player_pack_item_list, param1.item.get_player_pack_item_list);
            param1.registerDataCallback(Mod_Item_Base.get_role_equip_list, param1.item.get_role_equip_list);
            param1.registerDataCallback(Mod_Item_Base.get_npc_item_list, param1.item.get_npc_item_list);
            param1.registerDataCallback(Mod_Item_Base.get_npc_recycle_item_list, param1.item.get_npc_recycle_item_list);
            param1.registerDataCallback(Mod_Item_Base.get_player_role_equip_list, param1.item.get_player_role_equip_list);
            param1.registerDataCallback(Mod_Item_Base.change_pack_item_grid, param1.item.change_pack_item_grid);
            param1.registerDataCallback(Mod_Item_Base.change_warehouse_item_grid, param1.item.change_warehouse_item_grid);
            param1.registerDataCallback(Mod_Item_Base.move_pack_grid_item_to_warehouse, param1.item.move_pack_grid_item_to_warehouse);
            param1.registerDataCallback(Mod_Item_Base.move_warehouse_grid_item_to_pack, param1.item.move_warehouse_grid_item_to_pack);
            param1.registerDataCallback(Mod_Item_Base.drop_pack_grid_item, param1.item.drop_pack_grid_item);
            param1.registerDataCallback(Mod_Item_Base.drop_warehouse_grid_item, param1.item.drop_warehouse_grid_item);
            param1.registerDataCallback(Mod_Item_Base.remove_player_role_equipment, param1.item.remove_player_role_equipment);
            param1.registerDataCallback(Mod_Item_Base.equip_player_role_item, param1.item.equip_player_role_item);
            param1.registerDataCallback(Mod_Item_Base.player_buy_npc_item, param1.item.player_buy_npc_item);
            param1.registerDataCallback(Mod_Item_Base.player_sell_item, param1.item.player_sell_item);
            param1.registerDataCallback(Mod_Item_Base.player_buy_back_item, param1.item.player_buy_back_item);
            param1.registerDataCallback(Mod_Item_Base.player_use_grid_item, param1.item.player_use_grid_item);
            param1.registerDataCallback(Mod_Item_Base.player_use_grid_reel, param1.item.player_use_grid_reel);
            param1.registerDataCallback(Mod_Item_Base.player_use_grid_elixir, param1.item.player_use_grid_elixir);
            param1.registerDataCallback(Mod_Item_Base.get_facture_reel_data, param1.item.get_facture_reel_data);
            param1.registerDataCallback(Mod_Item_Base.get_player_role_elixir_data, param1.item.get_player_role_elixir_data);
            param1.registerDataCallback(Mod_Item_Base.has_level_gift_item, param1.item.has_level_gift_item);
            param1.registerDataCallback(Mod_Item_Base.player_get_super_gift, param1.item.player_get_super_gift);
            param1.registerDataCallback(Mod_Item_Base.get_player_role_elixir_record, param1.item.get_player_role_elixir_record);
            param1.registerDataCallback(Mod_Item_Base.player_use_ingot_elixir, param1.item.player_use_ingot_elixir);
            param1.registerDataCallback(Mod_Item_Base.player_reel_need_item, param1.item.player_reel_need_item);
            param1.registerDataCallback(Mod_Item_Base.player_equip_use_reel, param1.item.player_equip_use_reel);
            param1.registerDataCallback(Mod_Item_Base.get_player_item_facture_reel_data, param1.item.get_player_item_facture_reel_data);
            param1.registerDataCallback(Mod_Item_Base.notify_super_gift_items, param1.item.notify_super_gift_items);
            param1.registerDataCallback(Mod_Item_Base.change_attack_info, param1.item.change_attack_info);
            param1.registerDataCallback(Mod_Item_Base.change_attack_item, param1.item.change_attack_item);
            param1.registerDataCallback(Mod_Item_Base.can_change_list, param1.item.can_change_list);
            param1.registerDataCallback(Mod_Item_Base.can_use_gold_info, param1.item.can_use_gold_info);
            param1.registerDataCallback(Mod_Item_Base.use_gold_oil, param1.item.use_gold_oil);
            param1.registerDataCallback(Mod_Item_Base.get_equipment_list, param1.upgrade.get_equipment_list);
            param1.registerDataCallback(Mod_Item_Base.equip_upgrade_stat, param1.upgrade.equip_upgrade_stat);
            param1.registerDataCallback(Mod_Item_Base.upgrade_equip, param1.upgrade.upgrade_equip);
            param1.registerDataCallback(Mod_Item_Base.clear_upgrade_cd_time, param1.upgrade.clear_upgrade_cd_time);
            param1.registerDataCallback(Mod_Item_Base.open_upgrade_opportunity, param1.upgrade.open_upgrade_opportunity);
            param1.registerDataCallback(Mod_Item_Base.equip_upgrade_stat_list, param1.upgrade.equip_upgrade_stat_list);
            param1.registerDataCallback(Mod_Item_Base.permanent_clean_item_update_cd, param1.upgrade.permanent_clean_item_update_cd);
            param1.registerDataCallback(Mod_Item_Base.get_permanent_clean_item_update_cd, param1.upgrade.get_permanent_clean_item_update_cd);
            param1.registerDataCallback(Mod_Item_Base.lucky_shop_item_list, param1.luckyShop.lucky_shop_item_list);
            param1.registerDataCallback(Mod_Item_Base.lucky_shop_record_list, param1.luckyShop.lucky_shop_record_list);
            param1.registerDataCallback(Mod_Item_Base.buy_lucky_shop_item, param1.luckyShop.buy_lucky_shop_item);
            param1.registerDataCallback(Mod_Item_Base.refresh_lucky_shop, param1.luckyShop.refresh_lucky_shop);
            param1.registerDataCallback(Mod_Item_Base.get_soul, param1.item.get_soul);
            param1.registerDataCallback(Mod_Item_Base.get_the_item_num, param1.item.get_the_item_num);
            param1.registerDataCallback(Mod_Item_Base.get_gold_oil, param1.item.get_gold_oil);
            param1.registerDataCallback(Mod_Item_Base.take_off_clothes, param1.item.take_off_clothes);
            param1.registerDataCallback(Mod_Item_Base.open_furnace, param1.item.openFurnace);
            param1.registerDataCallback(Mod_Item_Base.drag_furnace_item, param1.item.dragFurnaceItem);
            param1.registerDataCallback(Mod_Item_Base.swap_card, param1.item.swap_card);
            param1.registerDataCallback(Mod_Item_Base.tian_di_yu_pai, param1.item.tian_di_yu_pai);
            return;
        }// end function

    }
}
