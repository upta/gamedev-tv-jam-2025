class_name GuideService extends Node

var local_context: GUIDEMappingContext


func add_global_context(context: GUIDEMappingContext):
	GUIDE.enable_mapping_context(context, false)


func set_local_context(context: GUIDEMappingContext):
	if local_context:
		GUIDE.disable_mapping_context(local_context)

	GUIDE.enable_mapping_context(context, false)
	local_context = context
