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
end