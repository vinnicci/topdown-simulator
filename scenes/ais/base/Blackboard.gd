extends Node
class_name Blackboard


export(Array, NodePath) var agents: Array
var blackboard: Dictionary = {}


func init_blackboard():
	for agent_path in agents:
		var agent_node = get_node_or_null(agent_path)
		if agent_node.has_node("AI"):
			var ai = agent_node.get_node("AI")
			ai.blackboards[name] = self
