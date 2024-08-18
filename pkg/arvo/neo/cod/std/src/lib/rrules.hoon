/-  time
/-  pytz
=,  time
=,  pytz
|%
:: Arguments for recurrence rule builders
::
+$  arg
  $%  [%ud p=@ud]        :: natural number (unsigned decimal)
      [%od p=ord]        :: ordinal numbers for weekday in a month
      [%da p=@da]        :: datetime-local
      [%tz p=@t]         :: a IANA timezone name
      [%dr p=@dr]        :: duration
      [%dl p=delta]      :: delta (signed @dr)
      [%dx p=dext]       :: indexed datetime
      [%wd p=wkd]        :: weekday
      [%wl p=(list wkd)] :: weekday list
      [%dt p=fuld]       :: date-input
      [%ct p=@dr]        :: clocktime / time-input
      [%mt p=munt]       :: month-input
      [%wk p=week]       :: week-input
  ==
::
+$  args  (map @t arg)
:: Expected parameter list
::
+$  parm  (list (pair @t term))
::
+$  date-rule  $-(@ud @da)         :: UTC time
+$  span-rule  $-(@ud [@da @da])   :: pair of UTC times
+$  fuld-rule  $-(@ud fuld)        :: fullday (timezone independent)
+$  dext-rule  $-(@ud dext)        :: timezone-relative indexed time
+$  paxt-rule  $-(@ud [dext dext]) :: pair of timezone indexed times
::
+$  date-rule-builder  $-(args date-rule)
+$  span-rule-builder  $-(args span-rule)
+$  fuld-rule-builder  $-(args fuld-rule)
::
++  standard
  |%
  ++  helpers
    |%
    :: This produces a rule from any args that crashes
    :: indicating the instance was deliberately skipped.
    :: NOTE: Actual results for an instance should be stored
    ::       in an (each [datetime-type] tang).
    :: 
    ++  skip  _|=(idx=@ud ~|(%skip !!))
    ::
    ++  nth-weekday-of-month
      |=  [month=munt =ord =wkd]
      ^-  fuld
      =/  day=fuld  [[a y] m 1]:month
      :: shift to first instance of the weekday
      ::
      =/  w  (get-weekday (year [[a y] m 1 0 0 0 ~]:month))
      =/  d
        ?:  =(w (wkd-to-num wkd))
          0
        (sub-wkd (wkd-to-num wkd) w)
      =.  d.day  (add d d.day)
      :: add n weeks
      ::
      ?-    ord
        %first   day
        %second  day(d (add 7 d.day))
        %third   day(d (add 14 d.day))
        %fourth  day(d (add 21 d.day))
        ::
          %last
        ?.  (lte (add 28 d.day) (days-in-month [[a y] m]:day))
          day(d (add 21 d.day))
        day(d (add 28 d.day))
      ==
    ::
    ++  first-weekday-after
      |=  [start=fuld =wkd]
      ^-  fuld
      =/  day=@da  (fuld-to-da start)
      =/  w=@ud  (get-weekday day)            :: starting weekday
      =/  d=@ud  (sub-wkd (wkd-to-num wkd) w) :: distance from wkd
      (da-to-fuld (add day (mul d ~d1)))
    ::
    ++  days-of-week
      |=  [start=fuld weekdays=(list wkd)]
      ^-  fuld-rule
      |=  idx=@ud
      ^-  fuld
      =/  weekdays=(list wkd-num)  (turn weekdays wkd-to-num)
      =/  cycle-count=@ud          (div idx (lent weekdays))
      =/  cycle-offset=@ud         (mod idx (lent weekdays))
      =/  start-weekday=wkd-num    (get-weekday (fuld-to-da start))
      =/  shifted-days=(list @ud)  (sort (turn weekdays (curr sub-wkd start-weekday)) lth)
      =/  total-offset=@ud         (add (mul 7 cycle-count) (snag cycle-offset shifted-days))
      (da-to-fuld (add (fuld-to-da start) (mul ~d1 total-offset)))
    ::
    ++  monthly-nth-weekday
      |=  [start=munt =ord =wkd]
      ^-  fuld-rule
      |=  idx=@ud
      ^-  fuld
      =/  start-month=@ud  (dec m.start) :: 0-indexed
      =/  new-years=@ud    (div (add idx (dec m.start)) 12)
      =/  curr-year=anum   (shift-anum [a y]:start & new-years)
      =/  curr-month=@ud   +((mod (add idx (dec m.start)) 12))
      (nth-weekday-of-month:helpers [curr-year curr-month] ord wkd)
    ::
    ++  monthly-on-day
      |=  start=fuld
      ^-  fuld-rule
      |=  idx=@ud
      ^-  fuld
      =/  curr-year=anum   (shift-anum [a y]:start & (div (add idx (dec m.start)) 12))
      =/  curr-month=@ud   +((mod (add idx (dec m.start)) 12))
      =/  =fuld  [curr-year curr-month d.start]
      ~|  "This day does not exist in this month."
      ?>  (valid-fuld fuld)
      fuld
    ::
    ++  yearly-on-date
      |=  start=fuld
      ^-  fuld-rule
      |=  idx=@ud
      ^-  fuld
      =/  curr-year=anum  (shift-anum [a y]:start & idx)
      =/  =fuld  [curr-year [m d]:start]
      ~|  "This date does not exist in this year."
      ?>  (valid-fuld fuld)
      fuld
    --
  ::
  ++  paxt-rules
    |%
    ++  single
      |=  =args
      =/  sd=fuld  +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  sc=@dr   +:;;($>(%ct arg) (~(got by args) 'Start Clocktime'))
      =/  ed=fuld  +:;;($>(%dt arg) (~(got by args) 'End Date'))
      =/  ec=@dr   +:;;($>(%ct arg) (~(got by args) 'End Clocktime'))
      ^-  paxt-rule
      |=  @ud
      =/  start=dext  [0 (add sc (fuld-to-da sd))]
      =/  end=dext    [0 (add ec (fuld-to-da ed))]
      [start end]
    --
  ::
  ++  dext-rules
    |%
    ++  single
      |=  =args
      =/  sd=fuld  +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  ct=@dr   +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      ^-  dext-rule
      |=(@ud [0 (add ct (fuld-to-da sd))])
    ::
    ++  periodic
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  ct=@dr      +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      =/  period=@dr  +:;;($>(%dr arg) (~(got by args) 'Period'))
      ^-  dext-rule
      |=  idx=@ud
      [0 (add (mul idx period) (add ct (fuld-to-da start)))]
    ::
    ++  days-of-week
      |=  =args
      =/  start=fuld           +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  ct=@dr               +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      =/  weekdays=(list wkd)  +:;;($>(%wl arg) (~(got by args) 'Weekdays'))
      ^-  dext-rule
      |=  idx=@ud
      =/  =fuld  ((days-of-week:helpers start weekdays) idx)
      [0 (add (fuld-to-da fuld) ct)]
    ::
    ++  monthly-nth-weekday
      |=  =args
      =/  start=munt  +:;;($>(%mt arg) (~(got by args) 'Start Date'))
      =/  ct=@dr      +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      =/  =ord        +:;;($>(%od arg) (~(got by args) 'Ordinal'))
      =/  =wkd        +:;;($>(%wd arg) (~(got by args) 'Weekday'))
      ^-  dext-rule
      |=  idx=@ud
      =/  =fuld  ((monthly-nth-weekday:helpers start ord wkd) idx)
      [0 (add (fuld-to-da fuld) ct)]
    ::
    ++  monthly-on-day
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  ct=@dr      +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      ^-  dext-rule
      |=  idx=@ud
      =/  =fuld  ((monthly-on-day:helpers start) idx)
      [0 (add (fuld-to-da fuld) ct)]
    ::
    ++  yearly-on-date
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  ct=@dr      +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      ^-  dext-rule
      |=  idx=@ud
      =/  =fuld  ((yearly-on-date:helpers start) idx)
      [0 (add (fuld-to-da fuld) ct)]
    --
  ::
  ++  fuld-rules
    |%
    ++  get-by-name
      |=  name=@t
      ^-  [@t parm fuld-rule-builder]
      ?+    name  !!
          %single
        ['Single' ['Date' %dt]~ single]
        ::
          %periodic
        =;  parm
          ['Periodic' parm periodic]
        :~  ['Start' %dt]
            ['Period' %dr]
        ==
        ::
          %days-of-week
        =;  parm
          ['Days of Week' parm days-of-week]
        :~  ['Start' %dt]
            ['Weekdays' %wl]
        ==
        ::
          %monthly-nth-weekday
        =;  parm
          ['Monthly nth Weekday' parm monthly-nth-weekday]
        :~  ['Start Month' %mt]
            ['Ordinal' %od]
            ['Weekday' %wd]
        ==
        ::
          %monthly-on-day
        ['Monthly on Day' ['Start' %dt]~ monthly-on-day]
        ::
          %yearly-on-date
        ['Yearly on Date' ['Start' %dt]~ yearly-on-date]
      ==
    ::
    ++  single
      |=  =args
      =/  date=fuld  +:;;($>(%dt arg) (~(got by args) 'Date'))
      ^-  fuld-rule
      |=(@ud date)
    ::
    ++  periodic
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start'))
      =/  period=@dr  +:;;($>(%dr arg) (~(got by args) 'Period'))
      =/  =time  (fuld-to-da start)
      ^-  fuld-rule
      |=  idx=@ud
      (da-to-fuld (add time (mul idx period)))
    ::
    ++  days-of-week
      |=  =args
      =/  start=fuld           +:;;($>(%dt arg) (~(got by args) 'Start'))
      =/  weekdays=(list wkd)  +:;;($>(%wl arg) (~(got by args) 'Weekdays'))
      ^-  fuld-rule
      |=  idx=@ud
      ((days-of-week:helpers start weekdays) idx)
    ::
    ++  monthly-nth-weekday
      |=  =args
      =/  start=munt  +:;;($>(%mt arg) (~(got by args) 'Start'))
      =/  =ord        +:;;($>(%od arg) (~(got by args) 'Ordinal'))
      =/  =wkd        +:;;($>(%wd arg) (~(got by args) 'Weekday'))
      ^-  fuld-rule
      |=  idx=@ud
      ((monthly-nth-weekday:helpers start ord wkd) idx)
    ::
    ++  monthly-on-day
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start'))
      ^-  fuld-rule
      |=  idx=@ud
      ((monthly-on-day:helpers start) idx)
    ::
    ++  yearly-on-date
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start'))
      ^-  fuld-rule
      |=  idx=@ud
      ((yearly-on-date:helpers start) idx)
    --
  ::
  ++  date-rules
    |%
    ++  single
      |=  =args
      =/  =time  +:;;($>(%da arg) (~(got by args) 'Time'))
      ^-  date-rule
      |=(@ud time)
    ::
    ++  yearly-first-weekday-after
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  =wkd        +:;;($>(%wd arg) (~(got by args) 'Weekday'))
      =/  time=@dr    +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      =/  =delta      +:;;($>(%dl arg) (~(got by args) 'Offset'))
      ^-  date-rule
      |=  idx=@ud
      =/  =fuld  [(shift-anum [a y]:start & idx) [m d]:start]
      ?.  (valid-fuld fuld)
        ~|  'The reference day does not exist.'
        !!
      =/  day=@da  (fuld-to-da (first-weekday-after:helpers fuld wkd))
      (apply-invert-delta (add day time) delta)
    ::
    ++  yearly-nth-weekday-of-month
      |=  =args
      =/  start=munt  +:;;($>(%mt arg) (~(got by args) 'Start Month'))
      =/  =ord        +:;;($>(%od arg) (~(got by args) 'Ordinal'))
      =/  =wkd        +:;;($>(%wd arg) (~(got by args) 'Weekday'))
      =/  time=@dr    +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      =/  =delta      +:;;($>(%dl arg) (~(got by args) 'Offset'))
      ^-  date-rule
      |=  idx=@ud
      =/  =anum  (shift-anum [a y]:start & idx)
      =/  =fuld  (nth-weekday-of-month:helpers [anum m.start] ord wkd)
      =/  day=@da  (fuld-to-da fuld)
      (apply-invert-delta (add day time) delta)
    ::
    ++  yearly-on-date
      |=  =args
      =/  start=fuld  +:;;($>(%dt arg) (~(got by args) 'Start Date'))
      =/  time=@dr    +:;;($>(%ct arg) (~(got by args) 'Clocktime'))
      =/  =delta      +:;;($>(%dl arg) (~(got by args) 'Offset'))
      ^-  date-rule
      |=  idx=@ud
      =/  =fuld  [(shift-anum [a y]:start & idx) [m d]:start]
      ?.  (valid-fuld fuld)
        ~|  'This date does not exist.'
        !!
      (apply-invert-delta (add (fuld-to-da fuld) time) delta)
    --
  ::
  ++  span-rules
    |%
    ++  all
      ^-  (map term [@t parm span-rule-builder])
      %-  ~(gas by *(map term [@t parm span-rule-builder]))
      :~  :-  %single-by-end
          =;  =parm
            ['Single by End' parm single:both]
          :~  ['Start Date' %dt]
              ['Start Clocktime' %ct]
              ['Start Timezone' %tz]
              ['End Date' %dt]
              ['End Clocktime' %ct]
              ['End Timezone' %tz]
          ==
          ::
          :-  %single
          =;  =parm
            ['Single' parm single:left]
          :~  ['Timezone' %tz]
              ['Duration' %dr]
              ['Start Date' %dt]
              ['Clocktime' %ct]
          ==
          ::
          :-  %periodic
          =;  =parm
            ['Periodic' parm periodic:left]
          :~  ['Timezone' %tz]
              ['Duration' %dr]
              ['Start Date' %dt]
              ['Clocktime' %ct]
              ['Period' %dr]
          ==
          ::
          :-  %days-of-week
          =;  =parm
            ['Days of Week' parm days-of-week:left]
          :~  ['Timezone' %tz]
              ['Duration' %dr]
              ['Start Date' %dt]
              ['Clocktime' %ct]
              ['Weekdays' %wl]
          ==
          ::
          :-  %monthly-nth-weekday
          =;  =parm
            ['Monthly nth Weekday' parm monthly-nth-weekday:left]
          :~  ['Timezone' %tz]
              ['Duration' %dr]
              ['Start Month' %mt]
              ['Clocktime' %ct]
              ['Ordinal' %od]
              ['Weekday' %wd]
          ==
          ::
          :-  %monthly-on-day
          =;  =parm
            ['Monthly on Day' parm monthly-on-day:left]
          :~  ['Timezone' %tz]
              ['Duration' %dr]
              ['Start Date' %dt]
              ['Clocktime' %ct]
          ==
          ::
          :-  %yearly-on-date
          =;  =parm
            ['Yearly on Date' parm yearly-on-date:left]
          :~  ['Timezone' %tz]
              ['Duration' %dr]
              ['Start Date' %dt]
              ['Clocktime' %ct]
          ==
      ==
    ::
    ++  both
      |%
      ++  to-span-rule
        |=  [lz=@t rz=@t =paxt-rule]
        ^-  span-rule
        |=  idx=@ud
        ^-  [@da @da]
        =/  [l=dext r=dext]
          ~|  "paxt rule crash"
          (paxt-rule idx)
        =/  l-utc=@da
          ~|  "invalid start localtime"
          (need (~(tz-to-utc zn lz) l))
        =/  r-utc=@da
          ~|  "invalid end localtime"
          (need (~(tz-to-utc zn rz) r))
        ~|  "out of order"
        ?>  (lte l-utc r-utc)
        [l-utc r-utc]
      ::
      ++  get-lz-rz
        |=  =args
        ^-  [@t @t]
        =/  lz=@t  +:;;($>(%tz arg) (~(got by args) 'Start Timezone'))
        =/  rz=@t  +:;;($>(%tz arg) (~(got by args) 'End Timezone'))
        [lz rz]
      ::
      ++  single
        |=  =args
        ^-  span-rule
        =/  [lz=@t rz=@t]  (get-lz-rz args)
        (to-span-rule lz rz (single:paxt-rules args))
      --
    ::
    ++  left
      |%
      ++  to-span-rule
        |=  [tz=@t d=@dr =dext-rule]
        ^-  span-rule
        |=  idx=@ud
        ^-  [@da @da]
        =/  =dext
          ~|  "dext rule crash"
          (dext-rule idx)
        =/  l-utc=@da
          ~|  "invalid start localtime"
          (need (~(tz-to-utc zn tz) dext))
        =/  r-utc=@da  (add l-utc d)
        [l-utc r-utc]
      ::
      ++  get-tz-d
        |=  =args
        ^-  [@t @dr]
        =/  tz=@t  +:;;($>(%tz arg) (~(got by args) 'Timezone'))
        =/  d=@dr  +:;;($>(%dr arg) (~(got by args) 'Duration'))
        [tz d]
      ::
      ++  single
        |=  =args
        ^-  span-rule
        =/  [tz=@t d=@dr]  (get-tz-d args)
        (to-span-rule tz d (single:dext-rules args))
      ::
      ++  periodic
        |=  =args
        ^-  span-rule
        =/  [tz=@t d=@dr]  (get-tz-d args)
        (to-span-rule tz d (periodic:dext-rules args))
      ::
      ++  days-of-week
        |=  =args
        ^-  span-rule
        =/  [tz=@t d=@dr]  (get-tz-d args)
        (to-span-rule tz d (days-of-week:dext-rules args))
      ::
      ++  monthly-nth-weekday
        |=  =args
        ^-  span-rule
        =/  [tz=@t d=@dr]  (get-tz-d args)
        (to-span-rule tz d (monthly-nth-weekday:dext-rules args))
      ::
      ++  monthly-on-day
        |=  =args
        ^-  span-rule
        =/  [tz=@t d=@dr]  (get-tz-d args)
        (to-span-rule tz d (monthly-on-day:dext-rules args))
      ::
      ++  yearly-on-date
        |=  =args
        ^-  span-rule
        =/  [tz=@t d=@dr]  (get-tz-d args)
        (to-span-rule tz d (yearly-on-date:dext-rules args))
      --
    --
  --
--
