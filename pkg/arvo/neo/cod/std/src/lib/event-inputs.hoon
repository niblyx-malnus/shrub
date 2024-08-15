/-  pytz
/-  time
/-  rrules
/-  iso-8601
/-  html-utils
=,  iso=iso-8601
=*  mx  mx:html-utils
=|  input-classes=tape
=|  label-classes=tape
|%
:: %tz
::
++  timezone-input
  |=  [name=tape default=@t]
  ^-  manx
  ;select
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =name      "{name}"
    ;*  %+  turn  names.pytz
        |=  n=@t
        =/  name=tape  (trip n)
        ?.  =(n default)
          ;option(value "{name}"): {name}
        ;option(value "{name}", selected ""): {name}
  ==
:: %dr
::
++  duration
  |=  [name=tape default=@dr]
  ^-  manx
  |^
  =+  defaults
  ;span(style "display: flex; width: 100%; gap: 0.25rem")
    ;input(class input-classes, type "number", value d, min "0", name "{name}[d]", placeholder "DD", style "width: 25%"); 
    ;input(class input-classes, type "number", value h, min "0", max "23", name "{name}[h]", placeholder "HH", style "width: 25%");
    ;input(class input-classes, type "number", value m, min "0", max "59", name "{name}[m]", placeholder "MM", style "width: 25%");
    ;input(class input-classes, type "number", value s, min "0", max "59", name "{name}[s]", placeholder "SS", style "width: 25%");
  ==
  ::
  ++  defaults
    ^-  [d=tape h=tape m=tape s=tape]
    =/  d-num    (div default ~d1)
    =/  d        ?:(=(0 d-num) "" (numb:iso d-num))
    =.  default  (mod default ~d1)
    =/  h-num    (div default ~h1)
    =/  h        ?:(=(0 h-num) "" (scow %ud h-num))
    =.  default  (mod default ~h1)
    =/  m-num    (div default ~m1)
    =/  m        ?:(=(0 m-num) "" (scow %ud m-num))
    =.  default  (mod default ~m1)
    =/  s-num    (div default ~s1)
    =/  s        ?:(=(0 s-num) "" (scow %ud s-num))
    [d h m s]
  --
:: %od
::
++  ordinal
  |=  [name=tape default=ord:time]
  ^-  manx
  =;  m=manx
    :: mark option with value of default ord as selected
    ::
    %+  ~(kit mx m)
      (tir:con:mx %value (trip default))
    (sec:tan:mx &)
  ::
  ;select
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =name      "{name}"
    ;option(value "first"): First
    ;option(value "second"): Second
    ;option(value "third"): Third
    ;option(value "fourth"): Fourth
    ;option(value "last"): Last
  == 
:: %ud
::
++  unsigned-decimal
  |=  [name=tape default=@ud]
  ^-  manx
  ;input
    =class        input-classes
    =required     ""
    =style        "width: 100%"
    =name         "{name}"
    =value        "{(numb:iso default)}"
    =placeholder  "0"
    =min          "0"
    ;
  ==
:: %wl
::
++  weekday-list
  |=  [name=tape default=(list wkd:time)]
  ^-  manx
  =;  m=manx
    :: mark option with value of default wkds as selected
    ::
    %+  ~(kit mx m)
      |=  [* m=manx]
      ?~  get=(get:~(at mx m) %value)
        %.n
      (~(has in (sy default)) ;;(wkd:time (crip u.get)))
    (sec:tan:mx &)
  ::
  ;select
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =name      "{name}"
    =multiple  ""
    ;option(value "mon"): Monday
    ;option(value "tue"): Tuesday
    ;option(value "wed"): Wednesday
    ;option(value "thu"): Thursday
    ;option(value "fri"): Friday
    ;option(value "sat"): Saturday
    ;option(value "sun"): Sunday
  == 
:: %wd
::
++  weekday
  |=  [name=tape default=wkd:time]
  ^-  manx
  =;  m=manx
    :: mark option with value of default wkd as selected
    ::
    %+  ~(kit mx m)
      (tir:con:mx %value (trip default))
    (sec:tan:mx &)
  ::
  ;select
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =name      "{name}"
    ;option(value "mon"): Monday
    ;option(value "tue"): Tuesday
    ;option(value "wed"): Wednesday
    ;option(value "thu"): Thursday
    ;option(value "fri"): Friday
    ;option(value "sat"): Saturday
    ;option(value "sun"): Sunday
  == 
