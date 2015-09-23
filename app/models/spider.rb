# require "nokogiri"
# require "mechanize"

# class Spider
# 	BAOMING_HASH = {}
# 	TONGZHI_ARRAY =[]
# 	url = "http://www.hvett.com.cn/"
# 	agent = Mechanize.new
#   page = agent.get('http://www.hvett.com.cn/index.php')

#   #国培通知
#   page.search(".main2_td1")[0].search(".table_zcwj_list a").each do |link|
#   	TONGZHI_HASH = {}
#     TONGZHI_HASH['link'] = url + link['href'].to_s
#     TONGZHI_HASH['text'] = link.text
#     TONGZHI_HASH['time'] = link.next_element.text
#     TONGZHI_ARRAY << TONGZHI_HASH
#   end

#   #国培报名
#   page.search(".main2_td1")[1].search(".table_zcwj_list a").each do |link|
#     BAOMING_HASH[link.text] = url + link['href']
#   end
# end
