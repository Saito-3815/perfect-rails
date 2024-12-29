module ApplicationHelper
  def to_hankaku(str)
    str.tr("ａ-ｚＡ-Ｚ", "a-zA-Z")
  end
end
