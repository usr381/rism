CKEDITOR.on("instanceReady",function(e){var t,n=e.editor,o=CKEDITOR.document.$.getElementsByName("ckeditor-sample-required-plugins"),i=o.length?CKEDITOR.dom.element.get(o[0]).getAttribute("content").split(","):[],l=[];if(i.length){for(t=0;t<i.length;t++)n.plugins[i[t]]||l.push("<code>"+i[t]+"</code>");l.length&&CKEDITOR.dom.element.createFromHtml('<div class="warning"><span>To fully experience this demo, the '+l.join(", ")+" plugin"+(1<l.length?"s are":" is")+" required.</span></div>").insertBefore(n.container)}var r=new CKEDITOR.dom.document(document).find(".button_icon");for(t=0;t<r.count();t++){var d=r.getItem(t),s=d.getAttribute("data-icon"),a=CKEDITOR.skin.getIconStyle(s,"rtl"==CKEDITOR.lang.dir);d.addClass("cke_button_icon"),d.addClass("cke_button__"+s+"_icon"),d.setAttribute("style",a),d.setStyle("float","none")}});