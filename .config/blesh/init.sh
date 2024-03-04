bleopt keymap_vi_mode_show:=
bleopt exec_elapsed_mark=
bleopt exec_errexit_mark=
bleopt history_share=1

ble-face argument_error='fg=black,bg=red,underline'
ble-face auto_complete='fg=1'
ble-face command_directory='fg=1'
ble-face filename_directory='fg=1,bold'
ble-face filename_directory_sticky="fg=7,bg=1,bold"
ble-face filename_link="fg=6"
ble-face filename_ls_colors=''
ble-face filename_orphan="fg=1,bg=0"
ble-face filename_other=''
ble-face menu_filter_input="fg=black,bg=3"
ble-face overwrite_mode="fg=1,bg=0"
ble-face region_insert='fg=0,bg=1'

ble-bind -m vi_nmap --cursor 2
ble-bind -m vi_imap --cursor 5
ble-bind -m vi_omap --cursor 4
ble-bind -m vi_xmap --cursor 2
ble-bind -m vi_cmap --cursor 0
