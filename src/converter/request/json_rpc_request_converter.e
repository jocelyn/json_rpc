note
	description: "[
		JSON_RPC_CONVERTER  allow to go `from_json' and return a  object and `to_json' convert an object JSON_RCP_REQUEST into a JSON 
		representation
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_RPC_REQUEST_CONVERTER


feature -- Access

	from_json (j: JSON_VALUE): detachable JSON_RPC_REQUEST
			-- Convert from JSON value. Returns Void if unable to convert
		local
			ser: JSON_RPC_REQUEST_DESERIALIZER
			ctx: JSON_DESERIALIZER_CONTEXT
		do
			create ser
			create ctx
			Result := ser.from_json (j, ctx, Void)
		end

	to_json (o: JSON_RPC_REQUEST): JSON_VALUE
			-- Convert to JSON value
		local
			ser: JSON_RPC_REQUEST_SERIALIZER
			ctx: JSON_SERIALIZER_CONTEXT
		do
			create ser
			create ctx
			Result := ser.to_json (o, ctx)
		end

end
