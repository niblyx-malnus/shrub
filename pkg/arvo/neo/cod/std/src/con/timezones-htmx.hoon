/@  timezones
/-  feather-icons
/-  pytz
:-  [%timezones %$ %htmx]
|=  =timezones
|=  =bowl:neo
|^
  ;div.wf.hf.relative
    ;div.fc
      ;form.frw.g3
        =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=timezones"
        =hx-swap  "none"
        ;*
        %+  weld  zones
        ^-  (list manx)
        :_  ~
        ;div.relative.br2
          =id         "add-zone-{id}"
          ;button.b1.br2.block.fc.ac.jc.hover.p3.s1.border-2
            =style    "width: 280px; min-height: 280;"
            =type     "submit"
            =onclick  "addZone()"
            ;+  plus:fi
          ==
        ==
      ==
      ;div.hidden(id "add-zone-text-{id}"): {(en-xml:html (zone 'UTC'))}
      ;div.hidden(id "add-zone-script-{id}"): {update-clock}
      ;script
        ;+  ;/
        """
        function addZone() \{
          var adder = document.getElementById('add-zone-{id}');

          var siblings = Array.from(adder.parentNode.children);

          siblings = siblings.filter(function(sibling) \{
            return sibling !== adder && sibling.id;
          });
          
          // Log the ids of all sibling elements to the console
          var numbers = siblings.map(function(sibling) \{
            return Number((sibling.id.slice("zone-widget-{id}-".length)));
          });
          
          var idx = Math.max(...numbers) + 1;
          var id = `zone-widget-{id}-$\{idx}`;

          var newZone = document.createElement('div');
          newZone.classList.add('relative', 'br2');
          newZone.id = id;
          newZone.setAttribute('zone-name', 'UTC');

          var textDiv = document.getElementById('add-zone-text-{id}');
          newZone.innerHTML = textDiv.textContent;

          var script = document.createElement('script');
          var scriptDiv = document.getElementById('add-zone-script-{id}');
          script.textContent = `
            $\{scriptDiv.textContent}
            updateClock($\{idx}, 0);
            `;
          newZone.appendChild(script);
          adder.parentNode.insertBefore(newZone, adder);
        }
        """
      ==
    ==
  ==
