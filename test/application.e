note
	description: "JSON_RCP application root class"
	date: "$Date$"
	revision: "$Revision$"
class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
		do
			-- RPC Response object to json
			test_rpc_response_to_json
			test_rpc_response2_to_json
			test_rpc_response3_to_json
			test_rpc_response4_to_json

			-- RPC Ressponse Json to object
			test_json_to_rpc_response_object
			test_json2_to_rpc_response_object


			-- RPC Request object to json
			test_rcp_request_to_json
			test_rcp_request2_to_json
			test_rcp_request3_to_json
			test_rcp_request4_to_json
			test_rcp_request5_to_json

			-- RPC Request json to object
			test_json_to_rcp_object
			test_json2_to_rcp_object
		end

	test_rpc_response_to_json
			-- {"jsonrpc": "2.0", "result": 19, "id": 1}
		local
			j: JSON_RPC_RESPONSE
			conv: JSON_RPC_RESPONSE_CONVERTER
			l_id: JSON_RPC_ID
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")
			j.set_result (19)

			create l_id
			l_id.set_id (1)
			j.set_id (l_id)


			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_rpc_response2_to_json
			-- {"jsonrpc": "2.0", "result": -19, "id": 2}
		local
			j: JSON_RPC_RESPONSE
			conv: JSON_RPC_RESPONSE_CONVERTER
			l_id: JSON_RPC_ID
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")
			j.set_result (-19)

			create l_id
			l_id.set_id (2)
			j.set_id (l_id)


			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_rpc_response3_to_json
			--	{"jsonrpc": "2.0", "error": {"code": -32601, "message": "Method not found"}, "id": "1"}	
		local
			j: JSON_RPC_RESPONSE
			conv: JSON_RPC_RESPONSE_CONVERTER
			l_id: JSON_RPC_ID
			l_error: JSON_RPC_ERROR
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")

			create l_id
			l_id.set_id (1)
			j.set_id (l_id)

			create l_error.make (-32601, "Method not found")
			j.set_error (l_error)


			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_rpc_response4_to_json
			--	{"jsonrpc": "2.0", "error": {"code": -32600, "message": "Invalid Request"}, "id": null}
		local
			j: JSON_RPC_RESPONSE
			conv: JSON_RPC_RESPONSE_CONVERTER
			l_error: JSON_RPC_ERROR
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")


			create l_error.make (-32600, "Invalid Request")
			j.set_error (l_error)


			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_json_to_rpc_response_object
		local
			conv: JSON_RPC_RESPONSE_CONVERTER
		do
			create conv
			if attached json_value (jsonres) as l_value then
				if attached {JSON_RPC_RESPONSE} conv.from_json (l_value) as l_object then
					print (l_object.jsonrpc)
					io.put_new_line
					print (l_object.jresult)
					io.put_new_line
					if attached l_object.id as l_id then
						print (l_id.id)
						io.put_new_line
					end
				end
			end
		end

	test_json2_to_rpc_response_object
		local
			conv: JSON_RPC_RESPONSE_CONVERTER
		do
			create conv
			if attached json_value (jsonres2) as l_value then
				if attached {JSON_RPC_RESPONSE} conv.from_json (l_value) as l_object then
					print (l_object.jsonrpc)
					io.put_new_line
					if attached l_object.jresult then
						print (l_object.jresult)
						io.put_new_line
					end
					if attached l_object.error as l_error then
						print (l_error.code)
						io.put_new_line
						print (l_error.message)
						io.put_new_line
						if attached l_error.data as l_data then
							print (l_data)
							io.put_new_line
						end
					end
					if attached l_object.id as l_id then
						print (l_id.id)
						io.put_new_line
					end
				end
			end
		end


	test_rcp_request_to_json
			-- {"jsonrpc": "2.0", "method": "subtract", "params": [42, 23], "id": 1}
		local
			j: JSON_RPC_REQUEST
			conv: JSON_RPC_REQUEST_CONVERTER
			l_id: JSON_RPC_ID
			l_params: JSON_RPC_PARAMS
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")
			j.set_method ("subtract")

			create l_id
			l_id.set_id (1)
			j.set_id (l_id)

			create l_params.make_by_position
			l_params.add_by_position (42)
			l_params.add_by_position (23)
			j.set_params (l_params)

			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_rcp_request2_to_json
			-- {"jsonrpc": "2.0", "method": "subtract", "params": [42, 23], "id": "1"}
		local
			j: JSON_RPC_REQUEST
			conv: JSON_RPC_REQUEST_CONVERTER
			l_id: JSON_RPC_ID
			l_params: JSON_RPC_PARAMS
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")
			j.set_method ("subtract")
			create l_id
			l_id.set_id ("1")
			j.set_id (l_id)
			create l_params.make_by_position
			l_params.add_by_position (42)
			l_params.add_by_position (23)
			j.set_params (l_params)

			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_rcp_request3_to_json
			-- {"jsonrpc": "2.0", "method": "subtract", "params": [42, 23], "id": null}
		local
			j: JSON_RPC_REQUEST
			conv: JSON_RPC_REQUEST_CONVERTER
			l_id: JSON_RPC_ID
			l_params: JSON_RPC_PARAMS
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")
			j.set_method ("subtract")
			create l_id
			l_id.set_id (Void)
			j.set_id (l_id)

			create l_params.make_by_position
			l_params.add_by_position (42)
			l_params.add_by_position (23)
			j.set_params (l_params)

			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_rcp_request4_to_json
			-- {"jsonrpc": "2.0", "method": "subtract", "params": {"minuend": 42, "subtrahend": 23}, "id": 3}
		local
			j: JSON_RPC_REQUEST
			conv: JSON_RPC_REQUEST_CONVERTER
			l_id: JSON_RPC_ID
			l_params: JSON_RPC_PARAMS
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")
			j.set_method ("subtract")
			create l_id
			l_id.set_id (3)
			j.set_id (l_id)

			create l_params.make_by_name
			l_params.add_by_name ("minuend", 42)
			l_params.add_by_name ("subtrahend", 23)
			j.set_params (l_params)

			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end

	test_rcp_request5_to_json
			--  {"version": "2.0", "method": "confirmFruitPurchase", "params": [["apple", "orange", "mangoes"], 1.123], "id": "194521489"}
		local
			j: JSON_RPC_REQUEST
			conv: JSON_RPC_REQUEST_CONVERTER
			l_id: JSON_RPC_ID
			l_params: JSON_RPC_PARAMS
		do
			create conv
			create j
			j.set_jsonrpc ("2.0")
			j.set_method ("confirmFruitPurchase")
			create l_id
			l_id.set_id ("194521489")
			j.set_id (l_id)

			create l_params.make_by_position
