CKEDITOR.dialog.add("a11yHelp",function(t){function l(e){for(var n,a,t=[],l=0;l<i.length;l++)a=i[l],1<(n=e/i[l])&&n<=2&&(e-=a,t.push(d[a]));return t.push(d[e]||String.fromCharCode(e)),t.join("+")}function g(e,n){var a=t.getCommandKeystroke(n,!0);return a.length?CKEDITOR.tools.array.map(a,l).join(" / "):e}var m=t.lang.a11yhelp,e=t.lang.common.keyboard,u=CKEDITOR.tools.getNextId(),h=/\$\{(.*?)\}/g,i=[CKEDITOR.ALT,CKEDITOR.SHIFT,CKEDITOR.CTRL],d={8:e[8],9:m.tab,13:e[13],16:e[16],17:e[17],18:e[18],19:m.pause,20:m.capslock,27:m.escape,33:m.pageUp,34:m.pageDown,35:e[35],36:e[36],37:m.leftArrow,38:m.upArrow,39:m.rightArrow,40:m.downArrow,45:m.insert,46:e[46],91:m.leftWindowKey,92:m.rightWindowKey,93:m.selectKey,96:m.numpad0,97:m.numpad1,98:m.numpad2,99:m.numpad3,100:m.numpad4,101:m.numpad5,102:m.numpad6,103:m.numpad7,104:m.numpad8,105:m.numpad9,106:m.multiply,107:m.add,109:m.subtract,110:m.decimalPoint,111:m.divide,112:m.f1,113:m.f2,114:m.f3,115:m.f4,116:m.f5,117:m.f6,118:m.f7,119:m.f8,120:m.f9,121:m.f10,122:m.f11,123:m.f12,144:m.numLock,145:m.scrollLock,186:m.semiColon,187:m.equalSign,188:m.comma,189:m.dash,190:m.period,191:m.forwardSlash,192:m.graveAccent,219:m.openBracket,220:m.backSlash,221:m.closeBracket,222:m.singleQuote};return d[CKEDITOR.ALT]=e[18],d[CKEDITOR.SHIFT]=e[16],d[CKEDITOR.CTRL]=CKEDITOR.env.mac?e[224]:e[17],{title:m.title,minWidth:600,minHeight:400,contents:[{id:"info",label:t.lang.common.generalTab,expand:!0,elements:[{type:"html",id:"legends",style:"white-space:normal;",focus:function(){this.getElement().focus()},html:function(){for(var e='<div class="cke_accessibility_legend" role="document" aria-labelledby="'+u+'_arialbl" tabIndex="-1">%1</div><span id="'+u+'_arialbl" class="cke_voice_label">'+m.contents+" </span>",n=[],a=m.legend,t=a.length,l=0;l<t;l++){for(var i=a[l],d=[],o=i.items,c=o.length,r=0;r<c;r++){var s,p=o[r];(s=(s=CKEDITOR.env.edge&&p.legendEdge?p.legendEdge:p.legend).replace(h,g)).match(h)||d.push("<dt>%1</dt><dd>%2</dd>".replace("%1",p.name).replace("%2",s))}n.push("<h1>%1</h1><dl>%2</dl>".replace("%1",i.name).replace("%2",d.join("")))}return e.replace("%1",n.join(""))}()+'<style type="text/css">.cke_accessibility_legend{width:600px;height:400px;padding-right:5px;overflow-y:auto;overflow-x:hidden;}.cke_browser_quirks .cke_accessibility_legend,{height:390px}.cke_accessibility_legend *{white-space:normal;}.cke_accessibility_legend h1{font-size: 20px;border-bottom: 1px solid #AAA;margin: 5px 0px 15px;}.cke_accessibility_legend dl{margin-left: 5px;}.cke_accessibility_legend dt{font-size: 13px;font-weight: bold;}.cke_accessibility_legend dd{margin:10px}</style>'}]}],buttons:[CKEDITOR.dialog.cancelButton]}});