:: %dt
::
++  date-input
  |=  [name=tape default=fuld:time]
  ^-  manx
  ;input
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =type      "date"
    =name      "{name}"
    =value     "{(en:date-input:iso default)}"
    ;
  ==
:: %dl
::
++  delta-input
  |=  [name=tape default=delta:pytz]
  ^-  manx
  |^
  ;span
    =style  "display: flex; width: 100%; gap: 0.25rem"
    ;+  =;  m=manx
          :: mark option with value of default as selected
          ::
          %+  ~(kit mx m)
            (tir:con:mx %value ?:(sign.default "+" "-"))
          (sec:tan:mx &)
        ::
        ;select(class input-classes, style "width: 20%", name "{name}[sign]")
          ;option(value "+"): +
          ;option(value "-"): -
        == 
    ;+  =+  defaults
        ;span(style "display: flex; width: 80%; gap: 0.25rem")
          ;input(class input-classes, type "number", value h, min "0", max "23", name "{name}[h]", placeholder "HH", style "width: 50%");
          ;input(class input-classes, type "number", value m, min "0", max "59", name "{name}[m]", placeholder "MM", style "width: 50%");
        ==
  ==
  ::
  ++  defaults
    ^-  [h=tape m=tape]
    =.  d.default  (mod d.default ~d1)
    =/  h-num      (div d.default ~h1)
    =/  h          ?:(=(0 h-num) "" (scow %ud h-num))
    =.  d.default  (mod d.default ~h1)
    =/  m-num      (div d.default ~m1)
    =/  m          ?:(=(0 m-num) "" (scow %ud m-num))
    [h m]
  --
:: %cl
::
++  time-input
  |=  [name=tape default=@dr]
  ^-  manx
  ;input
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =type      "time"
    =name      "{name}"
    =value     "{(en:time-input:iso default)}"
    ;
  ==
::  %da
::
++  datetime-local
  |=  [name=tape default=@da]
  ^-  manx
  ;input
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =type      "datetime-local"
    =name      "{name}"
    =value     "{(en:datetime-local:iso default)}"
    ;
  ==
:: %mt
::
++  month-input
  |=  [name=tape default=munt:time]
  ^-  manx
  ;input
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =type      "month"
    =name      "{name}"
    =value     "{(en:month-input:iso default)}"
    ;
  ==
:: %wk
::
++  week-input
  |=  [name=tape default=week:time]
  ^-  manx
  ;input
    =class     input-classes
    =required  ""
    =style     "width: 100%"
    =type      "week"
    =name      "{name}"
    =value     "{(en:week-input:iso default)}"
    ;
  ==
:: %dx
::
++  indexed-time
  |=  [name=tape default=dext:pytz]
  ^-  manx
  ;span(style "display: flex; width: 100%; gap: 0.25rem")
    ;input
      =class        input-classes
      =required     ""
      =style        "width: 20%"
      =type         "number"
      =min          "0"
      =name         "{name}[i]"
      =value        "{(numb:iso i.default)}"
      =placeholder  "0"
      ;
    ==
    ;input
      =class        input-classes
      =required     ""
      =style        "width: 80%"
      =type         "datetime-local"
      =name         "{name}[d]"
      =value        "{(en:datetime-local:iso d.default)}"
      ;
    ==
  ==
::
++  form-from-args
  |=  [prefix=tape =parm:rrules =args:rrules]
  ^-  manx
  %+  build-form
    prefix
  %+  turn  parm
  |=  [name=@t =term]
  ^-  [@t arg:rrules]
  :-  name
  ?^  get=(~(get by args) name)
    ?>  =(term -.u.get)
    u.get
  :: some sensible defaults
  ::
  ?+  term  !!
    %ud  [%ud 0]
    %od  [%od %first]
    %da  [%da ~1970.1.1]
    %tz  [%tz 'UTC']
    %dr  [%dr ~h1]
    %dl  [%dl & ~s0]
    %dx  [%dx 0 ~1970.1.1]
    %wd  [%wd %mon]
    %wl  [%wl %mon ~]
    %dt  [%dt [& 1.970] 1 1]
    %ct  [%ct ~s0]
    %mt  [%mt [& 1.970] 1]
    %wk  [%wk [& 1.970] 1]
  ==
