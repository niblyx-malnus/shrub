/@  sail
/-  feather-icons
:-  [%sail %$ %htmx]
|=  =sail
|=  =bowl:neo
|^
  ;div.fc.relative.hf.scroll-hidden
    ;+  controls
    ;div.frw.js.as.scroll-y.hf
      =id  "tabs-{id}"
      ;+  editor
      ;+  viewer
    ==
  ==
++  id
  ^-  tape
  %-  zing
  %+  turn  (pout (slag 1 here.bowl))
  |=  smeg=@ta
  %+  weld  "--"
  (trip smeg)
++  controls
  ;div.p2.frw.jc.ac.g3.sticky.wf
    =style  "top:0; left: 0;"
    ;button.p-1.br1.b1.hover
      =type  "button"
      =onclick
        """
        $('#tabs-{id}').children().addClass('hidden');
        $('#editor-{id}').removeClass('hidden');
        $(this).siblings().removeClass('toggled');
        $(this).addClass('toggled');
        """
      ; edit
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
    ;button.p-1.br1.b1.hover.toggled
      =type  "button"
      =onclick
        """
        $('#tabs-{id}').children().addClass('hidden');
        $('#viewer-{id}').removeClass('hidden');
        $(this).siblings().removeClass('toggled');
        $(this).addClass('toggled');
        """
        ;
      ; view
    ==
  ==
++  editor
  ;form.fc.p1.g1.hidden.grow.basis-half.scroll-y.relative
    =id  "editor-{id}"
    =style  "min-width: 300px; height: 100%;"
    =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=sail"
    =hx-swap  "innerHTML"
    =hx-select  "main > div"
    =hx-target  "#viewer-{id}"
    =hx-trigger  "input changed delay:0.4s from:find .cm-config, input changed delay:0.4s from:find .code-text, input changed delay:0.4s from:find .class-text"
    ;link(rel "stylesheet", href "https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.css");
    ;script(src "https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.js");
    ;script(src "https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/keymap/vim.min.js");
    ;details.wf.br1.bd1
      =style  "max-height: 220px;"
      ;summary.p2.br1.b1.f0: code mirror config
      ;div(style "display: flex; flex-direction: column; align-items: center")
        ;textarea.cm-config.p2.br1.m0.pre.mono.grow.scroll-x
          =style  "width: 100%;"
          =name   "cm-config"
          =value  (trip cm-config.sail)
          =placeholder  "Add config in curly braces: \{}"
          =oninput  "this.setAttribute('value', this.value);"
          =spellcheck  "false"
          ; {(trip cm-config.sail)}
        ==
        ;div.p-1.br1.b1.hover
          =style    "justify-content: center; margin: 0.5em"
          =onclick  "refreshTextarea();"
          ;+  refresh
        ==
      ==
    ==
    ;input.class-text.p2.mono.bd1.br1
      =name  "classes"
      =placeholder  "prose p3"
      =type  "text"
      =autocomplete  "off"
      =value  (trip class.sail)
      =oninput  "$(this).attr('value', this.value);"
      ;
    ==
    ;textarea.code-text.p2.pre.mono.scroll-x.grow.bd1.m0.br1
      =name  "code"
      =oninput  "this.setAttribute('value', this.value);"
      =spellcheck  "false"
      =value  ""
      =placeholder  "# new document"
      ; {(trip code.sail)}
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
    ;script
      ;+  ;/
      """
      function refreshTextarea() \{
        var existingEditors = document.querySelectorAll('.CodeMirror');
        // Remove existing CodeMirror instances
        existingEditors.forEach(function(editor) \{
          editor.parentNode.removeChild(editor);
        });

        var textareas = document.querySelectorAll('.code-text');
        textareas.forEach(function(textarea) \{
          var configTextarea = document.querySelector('.cm-config');
          var config;
          try \{
            config = eval('(' + configTextarea.value + ')');
          } catch (e) \{
            alert('Invalid JavaScript configuration');
            return;
          }
          var cmInstance = CodeMirror.fromTextArea(textarea, config);
          cmInstance.on('change', function(cm) \{
            cm.save();
            textarea.value = cm.getValue();
            textarea.setAttribute('value', cm.getValue());
            var event = new Event('input', \{
                bubbles: true,
                cancelable: true,
            });
            textarea.dispatchEvent(event);
          });
          // Escape doesn't make textarea lose focus
          cmInstance.getWrapperElement().addEventListener('keydown', function(event) \{
            if (event.key === 'Escape') \{
              event.stopPropagation();
              event.preventDefault();
            }
            if (event.key === ' ' && event.shiftKey) \{
              cmInstance.getInputField().blur();
            }
          });
          cmInstance.getWrapperElement().style.height = '100%';
        });
      }
      """
    ==
  ==
++  error
  |=  =tang
  ;div.fc.g3.p3.s0
    ;div.pre.mono
      ;*
      %+  turn  (scag 25 tang)
      |=  =tank
      ;span: {(of-wall:format (~(win re tank) 0 80))}
    ==
    ;div.pre.numbered.mono
      ;span: ;>
      ;span;
      ;*
      %+  turn  (to-wain:format code.sail)
      |=  t=@t
      ;span: {(trip t)}
    ==
  ==
++  viewer
  ;main.grow.basis-half.scroll-x.scroll-y.br1
    =id  "viewer-{id}"
    =style  "min-width: 300px; height: 100%;"
    ;+
    ?~  result.sail
      ;div.prose.p3
        ;h1: nothing rendered
        ;p: edit the sail to begin rendering
      ==
    =/  res  (need result.sail)
    ?-  -.res
      %.n  (error +.res)
        %.y
      =-  -(a.g [[%class (trip class.sail)] a.g.-])
      ^-  manx
      +.res
    ==
  ==
::
++  refresh  (need (de-xml:html '<svg style="width: 0.95em; height: 0.95em;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-refresh-ccw"><polyline points="1 4 1 10 7 10"/><polyline points="23 20 23 14 17 14"/><path d="M20.49 9A9 9 0 0 0 5.64 5.64L1 10m22 4l-4.64 4.36A9 9 0 0 1 3.51 15"/></svg>'))
--
