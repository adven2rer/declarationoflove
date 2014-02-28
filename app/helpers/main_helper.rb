module MainHelper
  #Использую этот метод для получения массива ссылок
  def page_links
    pg_links = []
    Message.pgcount.times do |pg|
      #индексация массива начинается с единицы
      p = pg+1
      pg_links[p] = link_to(p, "/#{p}")
    end
    #возвращаем массив строк - ссылок на все страницы
    return pg_links
  end
  
 # list = if Message.pgcount > 10 
  #	style = :short_list
   # else
   # style = :full_list
   # end

  #def middle
  #		if pg_links[if pg_links.last - current_page % 2 == 0
  #			middle_link = pg_links.last.to_i - current_page.to_i / 2
  #		else 
  #         middle_link = (pg_links.last - current_page / 2)+1
  #       end
  #  	middle_link = pg_links[(middle_link)]
  #end

  def paginate(style = :full_list)
  	  mcount = Message.pgcount 
  	#if Message.pgcount > 1
		    #переменная pg_html хранит строку - html код отображения пагинации
		    pg_html = ""
		    pg_html += "<ul class=\"pagination\">"

		    #Если params["page"] не определен(в адресной строке нет номера страницы), то номер текущей страницы = 1
		    params["page"] ? current_page = params["page"].to_i : current_page = 1
		    pg_links = page_links
		    #проверяем какой режим выбран
		    case style
		    #если :full_list, то выводим ссылки на все страницы
		    when :full_list  then
		      pg_links.each_with_index do |page,key|
		        if key == current_page.to_i
		          pg_html += "<li class=\"active\">#{page}</li>"
		        elsif !page.nil?
		          pg_html += "<li>#{page}</li>"
		        end
		    end
		      

		    #если :short_list, то выводим ссылки на первую, последнюю и соседние страницы (по 2 с каждой стороны от текущей)
		    when :short_list then

		      #pg_html += <%= form_tag %> <%= text_field_tag :page_find %> "<input type=\"string\" class=\"form-control\" placeholder=\"Перейти на страницу...\">"<% end %> <%= submit_tag (name:"page_find", type: 'submit', class: "btn btn-default") %><% end %>

		      #if Message.pgcount > 4
		    	#  pg_html += "<%= form_tag(\"/search\", method: \"get\") do %><%= label_tag(:q, \"Search for:\") %><%= text_field_tag(:q) %><%= submit_tag(\"Search\") %><% end %>"
		      #end

		      if current_page == 1
		        pg_html += "<li class=\"active\">#{pg_links[1]}</li>"
		 	  else
		      	pg_html += "<li>#{pg_links[1]}</li>"
		      end

		      if current_page > 6
		        pg_html += "<li>#{pg_links[current_page-5]}</li>"
		      end

			  if current_page > 5
		        pg_html += "<li>#{pg_links[current_page-4]}</li>"
		      end

		      if current_page > 4
		        pg_html += "<li>#{pg_links[current_page-3]}</li>"
		      end

		      if current_page > 3
		        pg_html += "<li>#{pg_links[current_page-2]}</li>"
		      end
		 
		      if current_page > 2
		        pg_html += "<li>#{pg_links[current_page-1]}</li>"
		      end

		      if current_page > 1 and current_page < pg_links.size
		        pg_html += "<li class=\"active\">#{pg_links[current_page]}</li>"
		      end

		      if current_page < pg_links.count - 2
		        pg_html += "<li>#{pg_links[current_page+1]}</li>"
		      end
		 
		      if current_page < pg_links.count - 3
		        pg_html += "<li>#{pg_links[current_page+2]}</li>"
		      end

		      if current_page < pg_links.count - 4
		        pg_html += "<li>#{pg_links[current_page+3]}</li>"
		      end

			  if current_page < pg_links.count - 5
		        pg_html += "<li>#{pg_links[current_page+4]}</li>"
		      end

		      if current_page < pg_links.count - 6
		        pg_html += "<li>#{pg_links[current_page+5]}</li>"
		      end

		      #if (mcount - 3) - current_page > 6
		       # pg_html += "<li>#{pg_links[mcount-3]}</li>"
		      #end
		 
		      #if (mcount - 2) - current_page > 6
		      #else
		      #	pg_html += "<li>#{pg_links[mcount-2]}</li>"
		      #end

		      #if (mcount - 1) - current_page > 6
		      #else
		      #  pg_html += "<li>#{pg_links[mcount-1]}</li>"
		      #end

		      if mcount != current_page
		        pg_html += "<li>#{pg_links.last}</li>"
		      end

		    end
	pg_html += "</ul>"

      #if pg_links.last == current_page 
#      	pg_html ="<ul class=\"pagination\"><li class=\"active\">#{pg_links[current_page]}</li></ul>"
#
 #     pg_html += "<li>#{pg_links[1]}</li>"
#
 #     if current_page > 3
  #      pg_html += "<li>#{pg_links[current_page-2]}</li>"
   #   end
 #
  #    if current_page > 2
   #     pg_html += "<li>#{pg_links[current_page-1]}</li>"
    #  end
#
#
 #     if current_page < pg_links.size
  #      pg_html += "<li class=\"active\">#{pg_links[current_page]}</li>"
   #   end
    #  end

# 	  end
    #если вибран режим :prev_next, то показываем только ссылкии на предыдущую страницу и следующую
    #when :prev_next then
     #  pg_html += "<ul class=\"pager\">"
      #if current_page > 1
      #  pg_html += "<li><a href =\"#{pg_links[current_page - 1]}\"<b></b></span>"
     # end
     # if current_page < pg_links.size
      #  pg_html += "<span class=\"page_link next_page\"><b>#{pg_links[current_page + 1]}</b></span>"
      #end
    #end
    #	pg_html += "</ul>"
    #возвращаем html-код представляющий ссылки
    return raw pg_html
  end
end
