var options = {
	dataUrl: "http://192.168.1.107:8090/AcceptLanguage",
	supportLocale: true
};
i18n.init(options);

$(function() {
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
	    $(this).append(" : " + i18n.msgStore.language);
	});
});
