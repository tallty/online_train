#左边栏效果
$ ->
	$(window).scroll ->
		if $(window).scrollTop()> 64
			$("#leftMenu").css("top",0)
		else
			$("#leftMenu").css("top",'64px')