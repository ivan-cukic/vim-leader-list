
function! leaderlist#show()
python << endpython

import re

show_all = False

def get_vim_value(name, default):
    try:
        return vim.eval(name)
    except:
        return default

show_all = get_vim_value('g:leaderlist_show_all_mappings', '0')

if show_all == '1':
    matcher = re.compile('^.*(map *)([^ ]*) *(.*) *"" *(.*)$')
else:
    matcher = re.compile('^.*(map *<Leader>)([^ ]*) *(.*) *"" *(.*)$')

mapping_separator      = get_vim_value('g:leaderlist_mapping_separator', "❯")
command_separator      = get_vim_value('g:leaderlist_command_separator', "|")
leader_conceal         = get_vim_value('g:leaderlist_leader_conceal',    "·")
leader_conceal_adj     = 1 - len(leader_conceal) # trickery for utf8
leader_conceal_disable = get_vim_value('g:leaderlist_leader_disable_conceal', '0')

# vim.command('echom "' + str((show_all, mapping_separator, command_separator, leader_conceal)) + '"')

matched_lines       = []
longest_description = 0
longest_mapping     = 0

def spaces(string, maximum):
    return " " * (maximum - len(string))

for line in open(vim.eval('expand("~/.vimrc")')):

    line = line.replace('<silent>', '')

    matched = matcher.match(line)
    if matched:
        mapping     = matched.group(2)
        description = matched.group(4)
        command     = matched.group(3)

        mapping_length = len(mapping)

        if leader_conceal_disable != '1':
            mapping = mapping.replace('<Leader>', leader_conceal)
            if leader_conceal in mapping:
                mapping_length -= leader_conceal_adj

        current_line = (mapping, description, command)

        longest_description = max(longest_description, len(description))
        longest_mapping = max(longest_mapping, mapping_length)

        matched_lines += [current_line]

for (mapping, description, command) in matched_lines:
    adj = - leader_conceal_adj if leader_conceal in mapping else 0
    to_write = spaces(mapping, longest_mapping + adj) + " " + mapping + " " + mapping_separator + " " + \
               description + spaces(description, longest_description) + " " + command_separator + " " + \
               command
    vim.command('echom "' + to_write.replace('"', '\\"') + '"')

endpython
endfunction

command! ShowLeaderCommands call leaderlist#show()
