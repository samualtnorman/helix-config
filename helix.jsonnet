#!/usr/bin/env -S jsonnet -m . -S --ext-str pbInclude=${PROTOBUF_INCLUDE}
local languages = import "deps/languages.json";
local schemaStore = import "deps/schemastore.json";

local hasTag(value, tag) = std.isObject(value) && std.get(value, tag, false);
local SomeTag = "Emhpiw_RvWRI31sq7gk-A";
local NoneTag = "gf2sCK9Ng15eTsBEeRijx";
local isSome(value) = hasTag(value, SomeTag);
local isNone(value) = hasTag(value, NoneTag);
local isOption(value) = isSome(value) || isNone(value);

local Some(value) = {
	[SomeTag]: true,
	map(callback): Some(callback(value)),
	flatMap(callback):
		local newValue = callback(value);
		if isOption(newValue) then newValue else error "Expected Option",
	unwrap: value,
	unwrapOr(default): value
};

local None = {
	[NoneTag]: true,
	map(callback): None,
	flatMap(callback): None,
	unwrap: error "Tried to unwrap None",
	unwrapOr(default): default
};

local LanguageServer(object) = { [field]: { command: field } + object[field] for field in std.objectFields(object) };

local arrayFilterIndexes(array, callback) = [
	index for index in std.range(0, std.length(array) - 1) if callback(array[index], index, array)
];

local arrayFindIndex(array, callback) =
	local indexes = arrayFilterIndexes(array, callback);
	if std.length(indexes) == 0 then None else Some(indexes[0]);

local arrayFind(array, callback) = arrayFindIndex(array, callback).map(function(index) array[index]);
local get(object, field) = if std.objectHas(object, field) then Some(object[field]) else None;

local Language(object) = [
	{
		name: field,
		indent: { "tab-width": 4, unit: "" }
	} + object[field] + {
		"language-servers": [ "simple-completion-language-server" ] +
			arrayFind(languages.language, function(item, index, array) item.name == field)
				.flatMap(function(item) get(item, "language-servers"))
				.unwrapOr([]) +
			std.get(object[field], "language-servers", [])
	}
	for field in std.objectFields(object)
];

{
	"config.toml": std.manifestTomlEx({
		// theme: "rose_pine",
		theme: "catppuccin_mocha",
		// theme: "base16_terminal",
		editor: {
			cursorline: true,
			"auto-format": false,
			rulers: [ 80, 120 ],
			"color-modes": true,
			"cursor-shape": { insert: "bar", normal: "block", select: "underline" },
			whitespace: { render: { tab: "all" } },
			"end-of-line-diagnostics": "hint",
			"file-picker": { hidden: false }
		},
		keys: {
			normal: {
				" ": { o: ":lsp-workspace-command _typescript.organizeImports \"%sh{realpath %{buffer_name}}\"" },
				"H": "move_prev_word_end",
				"L": "move_next_word_start",
				"'": {
					"c": ":buffer-close",
					"C": ":buffer-close!"
				}
				// "C-j": [
				// 	"goto_line_end_newline",
				// 	"join_selections",
				// 	"move_prev_sub_word_end",
				// 	"move_next_sub_word_start",
				// 	"delete_selection"
				// ]
			}
		}
	}, "\t"),

	"languages.toml": std.manifestTomlEx({
		"language-server": LanguageServer({
			"nginx-language-server": {},
			"emmet-language-server": { args: [ "--stdio" ] },
			"simple-completion-language-server": {},
			"tailwindcss-language-server": {},
			"wasm-language-server": { command: "wat_server" },
			"protols": { command: "protols", args: [ "--include-paths", std.extVar("pbInclude") ] },
			"unocss-language-server": { args: [ "--stdio" ] },
			"vscode-json-language-server": {
				args: [ "--stdio" ],
				config: { provideFormatter: true, json: { validate: { enable: true }, schemas: schemaStore } }
			},
			deno: { args: [ "lsp" ], config: { enable: true } },
			eslint: {
				command: "vscode-eslint-language-server",
				args: [ "--stdio" ],
				config: {
					nodePath: "",
					validate: "on",
					problems: { shortenToSingleLine: false },
					run: "onType",
					rulesCustomizations: [],
					experimental: {},
					codeAction: {
						disableRuleComment: { enable: true, location: "separateLine" },
						showDocumentation: { enable: true }
					}
					// format: { enable: true },
					// codeActionsOnSave: { mode: "all", "source.fixAll.eslint": true },
				}
			}
		}),
		language: Language({
			typescript: {
				"auto-pairs": { "(": ")", "{": "}", "[": "]", "\"": "\"", "`": "`", "<": ">" },
				"language-servers": [ "deno", "eslint", "effect-language-service" ]
			},
			tsx: {
				"auto-pairs": { "(": ")", "{": "}", "[": "]", "\"": "\"", "`": "`", "<": ">" },
				"language-servers": [ "emmet-language-server", "tailwindcss-language-server", "unocss-language-server" ]
			},
			toml: { "auto-pairs": { "[": "]", "\"": "\"", "{": "}" }, roots: [ "." ] },
			json: { "auto-pairs": { "[": "]", "{": "}", "\"": "\"" } },
			nginx: { "auto-pairs": { "\"": "\"", "{": "}" } },
			jsonnet: {},
			wat: { "language-servers": [ "wasm-language-server" ] },
			javascript: { "language-servers": [ "deno", "eslint" ] },
			jsonc: {},
			css: {},
			protobuf: { "language-servers": [ "protols" ] },
			graphql: {},
			bash: {},
			html: {},
			markdown: {},
			tsq: {}
		})
	}, "\t")
}