::
++  form-from-date
  |=  [prefix=tape =parm:rrules =fuld:time clocktime=@dr tz=@t]
  ^-  manx
  =/  day=@da           (fuld-to-da:time fuld)
  =/  weekday=wkd:time  (num-to-wkd:time (get-weekday:time day))
  %+  build-form
    prefix
  %+  turn  parm
  |=  [name=@t =term]
  ^-  [@t arg:rrules]
  :-  name
  ?+  term  !!
    %ud  [%ud 0]
    %od  [%od (get-ordinal-weekday:time day)]
    %da  [%da day]
    %tz  [%tz tz]
    %dr  [%dr ~h1]
    %dl  [%dl & ~s0]
    %dx  [%dx 0 (add day clocktime)]
    %wd  [%wd weekday]
    %wl  [%wl weekday ~]
    %dt  [%dt fuld]
    %ct  [%ct clocktime]
    %mt  [%mt (da-to-munt:time day)]
    %wk  [%wk (da-to-week:time day)]
  ==
::
++  build-form
  |=  [prefix=tape args=(list [@t arg:rrules])]
  ^-  manx
  ;div
    =style  "width: 100%; display: flex; flex-direction: column"
    ;*  %+  turn  args
        |=  [name=@t =arg:rrules]
        ^-  manx
        =/  input-name=tape
          ?:  =("" prefix)
            (trip name)
          "{prefix}[{(trip name)}]"
        ;span
          =style  "display: flex; align-items: center; justify-content: space-between;"
          ;span(class label-classes): {(trip name)}:
          ;span(style "display: flex; width: min(15rem, 80%); margin-bottom: 0.25rem;")
            ;+  ?-  -.arg
                  %tz  (timezone-input input-name p.arg)
                  %ud  (unsigned-decimal input-name p.arg)
                  %od  (ordinal input-name p.arg)
                  %da  (datetime-local input-name p.arg)
                  %dr  (duration input-name p.arg)
                  %dl  (delta-input input-name p.arg)
                  %dx  (indexed-time input-name p.arg)
                  %wd  (weekday input-name p.arg)
                  %wl  (weekday-list input-name p.arg)
                  %dt  (date-input input-name p.arg)
                  %ct  (time-input input-name p.arg)
                  %mt  (month-input input-name p.arg)
                  %wk  (week-input input-name p.arg)
                ==
          ==
        ==
  ==
::
++  extract-rule-args
  =|  =args:rrules
  |=  [=parm:rrules =brac:kv]
  ^-  args:rrules
  ~&  brac+brac
  ~&  parm+parm
  ?~  parm
    args
  %=    $
    parm  t.parm
      args
    %+  ~(put by args)
      p.i.parm
    ^-  arg:rrules
    ~&  iparm+p.i.parm
    ?+    q.i.parm  !!
      %ud  ud+(rash (reed:kv (~(get of brac) /[p.i.parm])) dem)
      %od  od+;;(ord:time (reed:kv (~(get of brac) /[p.i.parm])))
      %da  da+(de:datetime-local:iso (reed:kv (~(get of brac) /[p.i.parm])))
      %dr  dr+(extract-duration (~(dip of brac) /[p.i.parm]))
      %dl  dl+(extract-delta (~(dip of brac) /[p.i.parm]))
      %dx  dx+(extract-dext (~(dip of brac) /[p.i.parm]))
      %wd  wd+;;(wkd:time (reed:kv (~(get of brac) /[p.i.parm])))
      %wl  wl+;;((list wkd:time) (need (~(get of brac) /[p.i.parm])))
      %dt  dt+(de:date-input:iso (reed:kv (~(get of brac) /[p.i.parm])))
      %ct  ct+(de:time-input:iso (reed:kv (~(get of brac) /[p.i.parm])))
      %mt  mt+(de:month-input:iso (reed:kv (~(get of brac) /[p.i.parm])))
      %wk  wk+(de:week-input:iso (reed:kv (~(get of brac) /[p.i.parm])))
    ==
  ==
  ::
++  extract-duration
  |=  =brac:kv
  ^-  @dr
  =;  parts=(list @dr)
    (roll parts add)
  %+   turn  ~(tap by dir:brac)
  |=  [=@t =brac:kv]
  =/  =@dr  ?+(t !! %d ~d1, %h ~h1, %m ~m1, %s ~s1)
  (mul dr (fall (rush (reed:kv (~(get of brac) ~)) dem) 0))
::
++  extract-delta
  |=  =brac:kv
  ^-  delta:pytz
  =/  sign=?  =('+' (reed:kv (~(get of brac) /sign)))
  =/  h=@ud   (mul ~h1 (fall (rush (reed:kv (~(get of brac) /h)) dem) 0))
  =/  m=@ud   (mul ~m1 (fall (rush (reed:kv (~(get of brac) /m)) dem) 0))
  [sign (add h m)]
