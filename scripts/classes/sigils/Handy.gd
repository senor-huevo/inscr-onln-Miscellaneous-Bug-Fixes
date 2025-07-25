extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):

	# attached_card_summoned represents the card bearing the sigil being summoned
	if event == "card_summoned" and params[0] == card:
		
		# Discard hand
		for hCard in fightManager.handManager.get_node("PlayerHand" if is_friendly else "EnemyHand").get_children():
			var Ha =  hCard.get_parent().get_parent().raisedCard if is_friendly else hCard.get_parent().get_parent().opponentRaisedCard
			if hCard != Ha:
				hCard.get_node("AnimationPlayer").play("Discard")

		if is_friendly:
			yield(fightManager.get_tree().create_timer(0.05), "timeout")
			
			var mainDeckCards
			if fightManager.side_deck.size() == 0:
				mainDeckCards = 4
			else:
				mainDeckCards = 3
				
				fightManager.draw_card(fightManager.side_deck.pop_front(), fightManager.get_node("DrawPiles/YourDecks/SideDeck"))

				if fightManager.side_deck.size() == 0:
					fightManager.get_node("DrawPiles/YourDecks/SideDeck").visible = false
		
			for _i in range(mainDeckCards):
				if fightManager.deck.size() == 0:
					break
				
				fightManager.draw_card(fightManager.deck.pop_front(), fightManager.get_node("DrawPiles/YourDecks/Deck"))
				
				# Some interaction here if your deck has less than 3 cards. Don't punish I guess?
				if fightManager.deck.size() == 0:
					fightManager.get_node("DrawPiles/YourDecks/Deck").visible = false
					break
