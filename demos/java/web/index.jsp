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
        <style type="text/css">
            .error {
                background-color: #c80000;
                color: #fff;
                padding: .5em;
                font-size: 11px;
                height: 1%;
            }
        </style>
    </head>
    <body>
        <h1>Sign Up</h1>
	<ul id="langswitch">
            <li><a href="#switchlang" lang="fr">French</a></li>
            <li><a href="#switchlang" lang="de">German</a></li>
        </ul>
        <form name="signup" id="signup" action="./" method="post">
            <fieldset>
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
        <p><a href="javascript:" id="lang">Show Language</a></p>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
        <script src="js/i18n.js"></script>
        <script>
            var options = {
                dataUrl: "http://192.168.1.107:8090/AcceptLanguage",
                supportLocale: true
            };
            i18n.init(options);

            $().ready(function() {
                // Check for digits
                var rdigit = /\d/,
                showError = function(ctx, msgKey) {
                    var errorContainer = document.createElement("p");
                    errorContainer.setAttribute("class", "error");

                    //First remove any error messages so we do not duplicate
                    ctx.next(".error").remove();
                    $(errorContainer).append(i18n.msgStore[msgKey]).insertAfter(ctx);
                };

                // Overriding language set based on user selection
                $("#langswitch a").each(function() {
		    $(this).click(function(event) {
		        event.preventDefault();
		        i18n.userSelected($(this).attr("lang"));
		    });
		});

                $("#first_name").blur(function(event) {

                    var nameErr = $(this).next(".error");

                    if($.trim($(this).val()) === "") {
                       showError($(this), "firstNameReq");
                    } else if(nameErr) {
                        nameErr.remove();
                    }
                });

                $("#landline").blur(function(event) {

                    var numberErr = $(this).next(".error");

                    if(!rdigit.test($(this).val())) {
                       showError($(this), "phoneNumber");
                    } else if(numberErr) {
                        numberErr.remove();
                    }
                });

                $("#email").blur(function(event) {

                    var emailErr = $(this).next(".error");

                    if($.trim($(this).val()) === "") {
                       showError($(this), "emailInvalid");
                    } else if(emailErr) {
                        emailErr.remove();
                    }
                });

                $("#lang").click(function(event) {
                    event.preventDefault();
                    $("body").append("Language: " + i18n.msgStore.language);
                });
            });
        </script>
    </body>    
</html>
