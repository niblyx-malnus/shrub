/@  node           :: manx
/@  zone-name-diff :: [%new-zone zone=@t]
/-  manx-utils
:-  [%node %$ %zone-name-diff]
|=  =node
^-  zone-name-diff
=/  mu  ~(. manx-utils node)
=/  head  ;;(%new-zone (got:mu %head))
=/  zone  (got:mu %zone-name)
[head zone]
