/@  message
/-  feather-icons
|%
++  render-messages
  |=  =bowl:neo
  ^-  manx
  ;div
    =label  "Messages"
    ;*
    %+  turn
      ::%+  sort
      ::  %+  murn
          ~(tap of:neo kids.bowl)
     ::   |=  [=pith =idea:neo]
     ::   ?~  pith  ~
     ::   ?@  -.pith  ~
     ::   ?.  =(-<.pith %da)  ~
     ::   `[pith idea]
     :: |=  [a=[=pith *] b=[=pith *]]
     :: (lth ->.pith.a ->.pith.b)
    render-message
  ==
::
++  render-message
  |=  [pax=pith =idea:neo]
  ?.  =(%message p.pail.idea)
    ?@  p.pail.idea
      ;p: {(en-tape:pith:neo pax)}
    ;p: {(trip mark.p.pail.idea)}
  =/  msg  !<(message q.pail.idea)
  ^-  manx
  ;div.fc.g2.border.p3.br1
    ;div.fr.ac.jb
      ;p.s-2.f3: {(scow %p from.msg)}
      ;p.s-2.f3: {(scow %da now.msg)}
    ==
    ;p: {(trip contents.msg)}
  ==
::
++  render-sender
  |=  [=bowl:neo location=pith]
  ^-  manx
  ;form.fc.g2
    =hx-post  "{(en-tape:pith:neo :(welp /neo/hawk here.bowl location))}?stud=txt"
    =hx-on-submit  "this.reset()"
    =hx-target  "find button .loading"
    =hx-swap  "outerHTML"
    =head  "msg"
    ;textarea.p2.border.br1
      =name  "text"
      =placeholder  ". . ."
      =oninput  "this.setAttribute('value', this.value)"
      =rows  "4"
      =required  ""
      =autocomplete  "off"
      ;
    ==
    ;button.p2.b1.br1.bd1.wfc.hover.loader
      ;span.loaded.s2: create
      ;span.loading
        ;+  loading.feather-icons
      ==
    ==
  ==
  ::
--