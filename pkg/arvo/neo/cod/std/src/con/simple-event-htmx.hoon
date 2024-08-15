/@  simple-event
/@  simple-event-instance
/-  feather-icons
/-  html-utils
/-  pytz
/-  time
/-  rrules
/-  event-inputs
=*  mx  mx:html-utils
:-  [%simple-event %$ %htmx]
|=  ven=simple-event
|=  =bowl:neo
|^
^-  manx
;div.fc.relative.hf.scroll-hidden
  ;+  domain-input
  ;+  controls
  ;div.frw.js.as.scroll-y.hf
    =id  "tabs-{id}"
    ;+  viewer
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
++  domain-input
  ^-  manx
  ;form.mt1.fr.ac.jc.g2
    =hx-post    "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=domain"
    =hx-target  "find .loading"
    =hx-swap    "outerHTML"
    =onsubmit
      """
      const leftInput = this.querySelector('[name=\\"domain[l]\\"]'); 
      const rightInput = this.querySelector('[name=\\"domain[r]\\"]');
      if (parseInt(rightInput.value, 10) < parseInt(leftInput.value, 10)) \{
          rightInput.setCustomValidity('Right number must be greater than or equal to left number.');
      } else \{
          rightInput.setCustomValidity('');
      }
      """
    ;span.s1: Domain: 
    ;input.p-1.b4.bd1.br1
      =style        "width: 5rem;"
      =type         "number"
      =name         "domain[l]"
      =value        "{(numb:pytz l.domain.ven)}"
      =placeholder  "0"
      =min          "0"
      =required     ""
      =oninput
        """
        const leftValue = this.value === '' ? 0 : parseInt(this.value, 10);
        this.setAttribute('value', leftValue);  // Update the value attribute
        const rightInput = this.parentElement.querySelectorAll('input')[1];
        rightInput.min = leftValue;
        if (rightInput.value === '' || parseInt(rightInput.value, 10) < leftValue) \{
            rightInput.value = leftValue;
            rightInput.setAttribute('value', leftValue);
        }
        """
      ;
    ==
    ;input.p-1.b4.bd1.br1
      =style        "width: 5rem;"
      =type         "number"
      =name         "domain[r]"
      =value        "{(numb:pytz r.domain.ven)}"
      =placeholder  "0"
      =oninput      "this.setAttribute('value', this.value);"
      =min          "0"
      =required     ""
      ;
    ==
    ;button.bd1.br1.p2.b1.hover.loader
      ;span.loaded: Submit
      ;span.loading
        ;+  loading.feather-icons
      ==
    ==
  ==
::
++  controls
  ^-  manx
  ;div.p2.frw.jc.ac.g3.sticky.wf
    =style  "top:0; left: 0;"
    ;button.p-1.br1.b1.hover.toggled
      =type  "button"
      =onclick
        """
        $('#tabs-{id}').children().addClass('hidden');
        $('#viewer-{id}').removeClass('hidden');
        $(this).siblings().removeClass('toggled');
        $(this).addClass('toggled');
        """
      ; view
    ==
    ;button.p-1.br1.b1.hover
      =type  "button"
      =onclick
        """
        $('#tabs-{id}').children().addClass('hidden');
        $('#viewer-{id}').removeClass('hidden');
        $('#editor-{id}').removeClass('hidden');
        $(this).siblings().removeClass('toggled');
        $(this).addClass('toggled');
        """
      ; both
    ==
    ;button.p-1.br1.b1.hover
      =type  "button"
      =onclick
        """
        $('#tabs-{id}').children().addClass('hidden');
        $('#editor-{id}').removeClass('hidden');
        $(this).siblings().removeClass('toggled');
        $(this).addClass('toggled');
        """
      ; rule
    ==
  ==
::
++  viewer
  ^-  manx
  ;main.grow.basis-half.scroll-x.scroll-y.br1
    =id     "viewer-{id}"
    =style  "min-width: 300px; height: 100%;"
    ;div.fc.ac.jc
      ;h1:  Event
      ;span: {(trip title.ven)}
      ;*  =/  kids=(list [pith idea:neo])
            %+  sort  ~(tap of:neo kids.bowl)
            |=  [[a=pith *] [b=pith *]]
            %+  lth
              ;;(@ud +:(rear a))
            ;;(@ud +:(rear b))
          %+  turn  kids
          |=  [=pith =idea:neo]
          ^-  manx
          ?>  ?=(%simple-event-instance p.pail.idea)
          =/  i=@ud  ;;(@ud +:(rear pith))
          =+  !<(tin=simple-event-instance q.pail.idea)
          ?-  -.tin
              %|
            ;span: {(numb:pytz i)}: Woops!
            ::
              %&
            ;span: {(numb:pytz i)}: {(scow %da l.p.tin)} {(scow %da r.p.tin)}
          ==
    ==
  ==
