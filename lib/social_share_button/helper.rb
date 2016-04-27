# coding: utf-8
module SocialShareButton
  module Helper
    def social_share_button_tag(title = "", opts = {})
      opts[:allow_sites] = SocialShareButton.config.allow_sites
      wrap_links(title, opts)
    end

    private
    def wrap_links(title, opts)
      data = {
        :title => h(title),
        :img => opts[:image],
        :url => opts[:url],
        :desc => opts[:desc],
        :popup => opts[:popup],
        :via => opts[:via],
        :hashtag => opts[:hashtag]
      }
      content_tag :div, class: 'social_share_button', data: data do
        opts[:allow_sites].map do |name|
          extra_data = {}
          extra_data = opts.select { |k, _| k.to_s.start_with?('data') } if name.eql?('tumblr')
          special_data = opts.select { |k, _| k.to_s.start_with?('data-' + name) }
          link_title = t "social_share_button.share_to", :name => t("social_share_button.#{name.downcase}")
          link_to(opts[:body], "#", { :rel => ["nofollow", opts[:rel]],
                                      :class => "link",
                                      :onclick => "return SocialShareButton.share(this);",
                                      :title => h(link_title),
                                      :data => {:site => name}
                                    }.merge(extra_data).merge(special_data))
        end.join.html_safe
      end
    end
  end
end
