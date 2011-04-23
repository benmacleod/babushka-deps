dep 'dev stack' do
  requires 'system wide deps'
end

dep 'system wide deps' do
  requires %w{core:curl.managed libraries benmacleod:rvm}
end

BIN_LIBS = %w{bison zsh}.map{|lib|"#{lib}.managed"}
PACKAGE_LIBS = %w{ruby-dev libxml2 libxml2-dev libsasl2-dev libxslt1-dev libxml2-dev
                  imagemagick libmagickcore-dev libmagickwand-dev}.map{|lib|"#{lib}.managed"}

BIN_LIBS.each do |lib|
  dep lib
end

PACKAGE_LIBS.each do |lib|
  dep lib do
    provides []
  end
end

dep 'postgres.managed' do
  installs{
    via :apt, %w[postgresql postgresql-client libpq-dev pgadmin3]
    via :brew, %w[postgresql pgadmin3]
  }
  provides 'psql', 'pgadmin3'
end

dep 'mongodb.managed' do
  provides 'mongo'
end

dep 'libraries' do
  requires BIN_LIBS + PACKAGE_LIBS + %W{postgres.managed mongodb.managed}
end
