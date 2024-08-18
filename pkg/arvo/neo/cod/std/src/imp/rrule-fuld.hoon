/@  rrule-fuld
/@  rrule-diff
/-  rrules
=>  |%
    ++  compile-rule
      |=  code=@t
      ^-  (each fuld-rule-builder:rrules tang)
      %-  mule  |.
      !<  fuld-rule-builder:rrules
      (slap !>(rrules) (ream code))
    --
|%
++  state  pro/%rrule-fuld
++  poke   (sy %rrule-diff ~)
++  kids   *kids:neo
++  deps  *deps:neo
::
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo pail:neo)
    ?>  ?=(%rrule-diff stud)
    =+  !<(rrule-diff vax)
    `rrule-date/!>([name parm code (compile-rule code)])
  ++  init
    |=  pal=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    =/  [name=@t =parm:rrules code=@t]
      ?~  pal
        ['Untitled' ~ '~|("untitled" !!)']
      ?>  ?=(%rrule-diff p.u.pal)
      !<(rrule-diff q.u.pal)
    `rrule-fuld/!>([name parm code (compile-rule code)])
  --
--