::
++  editor
  ^-  manx
  ;form.fc.ac.p1.g1.hidden.grow.basis-half.scroll-y.relative
    =id     "editor-{id}"
    =style  "min-width: 300px; height: 100%;"
    =hx-post    "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=rrule-args"
    =hx-target  "find .loading"
    =hx-swap    "outerHTML"
    ;div.fc.jc
      =style  "width: 400px;"
      ;div.fr.jb.wf
        ;span.s1: Select Rule:
        ;select.p-1.b4.bd1.br1
          =name   "rrule"
          =style  "width: min(15rem, 80%); margin-bottom: 0.25rem;"
          =onchange
            """
            $('#parms-{id}').children().addClass('hidden');
            $(`#parms-$\{this.value}-{id}`).removeClass('hidden');
            """
          ;*  %+  turn
                %+  sort
                  ~(tap by all:span-rules:standard:rrules)
                |=([[* a=@t * *] [* b=@t * *]] (aor a b))
              |=  [key=term name=@t * *]
              ?.  =(key name.rule.ven)
                ;option(value (trip key)): {(trip name)}
              ;option(value (trip key), selected ""): {(trip name)}
        ==
      ==
      ;+  parms
      ;button.bd1.br1.p2.b1.hover.loader
        ;span.loaded: Submit
        ;span.loading
          ;+  loading.feather-icons
        ==
      ==
      ;script(type "module"): {event-listener}
    ==
  ==
::
++  event-listener
  """
  function updateValueAttribute(event) \{
    const element = event.target;
    if (element.tagName === 'SELECT' || element.tagName === 'INPUT') \{
      element.setAttribute('value', element.value);
    }
  }
  
  const editor = document.getElementById('editor-{id}');
  
  editor.addEventListener('change', updateValueAttribute);

  editor.querySelectorAll('select, input').forEach(function(element) \{
    element.setAttribute('value', element.value);
  });
  """
::
++  parms
  ^-  manx
  ;div.fc.ac.wf(id "parms-{id}")
    ;*
    :: Build sensible defaults
    ::
    =/  [name=@t =parm:rrules rub=span-rule-builder:rrules]
      (~(got by all:span-rules:standard:rrules) name.rule.ven)
    :: Get the example timezone as the argument for the first
    :: available timezone paramemter
    ::
    =/  tz=@t
      |-
      ?~  parm
        'UTC'
      ?.  ?=(%tz q.i.parm)
        $(parm t.parm)
      =/  =arg:rrules  (~(got by args.rule.ven) p.i.parm)
      ?>(?=(%tz -.arg) p.arg)
    :: Get the example datetime as the start of the first instance
    :: of the current rule shifted to the example timezone
    ::
    =/  first=@da      (fall (bind (mole |.(((rub args.rule.ven) 0))) head) now.bowl)
    =/  local=@da      (fall (~(localize-soft zn:pytz tz) first) now.bowl)
    =/  =fuld:time     (da-to-fuld:time local)
    =/  clocktime=@dr  (mod local ~d1)
    ::
    %+  turn  ~(tap by all:span-rules:standard:rrules)
    |=  [key=term name=@t =parm:rrules *]
    ^-  manx
    =;  m=manx
      (pid:~(at mx m) "parms-{(trip key)}-{id}")
    ?:  =(key name.rule.ven)
      %*  $  form-from-args:event-inputs
        parm           parm
        args           args.rule.ven
        prefix         (trip key)
        label-classes  "s1"
        input-classes  "p-1 b4 bd1 br1"
      ==
    =;  m=manx
       (pac:~(at mx m) "hidden")
    %*  $  form-from-date:event-inputs
      parm           parm
      fuld           fuld
      clocktime      clocktime
      tz             tz
      prefix         (trip key)
      label-classes  "s1"
      input-classes  "p-1 b4 bd1 br1"
    ==
  ==
--
