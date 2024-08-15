/@  ui-event
/@  txt
/@  diary-diff
^-  kook:neo
=<
|%
++  state  pro/%manx
++  poke   (sy %ui-event %rely %gift ~)
++  kids
  *kids:neo
  :: ^-  kids:neo
  :: :+  ~  %y
  :: %-  my
  :: :~  [[&/%selection |] pro/%sig ~]
  :: ==
++  deps
  ^-  deps:neo
  %-  my
  :~  :^  %src  &  [pro/%diary (sy %diary-diff ~)]
      :+  ~  %y
      %-  my
      :~  [[|/%da |] only/%txt ~]
      ==
  ==
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
  ::
  ++  init
    |=  pal=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    :-  ~
    manx/!>((render (get-render-data bowl)))
  ::
  ++  poke
    |=  [sud=stud:neo vaz=vase]
    ^-  (quip card:neo pail:neo)
    ?+  sud  ~|(bad-stud/sud !!)
      ::
        %ui-event
      =/  eve  !<(ui-event vaz)
      ?+  path.eve  ~|(missing-event-handler-for/path.eve !!)
        ::
          [%submit %diary-form ~]
        =/  dat=@t          (~(got by data.eve) 'diary-input')
        =/  dif=diary-diff  [%put-entry now.bowl dat]
        =/  dst=pith:neo    p:(~(got by deps.bowl) %src)
        :_  pail
        :~  [dst %poke diary-diff/!>(dif)]
        ==
        ::
          [%click %delete @ta ~]
        =/  key=@da         (slav %da i.t.t.path.eve)
        =/  dif=diary-diff  [%del-entry key]
        =/  dst=pith:neo    p:(~(got by deps.bowl) %src)
        :_  pail
        :~  [dst %poke diary-diff/!>(dif)]
        ==
        ::
      ==
      ::
        %rely
      `manx/!>((render (get-render-data bowl)))
      ::
    ==
  ::
  --
--
::
|%
::
+$  render-data
  $:  diary-entries=(list [date=@da =txt])
      selection=(unit @da)
  ==
::
++  render
  |_  render-data
  ::
  ++  $
    ^-  manx
    ;html
      ;head
        ;meta(charset "utf-8");
      ==
      ;body
        =style  "margin: 0; width: 100%; display: grid; place-items: center;"
        ;main
          ;h1: Diary
          ;+  diary-form
          ;+  diary-items
        ==
      ==
    ==
  ::
  ++  diary-form
    ^-  manx
    ;form
      =event  "/submit/diary-form"
      ;textarea(name "diary-input", style "height: 10rem; width: 25rem; margin-block: 1rem;");
      ;button: Enter
    ==
  ::
  ++  diary-items
    ^-  manx
    ;div
      ;*  %+  turn  diary-entries
          |=  [date=@da =txt]
          =/  key=tape  <date>
          ;div
            =key  key
            ;p: {(pretty-date date)}
            ;p: {(trip txt)}
            ;button
              =event  "/click/delete/{key}"
              ;+  ;/  "✖"
            ==
          ==
    ==
  ::
  --
::  ::  ::  ::  ::  ::  ::  ::  ::  ::
++  get-render-data
  |=  =bowl:neo
  ^-  render-data
  :*  (get-diary-entries deps.bowl)
      (get-selection kids.bowl)
  ==
::
++  get-diary-entries
  |=  deps=(map term (pair pith:neo lore:neo))
  ^-  (list [date=@da =txt])
  =/  data=(unit (pair pith:neo lore:neo))
    (~(get by deps) %src)
  ?~  data  ~|(%no-diary !!)
  =/  entries=(list [date=@da =txt])
    %+  turn  ~(tap by kid.q.u.data)
    |=  (pair iota:neo (axal:neo idea:neo))
    ?>  &(?=(^ p) ?=(%da -.p) ?=(^ fil.q))
    [+.p !<(txt q.pail.u.fil.q)]
  %+  sort  entries
  |=  (pair [date=@da =txt] [date=@da =txt])
  (gth date.p date.q)
::
++  get-selection
  |=  kids=(axal:neo idea:neo)
  ^-  (unit @da)
  =/  data=(unit (axal:neo idea:neo))
    (~(get by kid.kids) %selection)
  ?~  data  ~
  ?~  fil.u.data  ~
  [~ !<(@da q.pail.u.fil.u.data)]
::
++  pretty-date  :: from diary-htmx
  |=  date=@da
  ^-  tape
  =/  d  (yore date)
  "{(y-co:co y:d)}-{(y-co:co m:d)}-{(y-co:co d:t:d)}"
::
--
