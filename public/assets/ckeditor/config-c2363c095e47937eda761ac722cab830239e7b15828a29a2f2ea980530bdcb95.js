CKEDITOR.stylesSet.add("my_styles",[{name:"Blue Title",element:"h2",styles:{color:"Blue"}},{name:"Red Title",element:"h3",styles:{color:"Red"}},{name:"CSS Style",element:"span",attributes:{"class":"my_style"}},{name:"Marker: Yellow",element:"span",styles:{"background-color":"Yellow"}}]),CKEDITOR.editorConfig=function(e){e.stylesSet="my_styles",e.filebrowserBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashUploadUrl="/ckeditor/attachment_files",e.filebrowserImageBrowseLinkUrl="/ckeditor/pictures",e.filebrowserImageBrowseUrl="/ckeditor/pictures",e.filebrowserImageUploadUrl="/ckeditor/pictures?",e.filebrowserUploadUrl="/ckeditor/attachment_files",e.allowedContent=!0,e.filebrowserUploadMethod="form",e.toolbarGroups=[{name:"styles"},{name:"colors"},{name:"basicstyles",groups:["basicstyles","cleanup"]},{name:"editing",groups:["find","selection","spellchecker"]},{name:"links"},{name:"insert"},{name:"tools"},{name:"document",groups:["mode","document","doctools"]},{name:"others"},{name:"paragraph",groups:["list","indent","blocks","align"]},{name:"clipboard",groups:["undo"]}],e.extraPlugins="codesnippet",e.codeSnippet_theme="railscasts"};