::
++  fi
  |%
  ++  plus        (need (de-xml:html '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>'))
  ++  globe       (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-globe"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>'))
  ++  upload      (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-upload"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/></svg>'))
  ++  menu        (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-menu"><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/></svg>'))
  ++  clock       (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>'))
  ++  arrow-down  (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-down"><line x1="12" y1="5" x2="12" y2="19"/><polyline points="19 12 12 19 5 12"/></svg>'))
  ++  play        (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-play"><polygon points="5 3 19 12 5 21 5 3"/></svg>'))
  --
::
++  id
  ^-  tape
  %-  zing
  %+  turn  (pout (slag 1 here.bowl))
  |=  smeg=@ta
  %+  weld  "--"
  (trip smeg)
::
++  widget-id  |=(idx=@ud `tape`"zone-widget-{id}-{(numb:pytz idx)}")
::
++  offset-seconds
  |=  offset=delta:pytz
  ^-  tape
  %+  weld  
    ?:(sign.offset "" "-")
  (numb:pytz (div d.offset ~s1))
::
++  zones
  ^-  (list manx)
  =|  idx=@ud
  |-
  ?~  timezones
    ~
  :_  $(idx +(idx), timezones t.timezones)
  ;div.relative.br2(id (widget-id idx))
    =zone-name  (trip i.timezones)
    ;+  (zone i.timezones)
    ;script: {(clock-ticker idx i.timezones)}
  ==
::
++  start-timer
  |=  offset=delta:pytz
  ^-  tape
  """
  function startTimer() \{
      const currentDateElement = document.getElementById('current-date');
      const currentTimeElement = document.getElementById('current-time');
  
      // Function to update the time
      function updateTime() \{
          const now = new Date(); // Current date and time
          const utcTime = Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), 
                                now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds(), now.getUTCMilliseconds());
          const offsetTime = new Date(utcTime + {(offset-seconds offset)} * 1000);
  
          const hours = offsetTime.getUTCHours();
          const minutes = offsetTime.getUTCMinutes();
          const seconds = offsetTime.getUTCSeconds();
          const year = offsetTime.getUTCFullYear();
          const month = offsetTime.getUTCMonth();
          const date = offsetTime.getUTCDate();
  
          const formattedTime = new Date(Date.UTC(year, month, date, hours, minutes, seconds)).toLocaleTimeString('en-US', \{
              hour: '2-digit',
              minute: '2-digit',
              hour12: true,
              timeZone: 'UTC'
          });
  
          const formattedDate = new Date(Date.UTC(year, month, date)).toLocaleDateString('en-US', \{
              weekday: 'long',
              year: 'numeric',
              month: 'long',
              day: 'numeric',
              timeZone: 'UTC'
          });
  
          currentDateElement.textContent = formattedDate;
          currentTimeElement.textContent = formattedTime;
      }
  
      setInterval(updateTime, 1000);
      updateTime();
  }
  
  startTimer();
  """
::
++  update-clock
  ^-  tape
  """
  function updateClock(idx, offset) \{
    const clock = document.getElementById(`zone-widget-{id}-$\{idx}`);

    const now = new Date();
  
    const utcTime = Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(),
                             now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds(), now.getUTCMilliseconds());
    const offsetTime = new Date(utcTime + offset * 1000);
  
    const seconds = offsetTime.getUTCSeconds() + offsetTime.getUTCMilliseconds() / 1000;
    const minutes = offsetTime.getUTCMinutes() + offsetTime.getUTCSeconds() / 60;
    const hours = offsetTime.getUTCHours() + offsetTime.getUTCMinutes() / 60;
  
    // Adjust hour to 12-hour format
    const displayHours = hours % 12 || 12;
  
    // Calculate rotations
    const secondsRotation = (seconds / 60) * 360;
    const minutesRotation = (minutes / 60) * 360;
    const hoursRotation = (displayHours / 12) * 360;
  
    // Update clock hands
    clock.querySelector('.hand-second').style.transform = `rotate($\{secondsRotation}deg)`;
    clock.querySelector('.hand-minute').style.transform = `rotate($\{minutesRotation}deg)`;
    clock.querySelector('.hand-hour').style.transform = `rotate($\{hoursRotation}deg)`;
  
    // Schedule next update
    requestAnimationFrame(() => updateClock(idx, offset));
  }
  """
::
++  clock-ticker
  |=  [idx=@ud zone-name=@t]
  ^-  tape
  =/  offset=delta:pytz  (need (~(active-offset zn:pytz zone-name) now.bowl))
  """
  {update-clock}
  updateClock({(numb:pytz idx)}, {(offset-seconds offset)});
  """
::
++  zone
  |=  zone-name=@t
  =/  offset=delta:pytz  (need (~(active-offset zn:pytz zone-name) now.bowl))
  =/  active-rule=(unit [@da delta:pytz @t])
    (~(active-rule zn:pytz zone-name) now.bowl)
  =/  next-rule=(unit [@da delta:pytz @t])
    (~(next-rule zn:pytz zone-name) now.bowl)
  =/  zone-data=(list [@da delta:pytz @t])
    (tap:zon:pytz ~(zone zn:pytz zone-name))
  |^
  ^-  manx
  ;div.b1.br2.block.fc.ac.jc.p3.s1.border-2
    =style  "width: 280px; min-height: 280;"
    ;span: {(trip zone-name)}
    ;+  clock
    ;+  zone-form
  ==
  ::
  ++  zone-form
    ^-  manx
    ;form.fr.jc.ac.g1.p1
      =hx-post    "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=zone-name-diff"
      =hx-target  "find .loading"
      =hx-swap    "outerHTML"
      =head       "new-zone"
      =zone-name  ""
      ;button.bd1.br2.p1.b1.hover.loader
        =title    "Browser Timezone"
        =onclick  "this.parentElement.setAttribute('zone-name', Intl.DateTimeFormat().resolvedOptions().timeZone);"
        ;span.loaded
          ;+  globe:fi
        ==
        ;span.loading
          ;+  loading.feather-icons
        ==
      ==
      ;select.bd1.br2.p2.b1.hover.loader
        =title       "Change Timezone"
        =style       "width: 190px;"
        =head       "new-zone"
        =zone-name   (trip zone-name)
        =required    ""
        =onchange    "this.parentElement.setAttribute('zone-name', this.value);"
        ;*  %+  turn  names:pytz
            |=  n=@t
            =/  name=tape  (trip n)
            ?.  =(n zone-name)
              ;option(value "{name}"): {name}
            ;option(value "{name}", selected ""): {name}
      ==
      ;button.bd1.br2.p1.b1.loader
        =title  "Submit"
        ;span.loaded
          ;+  upload:fi
        ==
        ;span.loading
          ;+  loading.feather-icons
        ==
      ==
    ==
  ::
  ++  clock
    ^-  manx
    =/  color-bkg=tape     "#232946"
    =/  color-dark=tape    "#121629"
    =/  color-purple=tape  "#b8c1ec"
    =/  color-pink=tape    "#eebbc3"
    =/  color-white=tape   "#fffffe"
    ;div.clock
      ;svg.clockface
        =style    "width: 220px; height: 220px; filter: drop-shadow(2px 10px 10px {color-dark});"
        =width    "300"
        =height   "300"
        =viewbox  "-150 -150 300 300"
        ;circle.ring.ring-seconds
          =cx                 "0"
          =cy                 "0"
          =r                  "145"
          =fill               color-dark
          =stroke             color-pink
          =stroke-width       "5"
          =pathlength         "60"
          =stroke-dasharray   ".05 .95"
          =stroke-dashoffset  ".025"
          ; 
        ==
        ;circle.ring.ring-hours
          =cx                 "0"
          =cy                 "0"
          =r                  "145"
          =fill               "transparent"
          =stroke             color-purple
          =stroke-width       "10"
          =pathlength         "12"
          =stroke-dasharray   ".1 .9"
          =stroke-dashoffset  ".05"
          ; 
        ==
        ;defs
          ;path(id "circlePath", d "M 0, 115 A 115,115 0 1,1 0,-115 A 115,115 0 1,1 0,115");
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "8%"): 7
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "16%"): 8
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "24.5%"): 9
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "32%"): 10
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "40.5%"): 11
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "48.5%"): 12
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "57.5%"): 1
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "66%"): 2
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "74.5%"): 3
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "83%"): 4
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "91%"): 5
        ==
        ;text(style "fill: #fffffe; font-size: 1.2rem;")
          ;textPath(href "#circlePath", startOffset "99.25%"): 6
        ==
        ;line.hand.hand-minute
          =style           "transform: rotate(45deg);"
          =stroke          color-purple
          =stroke-width    "3"
          =stroke-linecap  "round"
          =x1              "0"
          =y1              "2"
          =x2              "0"
          =y2              "-110"
          ;
        ==
        ;line.hand.hand-hour
          =style           "transform: rotate(90deg);"
          =stroke          color-white
          =stroke-width    "5"
          =stroke-linecap  "round"
          =x1              "0"
          =y1              "2"
          =x2              "0"
          =y2              "-60"
          ;
        ==
        ;circle.ring.ring-center
          =style              "fill: {color-pink};"
          =cx                 "0"
          =cy                 "0"
          =r                  "3"
          =stroke             color-white
          =stroke-width       "2.5"
          ; 
        ==
        ;line.hand.hand-second
          =stroke          color-pink
          =stroke-width    "1"
          =stroke-linecap  "round"
          =x1              "0"
          =y1              "12"
          =x2              "0"
          =y2              "-130"
          ;
        ==
      ==
    ==
  --
--
