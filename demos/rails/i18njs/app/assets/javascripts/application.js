// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var options = {
    dataUrl: "/accept_lang",
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
	        i18n.userSelected($(this).attr("hreflang"));
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
