# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#detailMenu li").click ->
    $(this).addClass("active").siblings().removeClass("active")
    $("#gradeDetailContent .grade-detail-info").hide()
    $("#gradeDetailContent .grade-detail-info").eq($(this).index()).show()