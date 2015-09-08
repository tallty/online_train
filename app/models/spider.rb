require "nokogiri"
require "mechanize"

class Spider
	TONGZHI_HASH = {}
	BAOMING_HASH = {}
	url = "http://www.hvett.com.cn/"
	agent = Mechanize.new
  page = agent.get('http://www.hvett.com.cn/index.php')

  #国培通知
  page.search(".main2_td1")[0].search(".table_zcwj_list a").each do |link|
    TONGZHI_HASH[link.text] = url + link['href'].to_s
  end

  #国培报名
  page.search(".main2_td1")[1].search(".table_zcwj_list a").each do |link|
    BAOMING_HASH[link.text] = url + link['href']
  end
end