::
++  extract-dext
  |=  =brac:kv
  ^-  dext:pytz
  :-  (rash (reed:kv (~(get of brac) /i)) dem)
  (de:datetime-local:iso (reed:kv (~(get of brac) /d)))
::
++  extract-weekday-list  |=(l=(list @t) ;;((list wkd:time) l))

++  kv
  |%
  +$  key-value-list  (list [key=@t value=@t])
  ::
  ++  get-key
    |=  [key=@t =key-value-list]
    ^-  (unit @t)
    (get-header:http key key-value-list)
  ::
  ++  get-all-key
    |=  [key=@t =key-value-list]
    ^-  (list @t)
    =/  val=(unit @t)  (get-key key key-value-list)
    ?~  val
      ~
    :-  u.val
    $(key-value-list (delete-key key key-value-list))
  ::
  ++  set-key
    |=  [key=@t value=@t =key-value-list]
    ^+  key-value-list
    (set-header:http key value key-value-list)
  ::
  ++  delete-key
    |=  [key=@t =key-value-list]
    ^+  key-value-list
    (delete-header:http key key-value-list)
  ::
  ++  delete-all-key
    |=  [key=@t =key-value-list]
    ^+  key-value-list
    =/  val=(unit @t)  (get-key key key-value-list)
    ?~  val
      key-value-list
    $(key-value-list (delete-key key key-value-list))
  ::
  ++  parse-body
    |=  body=(unit octs)
    ^-  key-value-list
    %-  fall  :_  *key-value-list
    %+  rush
      `@t`(tail (fall body [0 '']))
    yquy:de-purl:html
  :: convert bracket / array-like keys from a form submission
  :: to a hierarchical map of values (axal)
  :: e.g. from input with name="thing[a][b][c]"
  ::
  +$  brac  (axal (list @t))
  ++  de-bracket
    =|  =brac
    |=  l=key-value-list
    ^+  brac
    ?~  l
      brac
    =/  p=(unit path)  (brackets key.i.l) :: insane path
    ?~  p
      $(l t.l)
    ?~  get=(~(get of brac) u.p)
      $(l t.l, brac (~(put of brac) u.p [value.i.l ~]))
    $(l t.l, brac (~(put of brac) u.p [value.i.l u.get]))
  :: get last (or only) element of list contents
  ::
  ++  reed
    |*  a=(unit (list *))
    (rear (need a))
  ++  reef
    |*  [a=(unit (list *)) b=*]
    (rear (fall a [b ~]))
  --
::
++  brackets
  =<  parse
  =,  monadic
  |%
  ++  parse  |=(b=@t `(unit (list @t))`(rush b brackets))
  :: parse everything between double brackets
  ::
  ++  bracket-contents
    ;<  c=char  bind  sel :: starts with double quote
    =|  seg=tape
    |-
    ;<  n=@t  bind  ;~(pose (jest '\\\\') (jest '\\]') next)
    ?^  (rush n ser)
      (easy (crip seg))
    $(seg (weld seg (trip n)))
  ::
  ++  brackets
    ;<  seg=@t  bind  (cook crip (star (non sel)))
    ?~  seg
      fail
    =/  brackets=(list @t)  [seg ~]
    |-
    ;<  d=?  bind  done :: check if fully parsed and return / continue
    ?:  d
      (easy (flop brackets)) 
    ;<  seg=@t  bind  bracket-contents :: parse a bracket segment
    $(brackets [seg brackets])
  --
::
++  monadic
  |%
  ++  bind  
    |*  =mold
    |*  [sef=rule gat=$-(mold rule)]
    |=  tub=nail
    =/  vex  (sef tub)
    ?~  q.vex  vex
    ((gat p.u.q.vex) q.u.q.vex)
  :: check if done
  ::
  ++  done
    |=  tub=nail
    ^-  (like ?)
    ?~  q.tub
      [p.tub ~ %.y tub]
    [p.tub ~ %.n tub]
  :: lookahead arbitrary rule
  ::
  ++  peek
    |*  sef=rule
    |=  tub=nail
    =+  vex=(sef tub)
    ?~  q.vex
      [p=p.vex q=[~ u=[p=~ q=tub]]]
    [p=p.vex q=[~ u=[p=[~ p.u.q.vex] q=tub]]]
  :: next if fail to parse on rule 
  :: (assumes single character parse)
  ::
  ++  non
    |*  sef=rule
    ;<  c=(unit char)  bind  (peek sef)
    ?^(c fail next)
  --
--
