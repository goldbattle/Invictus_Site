/*
Markdown HTML Form

Copyright (c) 2013 Justin McCandless (justinmccandless.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


(function() {
  var MdHtmlForm;

  MdHtmlForm = (function() {

    MdHtmlForm.prototype.form = null;

    MdHtmlForm.prototype.html = "";

    MdHtmlForm.prototype.md = "";

    MdHtmlForm.prototype.objMd = null;

    MdHtmlForm.prototype.group = "";

    MdHtmlForm.prototype.dataGroup = "";

    MdHtmlForm.prototype.selHtml = ".mdhtmlform-html";

    MdHtmlForm.prototype.selMd = ".mdhtmlform-md";

    function MdHtmlForm(obj) {
      var me;
      this.objMd = obj;
      this.group = $(this.objMd).data(this.dataGroup);
      if (this.group != null) {
        this.selHtml = this.selHtml + "[data-" + this.dataGroup + "=" + this.group + "]";
        this.selMd = this.selMd + "[data-" + this.dataGroup + "=" + this.group + "]";
      }
      this.md = $(this.objMd).val();
      me = this;
      $(this.objMd).on("keyup", function(e) {
        return me.updateMdToHtml();
      });
      $("textarea" + this.selHtml).bind("keyup", function(e) {
        return me.updateHtmlToMd(false);
      });
      $(this.selHtml).bind("hallomodified", function(event, data) {
        return me.updateHtmlToMd(true);
      });
      this.updateMdToHtml();
    }

    MdHtmlForm.prototype.updateMdToHtml = function() {
      this.md = $(this.objMd).val();
      this.convertMdToHtml();
      return this.render(false);
    };

    MdHtmlForm.prototype.updateHtmlToMd = function(ignoreHallo) {
      if ($("div" + this.selHtml).hallo != null) {
        this.html = $("div" + this.selHtml).html();
      } else {
        this.html = $("textarea" + this.selHtml).val();
      }
      this.convertHtmlToMd();
      return this.render(ignoreHallo);
    };

    MdHtmlForm.prototype.convertMdToHtml = function() {
      var converter;
      if (window.hasOwnProperty("Showdown")) {
        converter = new Showdown.converter();
        return this.html = converter.makeHtml(this.md);
      } else {
        return console.log("Error: mdhtmlform: Showdown not properly included");
      }
    };

    MdHtmlForm.prototype.convertHtmlToMd = function() {
      if (window.hasOwnProperty("toMarkdown")) {
        return this.md = toMarkdown(this.html);
      } else {
        return console.log("Error: mdhtmlform: to-markdown not properly included");
      }
    };

    MdHtmlForm.prototype.render = function(ignoreHallo) {
      if (!($("div" + this.selHtml).hallo != null) || !ignoreHallo) {
        $("div" + this.selHtml).html(this.html);
      }
      $(this.objMd).val(this.md);
      return $("textarea" + this.selHtml).val(this.html);
    };

    return MdHtmlForm;

  })();

  $(function() {
    return $(".mdhtmlform-md").each(function() {
      return new MdHtmlForm(this);
    });
  });

}).call(this);
