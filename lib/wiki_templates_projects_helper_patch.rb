module WikiTemplatesProjectsHelperPatch
  module ProjectSettingsTabs
    def self.apply
        ProjectsController.send :helper, WikiTemplatesProjectsHelperPatch::ProjectSettingsTabs
    end

    def project_settings_tabs
      tabs = super
      if @project.module_enabled?(:wiki_templates) and User.current.allowed_to?(:manage_wiki_templates, @project)
        tabs.push({
          :name => 'wiki_templates',
          :partial => 'wiki_templates/index',
          :label => :project_module_wiki_templates
        })
      end
      tabs
    end
  end
end
