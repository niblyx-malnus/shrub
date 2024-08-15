/@  simple-event
/-  rrules
^-  kook:neo
|%
++  state  pro/%simple-event
++  poke   (sy %domain %simple-event-diff ~)
++  kids
  ^-  kids:neo
  :-  ~
  :-  %y
  %-  ~(gas by *lads:neo)
  ~[[[|/%ud |] [only/%simple-event-instance ~]]]
::
++  deps  *deps:neo
::
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
  ++  init
    |=  pal=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    =/  ven=simple-event
        ?^  pal
          !<(simple-event q.u.pal)
        :*  :-  %single
            %-  ~(gas by *args:rrules)
            :~  ['Start Date' dt+[[& 1.970] 1 1]]
                ['Clocktime' ct+~s0]
                ['Timezone' tz+'UTC']
                ['Duration' dr+~h1]
            ==
            'No Title'  [0 0]
        ==
    :_  simple-event+!>(ven)
    %+  turn  (gulf domain.ven)
    |=  i=@ud
    :-  (welp here.bowl ~[ud+i])
    [%make %simple-event-instance ~ (malt ~[[%ven here.bowl]])]
  ::
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo pail:neo)
    ?>  ?=(%domain stud)
    =+  !<([l=@ud r=@ud] vax)
    =+  !<(simple-event q.pail)
    :_  simple-event+!>([rule title l r])
    =^  cards  kids.bowl
      =/  stan=(list @ud)  (gulf l r)
      =|  cards=(list card:neo)
      |-
      ?~  stan
        [cards kids.bowl]
      =?  cards  !(~(has of:neo kids.bowl) ~[ud+i.stan])
        :_  cards 
        :-  (welp here.bowl ~[ud+i.stan])
        [%make %simple-event-instance ~ (malt ~[[%ven here.bowl]])]
      $(stan t.stan, kids.bowl (~(del of:neo kids.bowl) ~[ud+i.stan]))
    %+  weld  cards
    ^-  (list card:neo)
    %+  turn  ~(tap of:neo kids.bowl)
    |=  [=pith *]
    [(welp here.bowl pith) %cull ~]
  --
--
