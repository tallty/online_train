# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#tranApplyInfoContent ul li").click ->
    $(this).addClass("active").siblings().removeClass("active")
    $("#tranApplyInfoContent .apply-info-tab").hide()
    $("#tranApplyInfoContent .apply-info-tab").eq($(this).index()).show()
