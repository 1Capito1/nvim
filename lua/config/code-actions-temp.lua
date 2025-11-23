local null_ls = require("null-ls")

local function text(n)
	return n and vim.treesitter.get_node_text(n, 0) or nil
end

local function get_node_at_cursor()
	local pos = vim.api.nvim_win_get_cursor(0)
	return vim.treesitter.get_node({
		bufnr = 0,
		pos = { pos[1] - 1, pos[2] },
	})
end

local function find_ancestor(n, pred)
	local cur = n
	while cur do
		if pred(cur) then
			return cur
		end
		cur = cur:parent()
	end
	return nil
end

local function first_desc(n, want)
	local function walk(x)
		if not x then
			return nil
		end
		if x:type() == want then
			return x
		end
		for i = 0, x:named_child_count() - 1 do
			local got = walk(x:named_child(i))
			if got then
				return got
			end
		end
		return nil
	end
	return walk(n)
end

local function grab_name_node(fdecl)
	-- The function name is the declarator field of the function_declarator
	-- NOT a descendant identifier (which could be a parameter)
	local declarator = fdecl:field("declarator")[1]

	if declarator then
		-- The declarator itself might be what we want, or it might contain the name
		local dtype = declarator:type()
		if dtype == "identifier" or dtype == "operator_name" or dtype == "destructor_name" then
			return declarator
		end
		-- If it's a field_identifier or qualified_identifier, look for the name part
		if dtype == "field_identifier" or dtype == "qualified_identifier" then
			return declarator
		end
	end

	-- Fallback: try to find these node types as direct children (not descendants)
	for i = 0, fdecl:named_child_count() - 1 do
		local child = fdecl:named_child(i)
		local ctype = child:type()
		if
			ctype == "identifier"
			or ctype == "operator_name"
			or ctype == "destructor_name"
			or ctype == "field_identifier"
		then
			-- Make sure this isn't inside the parameter_list
			local parent = child:parent()
			if parent and parent:type() ~= "parameter_list" and parent:type() ~= "parameter_declaration" then
				return child
			end
		end
	end

	return nil
end

local function generate_function_declaration()
	local node = get_node_at_cursor()
	if not node then
		return nil, "no node at cursor"
	end

	local namespace = find_ancestor(node, function(n)
		local t = n:type()
		return t == "namespace_definition"
	end)

	local namespace_name = ""
	if namespace then
		namespace_name = namespace:field("name")[1] and text(namespace:field("name")[1])
	end

	local class = find_ancestor(node, function(n)
		local t = n:type()
		return t == "class_specifier" or t == "struct_specifier"
	end)
	local class_name = ""
	if class then
		class_name = class:field("name")[1] and text(class:field("name")[1])
	end
	local container = find_ancestor(node, function(n)
		local t = n:type()
		return t == "field_declaration" or t == "declaration"
	end)

	if not container then
		return nil, "not a method declaration"
	end

	local fdecl = first_desc(container, "function_declarator")
	if not fdecl then
		return nil, "No function_declarator found"
	end

	local name_node = grab_name_node(fdecl)
	if not name_node then
		return nil, "could not find a method name"
	end

	local function_name = text(name_node)
	if not function_name or function_name == "" then
		return nil, "Empty method name"
	end
	if function_name:find("::", 1, true) then
		return nil, "Already qualified"
	end

	local rtype_node = container:field("type") and container:field("type")[1]
	local rtype = rtype_node and text(rtype_node) or nil

	local params_node = first_desc(fdecl, "parameter_list")
	local params = params_node and text(params_node) or ""

	local namespace_qualifier = ""
	if not namespace_name or namespace_name ~= "" then
		namespace_qualifier = namespace_name .. "::"
	end

	local class_qualifier = ""
	if not class_name or class_name ~= "" then
		class_qualifier = class_name .. "::"
	end

	local type = (rtype and (rtype .. " ") or "")

	local qualified = type .. namespace_qualifier .. class_qualifier .. function_name .. params .. "{}"
	return qualified
end

local function get_corresponding_cpp_file(header_path)
	local base = header_path:match("(.+)%.[^.]+$")
	if not base then
		return nil
	end
	return base .. ".cpp"
end

--TODO: Remove, testing purposes only
vim.api.nvim_create_user_command("CppQualifyMethod", function()
	local out, err = generate_function_declaration()
	if not out then
		vim.notify("Qualify Method: " .. err, vim.log.levels.WARN)
	else
		vim.notify("Qualified -> " .. out, vim.log.levels.INFO)
	end

	print(out)
end, {})

local generate_definition_action = {
	name = "generate_cpp_definition",
	method = null_ls.methods.CODE_ACTION,
	filetypes = { "cpp", "c" },
	generator = {
		fn = function(params)
			local result, err = generate_function_declaration()
			if not result then
				return nil
			end

			return {
				{
					title = "Generate method definition in .cpp file",
					action = function()
						local current_file = vim.api.nvim_buf_get_name(params.bufnr)
						local cpp_file = get_corresponding_cpp_file(current_file)

						if not cpp_file then
							vim.notify("Could not determine .cpp file path", vim.log.levels.ERROR)
							return
						end

						local file_exists = vim.fn.filereadable(cpp_file) == 1
						vim.cmd("edit " .. vim.fn.fnameescape(cpp_file))

						local cpp_bufnr = vim.api.nvim_get_current_buf()

						local line_count = vim.api.nvim_buf_line_count(cpp_bufnr)
						local lines = vim.split(result, "\n")

						if line_count > 1 or vim.api.nvim_buf_get_lines(cpp_bufnr, 0, 1, false)[1] ~= "" then
							table.insert(lines, 1, "")
						end
						vim.api.nvim_buf_set_lines(cpp_bufnr, line_count, line_count, false, lines)

						vim.api.nvim_win_set_cursor(0, { line_count + #lines - 1, 1 })

						if file_exists then
							vim.notify(
								"Definition added to " .. vim.fn.fnamemodify(cpp_file, ":t"),
								vim.log.levels.INFO
							)
						else
							vim.notify(
								"Created " .. vim.fn.fnamemodify(cpp_file, ":t") .. " and added definition",
								vim.log.levels.INFO
							)
						end
					end,
				},
			}
		end,
	},
}

null_ls.register(generate_definition_action)
null_ls.setup({})
