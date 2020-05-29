module ApplicationHelper
  def default_meta_tags
    {
      title:       "Tickly（ティックリー）ビジネスライフマッチングサービス",
      description: "Ticklyは、ビジネスパーソン同士がストーリーや原体験に共感し、つながることで、ビジネスや人生が前進するような出会いを探せるビジネスライフマッチングサービスです。",
      keywords:    "Tickly, ビジネス, ビジネスライフ, ビジネスパーソン, 人生, ライフ, 共感, 出会い, つながり, 原体験, ストーリー, マッチング, マッチングサービス",
      # icon: image_url(""), # favicon
      noindex: ! Rails.env.production?, # production環境以外はnoindex  
      charset: "UTF-8",
      # OGPの設定
      og: {
        title: "Tickly（ティックリー）ビジネスライフマッチングサービス",
        type: "website",
        url: request.original_url,
        # image: image_url("OGPで設定する画像"),
        site_name: "Tickly（ティックリー）ビジネスライフマッチングサービス",
        description: "Ticklyは、ビジネスパーソン同士がストーリーや原体験に共感し、つながることで、ビジネスや人生が前進するような出会いを探せるビジネスライフマッチングサービスです。",
        locale: "ja_JP"
      },
      # twitter: {
      #   card: 'summary_large_image',
      #   site: '@ツイッターのアカウント名',
      # }
      fb: {
        app_id: ENV['FACEBOOK_ID_PRODUCTION']
      }
    }
  end
end
