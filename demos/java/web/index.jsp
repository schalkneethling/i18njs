<%-- 
    Document   : index
    Created on : 02 Sep 2011, 9:46:39 PM
    Author     : espressive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>i18njs</title>
	<link href="http://fonts.googleapis.com/css?family=Love+Ya+Like+A+Sister" rel="stylesheet" type="text/css" />
        <link href="css/screen.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
	<div class="container">
		<h1>i18njs > internationalize your javascript</h1>
		<p>i18njs is a small JavaScript library that allows you to easily internationalize all messages, formats, currency symbols and more using the familiar <a href="http://json.org">JSON format</a>. The basic usage is as follows:</p>
<code>
<pre>
var options = {
    dataUrl: "http://i18njs.espressive.org/get-lang",
    supportLocale: true
};
i18n.init(options);
</pre>
</code>
		<p>The two options you pass to i18njs is</p>
		<ul>
		    <li>@dataUrl: This is the URL of the server side 'script' that will return the language and locale part of the Accept-language HTTP header.</li>
		    <li>@supportLocale: This indicates whether files should be loaded based on the entire locale i.e. en-US.json or just the language en.json</li>
		</ul>
		<p class="ps">P.S. You are welcome to use http://i18njs.espressive.org/get-lang for your data URL</p>
		<p>Let's look at a simple use case. Below is a form where the fields is being validated on blur. Depending on the language set in your browser, these message will either be in English(default and fallback) or, in French or German. You can support as many or as few languages as your application requires, I just have three here. Go ahead, try it out.</p>
		<form name="signup" id="signup" action="./" method="post">
		    <fieldset>
			<legend>Sign Up For Some Awesome Social Thing That Is Going To Kill Facebook</legend>
		        <div class="elem_group">
		            <label for="first_name">Your name: </label><br />
		            <input type="text" name="first_name" id="first_name" />
		        </div>

		        <div class="elem_group">
		            <label for="landline">Phone number: </label><br />
		            <input type="text" name="landline" id="landline" />
		        </div>

		        <div class="elem_group">
		            <label for="email">Email: </label><br />
		            <input type="text" name="email" id="email" />
		        </div>

		        <input type="submit" value="Submit" />
		    </fieldset>
		</form>
		<p>And here is the code behind it:</p>
<code>
<pre>
showError = function(ctx, msgKey) {
    var errorContainer = document.createElement("p");
    errorContainer.setAttribute("class", "error");

    //First remove any error messages so we do not duplicate
    ctx.next(".error").remove();
    $(errorContainer).append(i18n.msgStore[msgKey]).insertAfter(ctx);
};

$("#first_name").blur(function(event) {

    var nameErr = $(this).next(".error");

    if($.trim($(this).val()) === "") {
       showError($(this), "firstNameReq");
    } else if(nameErr) {
        nameErr.remove();
    }
});
</pre>
</code>
		<p>Now, even though the 'Accept-Language' HTTP header information that is going to be sent by the server is accurate, we do not want to leave our users stranded is say, the server get's it wrong or, the user just wishes to use a different language. i18njs provides the <code>userSelected</code> function to allow you to handle these situations.</p>
		<p>Below is a simple example:</p>
		<h2>Choose your prefered language:</h2>
		<ul id="langswitch">
		    <li><a href="#switchlang" hreflang="fr">French</a></li>
		    <li><a href="#switchlang" hreflang="de">German</a></li>
		</ul>
		
		<p>And below, is the code to make this happen:</p>
<code>
<pre>
// Overriding language set based on user selection
$("#langswitch a").each(function() {
    $(this).click(function(event) {
        event.preventDefault();
        i18n.userSelected($(this).attr("hreflang"));
    });
});
</pre>
</code>
	<p>And that is pretty much that. There are some more <a href="">technical details you can read about on the blog post</a>, the <a href="https://github.com/ossreleasefeed/i18njs">and the code as well as some demos in Java and Rails are available on Github</a> and I welcome contributions and feedback from everyone.</p>
	</div>
	<a href="http://github.com/ossreleasefeed"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://a248.e.akamai.net/assets.github.com/img/e6bef7a091f5f3138b8cd40bc3e114258dd68ddf/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67" alt="Fork me on GitHub"></a>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
        <script src="js/i18n.js"></script>
        <script src="js/demo.js"></script>
    </body>    
</html>
