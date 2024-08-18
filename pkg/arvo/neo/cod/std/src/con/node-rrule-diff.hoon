/@  node
/@  rrule-diff
/-  manx-utils
:-  [%node %$ %rrule-diff]
|=  nod=node
^-  rrule-diff
=/  mu  ~(. manx-utils nod)
=/  name  (vol:mu "name")
=/  code
  =/  raw=tape  (need (val:mu "code"))
  %-  crip
  ?:  =(0 (lent raw))       raw
  ?.  =((rear raw) '\0a')   raw
  ::  remove newline by html encoding nonsense
  (snip raw)
[name ~ code]
