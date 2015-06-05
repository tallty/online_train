$ ->
  # 验证码刷新
  $("img[alt='captcha']").each (index, item) ->
    item.title = '看不清？点击刷新'
  $("img[alt='captcha']").bind 'click', (event) ->
    this.src = this.src