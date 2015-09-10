Description
===========

It is easy to forget the mappings you have created.

This is a simple Vim plugin that shows the leader mappings configured
in your vimrc file.

It does this by actually grepping the vimrc file for map definitions.
It will only show the mappings that you have documented. Explanation for the
map comes after double quote and double-dash. For example, if these are the lines in
your vimrc file:

    nnoremap <Leader>c  <Esc>:make!<CR>  "" Compile the program
    inoremap <Leader>c  <Esc>:make!<CR>
    inoremap <Leader>s  <Esc>:wa<CR>     "" Save all files
    inoremap <Leader>S  <Esc>:wa!<CR>    " Some irrelevant comment

This will be shown when you call :ShowLeaderCommnads:

    n    c ❯ Compile the program         | <Esc>:make!<CR>
    i    s ❯ Save all files              | <Esc>:wa<CR>


Installation
============

If you are using Vundle:

    Bundle 'ivan-cukic/vim-leader-list'

You'll need Vim compiled with Python2 support.


Usage
=====

Just call the `ShowLeaderCommands` command.


Configuration
=============

If you want to show even mappings that do not use the leader,
you can set this property:

    let g:leaderlist_show_all_mappings = 1

If you do so, the `<Leader>` will not be trimmed from the mapping result.
It will just be concealed using the value of `g:leaderlist_leader_conceal`.

If you want to change the appearance of separators,
you can do so with the following variables:

    let g:leaderlist_mapping_separator = ">"
    let g:leaderlist_command_separator = "|"
    let g:leaderlist_leader_conceal    = "·"

If you prefer the text `<Leader>` to be shown:

    let g:leaderlist_leader_disable_conceal = 1