--			l_params.add_by_position (<<"apple", "orange", "mangoes">>)
--			l_params.add_by_position (["apple", "orange", "mangoes"])
			l_params.add_by_position (1.123)
			j.set_params (l_params)

			if attached {JSON_VALUE} conv.to_json (j) as lj then
				print (lj.representation)
				io.put_new_line
			end
		end


	test_json_to_rcp_object
		local
			conv: JSON_RPC_REQUEST_CONVERTER
		do
			create conv
			if attached json_value (jsonrcp1) as l_value then
				if attached {JSON_RPC_REQUEST} conv.from_json (l_value) as l_object then
					print (l_object.jsonrpc)
					io.put_new_line
					print (l_object.method)
					io.put_new_line
					if attached l_object.params as l_params and then
						l_params.is_by_position and then
						attached l_params.by_position as l_position
					then
						across l_position as ic loop print (ic.item)
							io.put_new_line
						end
					end
					if attached l_object.id as l_id and then
						attached l_id.id as ll_id
					then
						print (ll_id)
					end

				end
			end
		end

	test_json2_to_rcp_object
		local
			conv: JSON_RPC_REQUEST_CONVERTER
		do
			create conv
			if attached json_value (jsonrcp2) as l_value then
				if attached {JSON_RPC_REQUEST} conv.from_json (l_value) as l_object then
					print (l_object.jsonrpc)
					io.put_new_line
					print (l_object.method)
					io.put_new_line
					if attached l_object.params as l_params and then
						l_params.is_by_name and then
						attached l_params.by_name as l_name
					then
						across l_name as ic loop
							print (ic.key)
							print (" - ")
							print (ic.item)
							io.put_new_line
						end
					end
					if attached l_object.id as l_id and then
						attached l_id.id as ll_id
					then
						print (ll_id)
					end

				end
			end
		end

	jsonrcp1: STRING = "[
			{
				"jsonrpc": "2.0", 
				"method": "subtract", 
				"params":[42, 23], 
				"id": 1
			}
	]"

	jsonrcp2: STRING = "[
	 	{
	 		"jsonrpc": "2.0", 
	 		"method": "subtract", 
	 		"params": {"minuend": 42, "subtrahend": 23}, 
	 		"id": 3
	 	}
	]"


	jsonres: STRING = "[
		{
			"jsonrpc": "2.0", 
			"result": -19, 
			"id": 2
		}
	]"

	jsonres2: STRING = "[
		{
			"jsonrpc": "2.0", 
			"error": {"code": -32601, "message": "Method not found"}, 
			"id": "1"
		}
	]"



	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

	json_value (json: STRING): detachable JSON_VALUE
		local
			p: like new_json_parser
		do
			p := new_json_parser (json)
			p.parse_content
			check
				json_is_parsed: p.is_valid
			end
			Result := p.parsed_json_value
		end

end
