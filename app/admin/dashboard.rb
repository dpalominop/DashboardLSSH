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
      panel I18n.t("active_admin.sessions_all") do
        line_chart Session.group_by_day(:created_at, last: 7).count, download: true
      end
    end
  end

  columns do
    column do
      panel I18n.t("active_admin.sessions_by_empleado") do
        column_chart Employee.all.map { |employee| if employee.sessions.group_by_day(:created_at, last: 7).count.size >0 then
                                                {
                                                  name: employee
                                                        .name,
                                                  data: employee
                                                        .sessions
                                                        .group_by_day(:created_at, last: 7)
                                                        .count
                                                }
                                              end
                                    }, download: true
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
