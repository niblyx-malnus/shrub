/@  rrule-fuld
/-  feather-icons
:-  [%rrule-fuld %$ %htmx]
|=  =rrule-fuld
|=  =bowl:neo
^-  manx
|^
;div.fc.relative.hf.scroll-hidden
  ;div.frw.js.as.scroll-y.hf
    =id  "tabs-{id}"
    ;+  editor
  ==
==
::
++  id
  ^-  tape
  %-  zing
  %+  turn  (pout (slag 1 here.bowl))
  |=  smeg=@ta
  %+  weld  "--"
  (trip smeg)
::
++  editor
  ;form.fc.p1.g1.grow.basis-half.scroll-y.relative
    =id  "editor-{id}"
    =style  "min-width: 300px; height: 100%;"
    =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=rrule-diff"
    =hx-swap  "outerHTML"
    =hx-target  "find .loading"
    =hx-trigger  "input changed delay:0.4s from:find textarea"
    ;+  result
    ;textarea.p2.pre.mono.scroll-x.grow.bd1.m0.br1
      =name  "code"
      =oninput  "this.setAttribute('value', this.value);"
      =spellcheck  "false"
      =value  ""
      =placeholder  "...your code here..."
      ; {(trip code.rrule-fuld)}
    ==
    ;div.absolute
      =style  "top: 14px; right: 14px;"
      ;div.loader
        ;span.loaded(style "opacity: 0;"): ---
        ;span.loading
          ;+  loading.feather-icons
        ==
      ==
    ==
  ==
::
++  result
  ^-  manx
  ?-  -.result.rrule-fuld
      %&
    ;div.wf.mono.p2.br1.b-1.f0: compilation successful
    ::
      %|
    ;details.wf.br1.bd1
      =style  "max-height: 220px;"
      ;summary.p2.br1.b-3.f0: error
      ;div.pre.mono.p2.wf.scroll-y
        ;*
        %+  turn  p.result.rrule-fuld
        |=  =tank
        ;span: {(of-wall:format (~(win re tank) 0 80))}
      ==
    ==
  ==
--
