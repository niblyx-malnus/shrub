/@  node
/-  manx-utils
/-  sail
:-  [%node %$ %sail]
|=  nod=node
=/  mu  ~(. manx-utils nod)
=/  code
  =/  raw=tape  (need (val:mu "code"))
  %-  crip
  ?:  =(0 (lent raw))       raw
  ?.  =((rear raw) '\0a')   raw
  ::  remove newline by html encoding nonsense
  (snip raw)
=/  cm-config  (vol:mu "cm-config")
=/  class  (vol:mu "classes")
[code class cm-config `(render-udon:sail code)]
