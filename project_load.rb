require 'googleauth'
require 'google/apis/sheets_v4'
require 'json'

APPLICATION_NAME = 'ProjectLoad Widget'
SPREADSHEET_ID = 'YOUR_SHEET_ID'

sheet = Google::Apis::SheetsV4::SheetsService.new
sheet.client_options.application_name = APPLICATION_NAME

# Get the environment configured authorization
scopes =  ['https://www.googleapis.com/auth/spreadsheets.readonly']
authorization = Google::Auth.get_application_default(scopes)
sheet.authorization = authorization
render_option = 'FORMULA'

SCHEDULER.every '5m', :first_in => 0 do |job|
  i = 2
  loop do
    i_string = i.to_s
    range = 'A' + i_string + ':E' + i_string    # DEFINE YOUR OWN RANGE HERE
    response = sheet.get_spreadsheet_values(SPREADSHEET_ID, range, value_render_option: render_option)
    project = JSON.parse(response.to_json)

    if !project.key?("values")
      break
    end

    project_values   = project["values"][0]
    # MATCH THE FOLLOWING VARIABLES WITH YOUR OWN COLUMNS
    project_id       = project_values[0]
    project_logo_url = project_values[1].split('"')[1]
    project_name     = project_values[2]
    project_load     = project_values[3]
    project_quality  = project_values[4]
    send_event(project_id, project_logo_url: project_logo_url, project_name: project_name, project_load: project_load, project_quality: project_quality)
    i += 1
  end
end
