extends SigilEffect

#Used for sigils that do something at the start of the turn
func start_of_turn(card_anim):
	card_anim.play("Evolve")
	yield (card_anim, "animation_finished")

	# Deep copy
	var dmgTaken = card.card_data["health"] - card.health
	var new_sigs: Array = card.card_data.sigils.duplicate()
	new_sigs.erase("Fledgling 2")
	new_sigs.append("Fledgling")
	card.card_data.sigils = new_sigs
	card.from_data(card.card_data)
	card.health = card.card_data["health"] - dmgTaken
	
	slotManager.recalculate_buffs_and_such()
#	for fcard in slotManager.all_friendly_cards():
#		fcard.calculate_buffs()
#	for eCard in slotManager.all_enemy_cards():
#		eCard.calculate_buffs()


	

