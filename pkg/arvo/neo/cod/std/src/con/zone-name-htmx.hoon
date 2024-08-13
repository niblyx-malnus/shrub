/@  zone-name :: @t
/-  feather-icons
/-  pytz
/-  iso-8601
:-  [%zone-name %$ %htmx]
|=  =zone-name
|=  =bowl:neo
|^
^-  manx
=/  offset=delta:pytz  (need (~(active-offset zn:pytz zone-name) now.bowl))
=/  active-rule=(unit [@da delta:pytz @t])
  (~(active-rule zn:pytz zone-name) now.bowl)
=/  next-rule=(unit [@da delta:pytz @t])
  (~(next-rule zn:pytz zone-name) now.bowl)
=/  zone-data=(list [@da delta:pytz @t])
  (tap:zon:pytz ~(zone zn:pytz zone-name))
;div.b1
  =style
    """
    margin: 1rem;
    width: 280px;
    border-radius: 0.5rem;
    min-height: 280px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    """
  ;div.fr.ac.jc.br2.b2.z1.f3.wf.relative
    =style  "height: 40px;"
    ;button.p1.br1.b1.hover.absolute.toggled
      =title  "Clock View"
      =style  "left: 0.5rem;"
      =onclick
        """
        $('#jumps-tab').addClass('hidden');
        $('#clock-tab').removeClass('hidden');
        $(this).siblings().removeClass('toggled');
        $(this).addClass('toggled');
        """
      ;div
        ;+  clock:fi
      ==
    ==
    ;span.s1
      =title  (trip zone-name)
      =style
        """
        text-align: center;
        width: 180px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        """
      ; {(trip zone-name)}
    ==
    ;button.p1.br1.b1.hover.absolute
      =title  "Offset Jumps"
      =style  "right: 0.5rem;"
      =onclick
        """
        $('#clock-tab').addClass('hidden');
        $('#jumps-tab').removeClass('hidden');
        $(this).siblings().removeClass('toggled');
        $(this).addClass('toggled');
        """
      ;span
        ;+  menu:fi
      ==
    ==
  ==
  ;div(style "height: 260px;")
    ;div#clock-tab.p2(style "margin-top: 0.5rem; margin-bottom: 0.5rem;")
      ;+  (clock offset)
    ==
    ;div#jumps-tab.hidden
      =style  "height: 100%; overflow: scroll;"
      ;table.mono
        ;+  =/  sticky=tape  "position: sticky; top: 0; z-index: 10;"
        ;thead(style sticky)
          ;tr
            ;th.bd1.b3(style sticky): Datetime (UTC)
            ;th.bd1.b3(style sticky): Offset
            ;th.bd1.b3(style sticky): Name
          ==
        ==
        ;tbody
          ;*  =|  i=@ud
              |-
              ?~  zone-data
                ~
              :_  $(i +(i), zone-data t.zone-data)
              =/  [=@da offset=delta:pytz name=@t]  i.zone-data
              =/  datetime=tape
                =/  date=tape   (en:date-input:iso-8601 [[a y] m d.t]:(yore da))
                =/  clock=tape  (en:time-input:iso-8601 `@dr`(mod da ~d1))
                :(weld date " " clock)
              ?.  =(active-rule [~ da offset name])
                ;tr(id "row-{(scow %da da)}")
                  ;td.bd1.b2: {datetime}
                  ;td.bd1.b2: {(en:offset:iso-8601 offset)}
                  ;td.bd1.b2: {(trip name)}
                ==
              ;tr(id "row-{(scow %da da)}")
                ;td.bd1.b-1: {datetime}
                ;td.bd1.b-1: {(en:offset:iso-8601 offset)}
                ;td.bd1.b-1: {(trip name)}
              ==
        ==
      ==
    ==
  ==
  ;div.fc.br2.b2.z1.f3.wf
    ;span.fc.jc.ac
      ;span#current-date.p1.s1: • • •
      ;span#current-time.p1.s1: • • •
      ;script: {(start-timer offset)}
    ==
    ;div.fr.jc.ac.g1.p1
      ;form
        =hx-post    "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=zone-name-diff"
        =hx-target  "find .loading"
        =hx-swap    "outerHTML"
        =head       "new-zone"
        =zone-name  ""
        =onclick    "this.setAttribute('zone-name', Intl.DateTimeFormat().resolvedOptions().timeZone);"
        ;button.bd1.br2.p1.b1.hover.loader
          =title  "Browser Timezone"
          ;span.loaded
            ;+  globe:fi
          ==
          ;span.loading
            ;+  loading.feather-icons
          ==
        ==
      ==
      ;select.bd1.br2.p2.b1.hover.loader
        =title       "Change Timezone"
        =style       "width: 190px;"
        =hx-post     "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=zone-name-diff"
        =hx-trigger  "change"
        =hx-target   "#button-loading"
        =hx-swap     "outerHTML"
        =head       "new-zone"
        =zone-name   (trip zone-name)
        =required    ""
        =onchange    "this.setAttribute('zone-name', this.value);"
        ;*  %+  turn  names:pytz
            |=  n=@t
            =/  name=tape  (trip n)
            ?.  =(n zone-name)
              ;option(value "{name}"): {name}
            ;option(value "{name}", selected ""): {name}
      ==
      ;div.bd1.br2.p1.b1.loader
        =title  "Loading Indicator"
        ;span.loaded
          ;+  upload:fi
        ==
        ;span#button-loading.loading
          ;+  loading.feather-icons
        ==
      ==
      ;div#dst-trigger.hidden
        =hx-post     "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=zone-name-diff"
        =hx-trigger  "dst-trigger"
        =hx-target   "#button-loading"
        =hx-swap     "outerHTML"
        =head       "new-zone"
        =zone-name   (trip zone-name)
        ;
      ==
      ;script
        ;+
        ?~  next-rule
          ;/  ""
        =/  unix-ms=@ud  (div (sub -.u.next-rule ~1970.1.1) (div ~s1 1.000))
        ;/
        """
        function checkTimeAndTrigger() \{
          const target = new Date({(numb:pytz unix-ms)});
          const now = new Date();

          console.log("Checking DST Jump:");
          console.log("Current Time:", now.toUTCString());
          console.log("Target Time:", target.toUTCString());
          console.log("Target Reached:", target.getTime() <= now.getTime());

          if (target.getTime() <= now.getTime()) \{
            htmx.trigger(htmx.find("#dst-trigger"), "dst-trigger");
          }
        }

        // Check the time every minute
        setInterval(checkTimeAndTrigger, 60000);
        """
      ==
    ==
  ==
