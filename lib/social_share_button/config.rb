module SocialShareButton

  class << self
    attr_accessor :config
    def configure
      yield self.config ||= Config.new
      config.allow_sites.each do |name|
        SocialShareButton::Helper.send :define_method, "#{name}_button_tag" do |title = "", opts = {}|
          opts[:allow_sites] = [name]
          wrap_links(title, opts)
        end
      end
    end
  end

  class Config
    # enable social sites to share,
    # * default : twitter facebook weibo douban
    # * site support: twitter facebook weibo douban
    attr_accessor :allow_sites

    def initialize
    end
  end
end
