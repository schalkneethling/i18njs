class HomeController < ApplicationController
  def index
  end

  def accept_language
    httpLang = request.env["HTTP_ACCEPT_LANGUAGE"];
    lang = httpLang[0, httpLang.index(",")]

    render :text => lang
  end

end
