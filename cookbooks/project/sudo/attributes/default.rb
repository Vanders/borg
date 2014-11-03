default['authorization']['sudo']['prefix']            = '/etc'

default['authorization']['sudo']['groups']            = []
default['authorization']['sudo']['users']             = []
default['authorization']['sudo']['passwordless']      = false
default['authorization']['sudo']['include_sudoers_d'] = true
default['authorization']['sudo']['agent_forwarding']  = true
default['authorization']['sudo']['sudoers_defaults']  = ['!fqdn,insults,!lecture,timestamp_timeout=30,tty_tickets']
default['authorization']['sudo']['command_aliases']   = []
default['authorization']['sudo']['env_keep_add']      = [ "BLOCKSIZE", "COLORFGBG", "COLORTERM",
                                                          "__CF_USER_TEXT_ENCODING", "CHARSET",
                                                          "LANG", "LANGUAGE", "LC_ALL", "LC_COLLATE",
                                                          "LC_CTYPE", "LC_MESSAGES", "LC_MONETARY",
                                                          "LC_NUMERIC", "LC_TIME", "LINES", "COLUMNS",
                                                          "LSCOLORS", "TZ", "DISPLAY", "XAUTHORIZATION", 
                                                          "XAUTHORITY", "EDITOR", "VISUAL", "HOME", "MAIL" ]
default['authorization']['sudo']['env_keep_subtract'] = []
