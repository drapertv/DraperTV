ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    render partial: "admin_users"
    render partial: "about_team"
    render partial: "categories"
  end 
end
