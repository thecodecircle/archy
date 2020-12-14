json.set! :data do
  json.array! @documents do |document|
    json.title link_to document.title, document
    json.description document.description.to_plain_text
    json.content document.content.to_plain_text
    json.user User.find(document.user_id).name
    json.date document.date.strftime("%Y") if document.date
    tags = ""
    document.tag_list.each do |t|
      tags += link_to t, search_path(tag: t)
      tags += ", " unless t == document.tag_list.last
    end
    json.tags "#{tags}"
    json.privacy he_privacy[document.privacy.to_sym] if document.privacy.present?
    json.status link_to he_status[document.status.to_sym], toggle_status_path(clicked_document: document.id)
    json.url "#{link_to "<i class='material-icons'>edit</i>".html_safe, edit_document_path(document)} #{link_to "<i class='material-icons'>delete</i>".html_safe, document, method: :delete, data: { confirm: 'בטוח/ה?' }}"
  end
  json.array! @meetings do |meeting|
      json.title link_to meeting.subject, team_meeting_path(meeting, meeting.team)
      json.description "לפגישות אין תיאור"
      json.content meeting.content.to_plain_text
      json.user meeting.team.name
      json.date meeting.created_at.strftime("%Y")
      json.tags "#{meeting.tag_list}"
      json.privacy he_privacy[meeting.privacy.to_sym]
      json.status "לפגישות אין סטטוס"
      json.url "#{link_to "<i class='material-icons'>edit</i>".html_safe, edit_team_meeting_path(meeting.team, meeting)} #{link_to "<i class='material-icons'>delete</i>".html_safe, team_meeting_path(meeting.team, meeting), method: :delete, data: { confirm: 'בטוח/ה?' }}"
  end
end