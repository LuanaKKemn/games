extends Node

@export var cena_canos: PackedScene
var move_cenario = 200
var tamanho_tela

var canos = []
var pontos = 0
enum GameState {rodando, morto}
var controle

func _ready() -> void:
	tamanho_tela = get_window().size
	gerarCanos()
	controle = GameState.rodando
	$Pontuacao.text = "0"
	$TelaDerrota.hide()

func _physics_process(delta: float) -> void:
	if controle == GameState.rodando:
		$"Chão".position.x -= move_cenario * delta
		if $"Chão".position.x < 0:
			$"Chão".position.x = 864

		for cano in canos:
			cano.position.x -= move_cenario * delta

func gerarCanos():
	var cano = cena_canos.instantiate()
	cano.position.x = tamanho_tela.x + move_cenario
	cano.position.y = tamanho_tela.y / 2 + randi_range(-200, +200)
	
	cano.get_node("ZonaDePonto").body_entered.connect(_on_zona_de_ponto_body_entered)

	add_child(cano)
	canos.append(cano)

func _on_timer_timeout() -> void:
	gerarCanos()

func game_over():
	if controle != GameState.morto:
		$TelaDerrota.show()
		controle = GameState.morto
		$Timer.stop()

func _on_chão_body_entered(body: Node2D) -> void:
	game_over()

func _on_cano_body_entered(body: Node2D) -> void:
	game_over()

func _on_zona_de_ponto_body_entered(body: Node2D) -> void:
	if body.name == "Passaro" and controle == GameState.rodando:
		pontos += 1
		$Pontuacao.text = str(pontos)

func _on_BotaoReiniciar_pressed():
	get_tree().reload_current_scene()
