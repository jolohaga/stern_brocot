require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('stern_brocot', '0.1.0') do |config|
  config.summary                  = 'Generate the Stern-Brocot tree and series.'
  config.author                   = 'Jose Hales-Garcia'
  config.url                      = 'http://github.com/jolohaga/stern_brocot'
  config.email                    = 'jolohaga@me.com' 
  config.ignore_pattern           = ["tmp/*",".hg/*", ".pkg/*", ".git/*"]
  config.development_dependencies = ['rspec >=1.3.0','echoe >=4.3']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|ext| load ext}