==
::
++  fi
  |%
  ++  globe       (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-globe"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>'))
  ++  upload      (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-upload"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/></svg>'))
  ++  menu        (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-menu"><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/></svg>'))
  ++  clock       (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>'))
  ++  arrow-down  (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-down"><line x1="12" y1="5" x2="12" y2="19"/><polyline points="19 12 12 19 5 12"/></svg>'))
  ++  play        (need (de-xml:html '<svg style="width: 0.85em, height: 0.85em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-play"><polygon points="5 3 19 12 5 21 5 3"/></svg>'))
  --
::
++  start-timer
  |=  offset=delta:pytz
  ^-  tape
  =/  offset-tape=tape
    %+  weld  
      ?:(sign.offset "" "-")
    (numb:pytz (div d.offset ~s1))
  """
  function startTimer() \{
      const currentDateElement = document.getElementById('current-date');
      const currentTimeElement = document.getElementById('current-time');
  
      // Function to update the time
      function updateTime() \{
          const now = new Date(); // Current date and time
          const utcTime = Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), 
                                now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds(), now.getUTCMilliseconds());
          const offsetTime = new Date(utcTime + {offset-tape} * 1000);
  
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
++  clock
  |=  offset=delta:pytz
  ^-  manx
  =/  color-bkg=tape     "#232946"
  =/  color-dark=tape    "#121629"
  =/  color-purple=tape  "#b8c1ec"
  =/  color-pink=tape    "#eebbc3"
  =/  color-white=tape   "#fffffe"
  ;div#clock-1
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
    ;script: {(clock-tick offset)}
  ==
::
++  clock-tick
  |=  offset=delta:pytz
  ^-  tape
  =/  offset-tape=tape
    %+  weld  
      ?:(sign.offset "" "-")
    (numb:pytz (div d.offset ~s1))
  """
  function updateClock() \{
    const clock = document.getElementById('clock-1');
  
    const now = new Date();
  
    const utcTime = Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(),
                             now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds(), now.getUTCMilliseconds());
    const offsetTime = new Date(utcTime + {offset-tape} * 1000);
  
    const seconds = offsetTime.getUTCSeconds() + offsetTime.getUTCMilliseconds() / 1000;
    const minutes = offsetTime.getUTCMinutes() + offsetTime.getUTCSeconds() / 60;
    const hours = offsetTime.getUTCHours() + offsetTime.getUTCMinutes() / 60;
    const ampm = hours >= 12 ? 'pm' : 'am';
  
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
    requestAnimationFrame(updateClock);
  }
  
  // Initialize clock
  updateClock();
  """
--
