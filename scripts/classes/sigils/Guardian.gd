extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):
	
	if card.get_parent().name == "PlayerHand":
		return

	var oFriendly = params[0].get_parent().get_parent().name == "PlayerSlots"

	# attached_card_summoned represents the card bearing the sigil being summoned
	if event == "card_summoned" and is_friendly != oFriendly:

		var slot = params[0].slot_idx()

		if slotManager.is_slot_empty(slotManager.player_slots[slot] if is_friendly else slotManager.enemy_slots[slot]):
			var guardians = slotManager.get_friendly_cards_sigil("Guardian") if is_friendly else slotManager.get_enemy_cards_sigil("Guardian")
			if guardians:
				# slotManager.rpc_id(fightManager.opponent, "remote_card_move", guardians[0].slot_idx(), slot, false)
				guardians[0].move_to_parent(slotManager.player_slots[slot] if is_friendly else slotManager.enemy_slots[slot])
		
