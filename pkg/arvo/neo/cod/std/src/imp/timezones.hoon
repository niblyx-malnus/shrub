/@  timezones :: (list @t)
/-  server
^-  kook:neo
|%
++  state
  ^-  curb:neo
  [%pro %timezones]
::
++  poke
  ^-  (set stud:neo)
  (sy %timezones %eyre-task ~)
::
++  kids
  ^-  kids:neo
  *kids:neo
::
++  deps
  ^-  deps:neo
  *deps:neo
::
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
    ++  init
      |=  pal=(unit pail:neo)
      :_  (need pal)
      =/  =pith:neo  #/[p/our.bowl]/$/eyre
      =/  =binding:eyre  [~ %test (pout here.bowl)]
      =/  =req:eyre:neo  [%connect binding here.bowl]
      :~  [pith %poke eyre-req/!>(req)]
      ==
    ::
    ++  poke
      |=  [=stud:neo =vase]
      ^-  (quip card:neo pail:neo)
      ?+    stud  !!
        %timezones  [~ stud vase]
        ::
        %eyre-task
        =/  sev  ~(. neo:server #/[p/our.bowl]/$/eyre)
        =+  !<(=task:eyre:neo vase)
        =/  [eyre-id=@ta req=inbound-request:eyre]  task
        :_  pail
        ?.  authenticated.req
          (respond:sev eyre-id (login-redirect:gen:server request.req))
        =/  =manx
          ;div: Hello world!
        (respond:sev eyre-id (manx-response:gen:server manx))
      ==
  --
--
