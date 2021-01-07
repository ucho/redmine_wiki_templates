require 'redmine'
require 'wiki_templates_application_hooks'

Rails.configuration.to_prepare do
  require_dependency 'projects_helper'
  WikiTemplatesProjectsHelperPatch::ProjectSettingsTabs.apply
end

Redmine::Plugin.register :redmine_wiki_templates do
  name 'Redmine Wiki Templates plugin'
  author 'Marta Gonzalez de Chaves Aguilera, Daigo UCHIYAMA'
  description 'This plugin allow you choose a wiki template when you add a new wiki page.'
  version '0.3.1'
  url 'https://github.com/ucho/redmine_wiki_templates'
  requires_redmine :version_or_higher => '3.0.0'
  project_module :wiki_templates do
    permission :show_wiki_templates, {:wiki_templates => [:load]}
    permission :manage_wiki_templates, {:wiki_templates => [:new, :edit, :update, :destroy, :preview]}
  end
end
