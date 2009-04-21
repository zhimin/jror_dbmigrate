if [%1]==[] goto development
  vendor\jruby-1.2.0\bin\jruby -S rake bootstrap RAILS_ENV=%1
  goto end
:development
  vendor\jruby-1.2.0\bin\jruby -S rake bootstrap RAILS_ENV=development
:end