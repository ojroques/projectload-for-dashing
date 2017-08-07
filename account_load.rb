require 'googleauth'
require 'google/apis/sheets_v4'
require 'json'

APPLICATION_NAME = 'Account Widget'
SPREADSHEET_ID = 'YOUR-SHEET-ID'

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
    range = 'A' + i_string + ':E' + i_string
    response = sheet.get_spreadsheet_values(SPREADSHEET_ID, range, value_render_option: render_option)
    account = JSON.parse(response.to_json)

    if !account.key?("values")
      break
    end

    account_values   = account["values"][0]
    account_id       = account_values[0]
    account_logo_url = account_values[1].split('"')[1]
    account_name     = account_values[2]
    account_load     = account_values[3]
    account_quality  = account_values[4]
    send_event(account_id, account_logo_url: account_logo_url, account_name: account_name, account_load: account_load, account_quality: account_quality)
    i += 1
  end
end
