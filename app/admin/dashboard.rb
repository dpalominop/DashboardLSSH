ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

  # columns do
  #   column do
  #     panel "User Creation" do
  #       line_chart new_list_admin_users_path, download: true
  #     end
  #   end
  # end
  columns do
    column do
      panel I18n.t("active_admin.sessions") do
        line_chart Session.group_by_day_of_week(:created_at, format: "%a").count, download: true
      end
    end
  end
  # columns do
  #   column do
  #     panel "Employees Creation" do
  #       line_chart Employee.group_by_day_of_week(:created_at, format: "%a").count, download: true
  #     end
  #   end
  # end

  end # content
end
