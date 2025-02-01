extends Hero

@onready var health_timer: Timer = %HealthTimer
@onready var magic_timer: Timer = %magicTimer
@onready var detection_area: Area2D = %DetectionArea
@onready var attack_area: Area2D = %AttackArea
@onready var animation_player: AnimationPlayer = %AnimationPlayer


var enemies_count : int = 0
var current_chase_target : Enemy
var current_attack_target : Enemy
var chase_enemies : Array[Enemy] = []
var attack_enemies : Array[Enemy] = []

func _ready() -> void:
	health_timer.start()
	magic_timer.start()
	health_timer.timeout.connect(_on_health_timer_timeout)
	magic_timer.timeout.connect(_on_magic_timer_timeout)
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)
	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.body_exited.connect(_on_attack_area_body_exited)
	pass

func _physics_process(delta: float) -> void:
	if current_chase_target:
		chase_enemy(current_chase_target)
	

func attack_enemy( current_target : Enemy ) -> void:
	if current_target == null:
		return
	
	animation_player.play("attack")
	

# 追逐敌人
func chase_enemy( current_target : Enemy ) -> void:
	if current_target == null:
		return
	
	# 计算玩家到目标敌人的方向
	var direction = (current_target.global_position - global_position).normalized()
	
	# 移动玩家
	velocity = direction * 移动速度
	move_and_slide()  # 如果是 CharacterBody2D 或 KinematicBody2D

	# 可选：让玩家面向敌人
	#look_at(current_target.global_position)
	
	pass

# 寻找距离最近的敌人
func find_closest_enemy(enemies) -> Enemy:
	var closest_enemy: Enemy = null
	var closest_distance: float = INF  # 初始化为无穷大

	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy

	return closest_enemy


func _on_health_timer_timeout() -> void:
	当前血量值 = clampi( 当前血量值 + 血量恢复, 0, 100 )
	#print( "当前血量值：" , 当前血量值 )
	血量值变动了.emit()
	health_timer.start()
	pass


func _on_magic_timer_timeout() -> void:
	当前魔法值 = clampi( 当前魔法值 + 魔法恢复, 0, 100 )
	#print( "当前魔法值：",当前魔法值 )
	魔法值变动了.emit()
	magic_timer.start()
	pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	
	if body is Enemy:
		chase_enemies.append(body)
		enemies_count += 1
		if current_chase_target == null and current_attack_target == null:
			current_chase_target = body
			$StateChart.send_event( "body_entered" )

	pass


func _on_detection_area_body_exited(body: Node2D) -> void:
	
	if body is Enemy:
		chase_enemies.erase(body)
		enemies_count -= 1
		# 如果敌人总数小于1，则发送信号，进入IDEL状态
		if enemies_count < 1:
			current_chase_target = null
			$StateChart.send_event( "body_exited" )
			return
		# 如果敌人总数大于0，且当前目标为空了，则重新寻找并追逐最近的敌人
		if current_chase_target == body:
			current_chase_target = find_closest_enemy(chase_enemies)
			$StateChart.send_event( "find_body" )
	
	pass


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		attack_enemies.append(body)
		current_chase_target = null
		if current_attack_target == null:
			current_attack_target = body
			$StateChart.send_event( "can_attack" )
	pass


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body is Enemy:
		attack_enemies.erase(body)
		if enemies_count < 1:
			$StateChart.send_event( "stop_attack" )
			return

		print("current_attack_target:",current_attack_target)
		print("body:",body)
		
			
		if current_attack_target == body:
			print("current_attack_target == body")
			current_attack_target = null
			if attack_enemies.is_empty():
				print("attack_enemies.is_empty")
				$StateChart.send_event( "find_body" )
				current_chase_target = find_closest_enemy(chase_enemies)
			else:
				current_attack_target = find_closest_enemy(attack_enemies)
				#$StateChart.send_event( "can_attack" )
			
	pass


func _on_attack_state_processing(delta: float) -> void:
	animation_player.play("attack")
	pass # Replace with function body.


func _on_chase_state_processing(delta: float) -> void:
	animation_player.play("run")
	pass # Replace with function body.


func _on_idle_state_processing(delta: float) -> void:
	animation_player.play("idle")
	pass # Replace with function body.
