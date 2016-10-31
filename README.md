## Infinitive Scrolling in Rails

* gem 'will_paginate'
* gem 'betterlorem'
* gem 'bootstrap-sass'
* gem 'bootstrap-will_paginate'

Yukarıdaki gemler Gemfile dosyasına eklenir.

Post model ve controller oluşturulduktan sonra :

* pagination.js.coffe dosyası oluşturulur. Burada scrolling işleminin javascript kodları bulunur.

```javascript
 jQuery ->
   if $('#infinite-scrolling').size() > 0
     $(window).bindWithDelay 'scroll', ->
       more_posts_url = $('#infinite-scrolling .next_page a').attr('href') # <--------
       if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
         $('#infinite-scrolling .pagination').html( # <--------
           '<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />') # <--------
         $.getScript more_posts_url, ->
           window.location.hash = more_posts_url.match(page_regexp)[0]
       return
     , 100
   return
```

* posts_controller.rb içinde index metoduna formatı karşılayan kod eklenir.

```ruby
 respond_to do |format|
       format.html
       format.js
 end
```

* index.js.erb dosyası view klasörü içinde oluşturulur. Bu sayfa js döndürüldüğünde render edilecek görüntüdür. Yani scroll işlemi ile next page ile dönen görüntüyü döndürür.
```html
 $('#my-posts').append('<%= j render @posts %>');
 <% if @posts.next_page %>
 $('.pagination').replaceWith('<%= j will_paginate @posts %>');
 <% else %>
 $('.pagination').remove();
 <% end %>
```
* pagination.js.coffee dosyasına bindWithDelay metodu eklersek, metod içindeki kodları verilen süre kadar geciktirir.
```javascript
 $(window).bindWithDelay 'scroll', ->
 #codes
 , 100
```
