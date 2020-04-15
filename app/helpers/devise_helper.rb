module DeviseHelper
  # Deviseで使われているkeyをBootstrapのAlertで使われているクラス名に置き換える
  def bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    when "success"
      key
    when "info"
      key
    when "warning"
      key
    end
  end

  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    messages = resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
          <span class="sr-only">close</span>
        </button>
        #{errmsg}
      </div>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end