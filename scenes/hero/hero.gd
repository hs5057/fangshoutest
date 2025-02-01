class_name Hero
extends CharacterBody2D

signal 血量值变动了
signal 魔法值变动了

@export var 最大血量值 : int = 100
@onready var 当前血量值 : int = 最大血量值
@export var 血量恢复 : int = 1
@export var 最大魔法值 : int = 100
@onready var 当前魔法值 : int = 0
@export var 魔法恢复 : int = 1
@export var 攻击力 : int = 10
@export var 防御力 : int = 2
@export var 暴击率 : int = 0
@export var 暴击伤害 : int = 100
