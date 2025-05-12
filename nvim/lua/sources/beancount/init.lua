---@module 'blink-cmp'
---@class blink.cmp.Source
local source = {}

function source:_load_entities(account_path)
    vim.api.nvim_exec2(
        string.format(
            [[python3 <<EOB
from beancount.loader import load_file
from beancount.core import getters

entries, _, _ = load_file('%s')
accounts = (k for k, v in getters.get_account_open_close(entries).items() if v[1] is None)
links = getters.get_all_links(entries)
tags = getters.get_all_tags(entries)
f = lambda l: ','.join(f'"{s}"' for s in sorted(l))
vim.command('let b:beancount_accounts = [{}]'.format(f(accounts)))
vim.command('let b:beancount_tags = [{}]'.format(f(tags)))
vim.command('let b:beancount_links = [{}]'.format(f(links)))
EOB]],
            account_path
        ),
        { output = true }
    )

    local items = {}

    for _, s in ipairs(vim.b.beancount_accounts or {}) do
        table.insert(items, {
            label = s,
            kind = require("blink.cmp.types").CompletionItemKind.Property,
        })
    end

    for _, s in ipairs(vim.b.beancount_tags) do
        table.insert(items, {
            label = "#" .. s,
            kind = require("blink.cmp.types").CompletionItemKind.Property,
        })
    end

    for _, s in ipairs(vim.b.beancount_links) do
        table.insert(items, {
            label = "^" .. s,
            kind = require("blink.cmp.types").CompletionItemKind.Property,
        })
    end

    self.cached_items = items
end

function source.new(opts)
    vim.validate("beancount.opts.account", opts.account, "string")

    local self = setmetatable({}, { __index = source })
    self.opts = opts
    self.cached_items = {}
    self.loading = true
    self:_load_entities(self.opts.account)


    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.beancount",
        callback = function()
            if self and type(self._load_entities) == "function" then
                self:_load_entities(self.opts.account)
            end
        end,
    })
    return self
end

function source:enabled()
    return vim.bo.filetype == "beancount"
end

function source:get_trigger_characters()
    return {
        "Ex",
        "In",
        "As",
        "Li",
        "Eq",
        "E:",
        "I:",
        "A:",
        "L:",
        "#",
        "^",
    }
end

function source:get_completions(ctx, callback)
    -- ctx (context) contains the current keyword, cursor position, bufnr, etc.

    -- You should never filter items based on the keyword, since blink.cmp will
    -- do this for you

    -- The callback _MUST_ be called at least once. The first time it's called,
    -- blink.cmp will show the results in the completion menu. Subsequent calls
    -- will append the results to the menu to support streaming results.
    callback({
        items = self.cached_items,
        -- Whether blink.cmp should request items when deleting characters
        -- from the keyword (i.e. "foo|" -> "fo|")
        -- Note that any non-alphanumeric characters will always request
        -- new items (excluding `-` and `_`)
        is_incomplete_backward = false,
        -- Whether blink.cmp should request items when adding characters
        -- to the keyword (i.e. "fo|" -> "foo|")
        -- Note that any non-alphanumeric characters will always request
        -- new items (excluding `-` and `_`)
        is_incomplete_forward = false,
    })

    -- (Optional) Return a function which cancels the request
    -- If you have long running requests, it's essential you support cancellation
    return function() end
end

-- Called immediately after applying the item's textEdit/insertText
function source:execute(ctx, item, callback, default_implementation)
    -- By default, your source must handle the execution of the item itself,
    -- but you may use the default implementation at any time
    default_implementation()

    -- The callback _MUST_ be called once
    callback()
end

return source
