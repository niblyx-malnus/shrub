/@  messenger
/@  dm-diff
/@  groupchat-diff
/@  messenger-diff
=>
|%
++  send-invites
  |=  [invites=(set ship) location=pith]
  %+  turn
    ~(tap in invites)
  |=  =ship
  :-  location
  =/  provider  ~[p/ship %home %messenger]
  ~&  provider
  [%poke groupchat-diff/!>([%invite ship provider])]
--
::
|%
++  state  pro/%messenger
::  +poke: The poke types
::
::    We allow for the three different kinds of diffs that we support
::
++  poke  
  ::    %dm-diff is for creating DMs
  (sy %dm-diff %groupchat-diff %messenger-diff ~)
::  +kids: Children for messenger
++  kids
  ::    Child constraints
  ::
  ::  All children under this tree either are DMs, or groupchats
  ::  Dms are identified by @p
  ::  Groupchats are identified by [@p @t]
  ::
  :+  ~  %y
  %-  ~(gas by *lads:neo)
  :~  :-  [&/%dms |/%p |]
      [pro/%dm (sy %dm-diff ~)]
      :-  [&/%groupchats |/%p |/%t |]
      [pro/%groupchat (sy %groupchat-diff ~)]
  ==
++  deps  *deps:neo
++  form
  :: ^-  form:neo
  |_  [=bowl:neo =aeon:neo state=pail:neo]
  ++  init
    |=  old=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    [~ messenger/!>(~)]
  ::
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo pail:neo)
    ~&  >>  stud
    ?+    stud  !!
        %dm-diff
      ~&  >>>  'got dm diff'
      =/  poke  !<(dm-diff vax)
      ?>  =(%invited -.poke)
      :_  state
      :~  :-  (welp here.bowl ~[%dms p/ship.src.bowl])
          [%make %dm `dm-diff/vax ~]
      ==
    ::
        %groupchat-diff
      =/  poke  !<(groupchat-diff vax)
      ?+    -.poke  !!
          %invited
        :_  state
        :~  :-  (welp here.bowl ~[%groupchats p/ship.src.bowl (rear host.poke)])
            [%make %groupchat `groupchat-diff/vax ~]
        ==
      ==
    ::
        %messenger-diff
      ?>  =(our ship.src):bowl
      =/  poke  !<(messenger-diff vax)
      ?-    -.poke
          %new-dm
        ?:  (~(has of:neo kids.bowl) ~[%dms p/partner.poke])
          [~ state]
        =/  provider  ~[p/partner.poke %home %messenger]
        :_  state
        :~  :-  (welp here.bowl ~[%dms p/partner.poke])
            [%make %dm `dm-diff/!>([%initiate partner.poke provider]) ~]
        ==
      ::
          %new-groupchat
        =/  location
          (welp here.bowl ~[%groupchats p/our.bowl t/name.poke])
        :_  state
        :-  [location [%make %groupchat ~ ~]]
        (send-invites invites.poke location)
      ::
          %invite-to-groupchat
        =/  location
          (welp here.bowl ~[%groupchats p/our.bowl t/name.poke])
        :_  state
        (send-invites invites.poke location)
      ==
    ==
  --
--
