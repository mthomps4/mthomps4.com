# frozen_string_literal: true

module ApplicationHelper
  include ThemeHelper
  def default_meta_tags
    {
      site: 'Matt Thompson - Software Architect | Unplugged Engineer',
      title: 'Home',
      reverse: true,
      description: "Matt Thompson is a Software Architect by day and 'Unplugged Engineer' by night honing his craft to build in both the digital and physical world. Matt is also passionate about mentoring others and promating growth opportunities throughout.",
      keywords: 'Engineering, Software Engineer, Software Engineering, Leadership, AWS, Rails, Elixir, Node, React, Technology, Blog, Stripe, Twilio, Healthcare, Telecommunication',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      # icon: [
      #   { href: image_url('/favicon_io/favicon.ico') },
      #   { href: image_url('/favicon_io/apple-touch-icon.png'), rel: 'apple-touch-icon', sizes: '180x180' },
      #   { href: image_url('/favicon_io/favicon-32x32.png'), rel: 'icon', sizes: '32x32', type: 'image/png' },
      #   { href: image_url('/favicon_io/favicon-16x16.png'), rel: 'icon', sizes: '16x16', type: 'image/png' },
      #   { href: image_url('/favicon_io/android-chrome-192x192.png'), rel: 'icon', sizes: '192x192', type: 'image/png' },
      #   { href: image_url('/favicon_io/android-chrome-512x512.png'), rel: 'icon', sizes: '512x512', type: 'image/png' }
      # ],
      og: {
        site: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: :canonical,
        image: image_url('og-base.png')
      }
      # twitter: {
      #   card: 'summary',
      #   site: :site,
      #   title: :title,
      #   description: :description,
      #   image: { _: image_url('og-base.png'), width: 1200, height: 630, itemprop: 'image' }
      # }
    }
  end

  def merge_meta_tags(**options)
    options.reverse_merge!(default_meta_tags)
    set_meta_tags(options)
  end
end
