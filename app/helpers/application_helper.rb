module ApplicationHelper
  def he_privacy
    he_privacy = {
      personal: "אישי",
      team: "צוותי",
      internal: "פנים תנועתי",
      commons: "ציבורי"
    }
  end
  def he_status
    he_status = {
      not_approved: "לא מאושר",
      approved: "מאושר"
    }
  end
  def he_bool
    he_bool = {
      false: "לא",
      true: "כן"
    }
  end
end
