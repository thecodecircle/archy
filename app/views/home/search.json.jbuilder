json.set! :data do
  json.array! @documents do |document|
    json.title link_to document.title, document
    json.description document.description
    json.content document.content
    json.user User.find(document.user_id).name
    json.date document.date.strftime("%Y") if document.date
    json.tags document.tag_list
    if user_signed_in? && current_user.admin?
        json.privacy he_privacy[document.privacy.to_sym] if document.privacy.present?
        if params[:approving]
            json.status link_to he_status[document.status.to_sym], toggle_status_path(clicked_document: document.id)
        end
    end
    json.url "#{link_to "<i class='material-icons'>edit</i>".html_safe, edit_document_path(document)} #{link_to "<i class='material-icons'>delete</i>".html_safe, document, method: :delete, data: { confirm: 'בטוח/ה?' }}"
  end
  unless params[:approving]
    json.array! @meetings do |meeting|
        json.title link_to meeting.subject, team_meeting_path(meeting, meeting.team)
        json.description "לפגישות אין תיאור"
        json.content meeting.content
        json.user meeting.team.name
        json.date meeting.created_at.strftime("%Y")
        json.tags meeting.tag_list
        if user_signed_in? && current_user.admin?
            json.privacy he_privacy[meeting.privacy.to_sym]
        end
    end
  end
end