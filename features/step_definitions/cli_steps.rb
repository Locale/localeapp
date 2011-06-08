require 'net/http'
require 'time'

When /^I have a valid project on localeapp\.com with api key "([^"]*)"$/ do |api_key|
  uri = "http://api.localeapp.com/projects/#{api_key}.json"
  body = valid_project_data.to_json
  add_fake_web_uri(:get, uri, ['200', 'OK'], body)
  add_fake_web_uri(:post, "http://api.localeapp.com/projects/#{api_key}/import/", ['202', 'OK'], '')
end

When /^I have a valid project on localeapp\.com but an incorrect api key "([^"]*)"$/ do |bad_api_key|
  uri = "http://api.localeapp.com/projects/#{bad_api_key}.json"
  body = valid_project_data.to_json
  add_fake_web_uri(:get, uri, ['404', 'Not Found'], body)
end

When /^I have a translations on localeapp\.com for the project with api key "([^"]*)"$/ do |api_key|
  uri = "http://api.localeapp.com/projects/#{api_key}/translations.json"
  body = valid_translation_data.to_json
  add_fake_web_uri(:get, uri, ['200', 'OK'], body)
end

When /^new translations for the api key "([^"]*)" since "([^"]*)" with time "([^"]*)"$/ do |api_key, update_time, new_time|
  uri = "http://api.localeapp.com/projects/#{api_key}/translations.json?updated_at=#{update_time}"
  body = valid_translation_data.to_json
  add_fake_web_uri(:get, uri, ['200', 'OK'], body, 'date' => Time.at(new_time.to_i).httpdate)
end