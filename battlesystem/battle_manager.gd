extends Node

var party_members = []
var enemies = []

enum BattleState { OVERWORLD, BATTLE_START, TURN_START, TURN_EXECUTE, TURN_END, BATTLE_END, WIN, GAME_OVER }

var battle_state: BattleState:
	set(value):
		match value:
			BattleState.BATTLE_START:
				start_battle()
			BattleState.TURN_START:
				start_turn()
			BattleState.TURN_EXECUTE:
				execute_turn()
			BattleState.TURN_END:
				end_turn()
			BattleState.BATTLE_END:
				end_battle()
			BattleState.WIN:
				win()
			BattleState.GAME_OVER:
				game_over()

func _ready():
	battle_state = BattleState.OVERWORLD

# Methods for each of the states for the battle
func initialize_battle():
	battle_state = BattleState.BATTLE_START

func start_battle():
	print("Battle Start")
	
func start_turn():
	pass

func execute_turn():
	pass

func end_turn():
	pass
	
func end_battle():
	pass
	
func win():
	pass

func game_over():
	pass
