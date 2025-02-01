class_name Enemy
extends CharacterBody2D

signal 血量值变动了
signal 魔法值变动了

@export var 最大血量值 : int = 100
@onready var 当前血量值 : int = 最大血量值
@export var 攻击力 : int = 10
@export var 防御力 : int = 2
@export var 暴击率 : int = 0
@export var 暴击伤害 : int = 100

#是否有攻击目标，如果没有则朝核心移动
var have_attack_target : bool = false
#是否处于攻击中
var on_attacking : bool = false
#是否可以攻击
var can_attack : bool = false
