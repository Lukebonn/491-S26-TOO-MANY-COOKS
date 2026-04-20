class_name PickupData
extends Resource
#This script is attached to Pickup resources, which are used in Enemies for drops.
#To make new a Pickup resource: create a new empty Resource in the PickupData folder,
#then attach this script to that Resource.

##The PackedScene to spawn if this Pickup is chosen to be dropped.
@export var SceneToSpawn : PackedScene
##The minimum (x) and maximum (y) amount of this Pickup that can spawn.
@export var DropCountRange : Vector2
##The chance of this Pickup being spawned to begin with.
@export var DropChance : float
