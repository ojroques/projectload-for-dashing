# Description
Fetch and show the load and the quality of an account from a Google Spreadsheet. It is assumed here that you already have a Google Service account and credentials. For more information, check out these links:
* [Sheets API - Ruby Quickstart](https://developers.google.com/sheets/api/quickstart/ruby)
* [OAuth 2.0 for Server to Server Applications](https://developers.google.com/api-client-library/ruby/auth/service-accounts)
* [Google Application Default Credentials](https://developers.google.com/identity/protocols/application-default-credentials)

# Installation
* Install the Google API client: `gem install 'google-api-client'`
* Create an environment variable called `GOOGLE_APPLICATION_CREDENTIALS` pointing to `credentials.json`.
* Add `gem 'google-api-client', :require => 'google/apis'` to `Gemfile` located at the root of your dashing project.

# Usage
Follow these steps to create a new account and its associated widget:
1. Make sure `SPREADSHEET_ID` in `account_load.rb` correspond to your Google Sheet ID.
2. Add a new line in your Google Sheet:
    * ID is an unique string that will be used to identify the account's wigdet.
    * To add a logo, select the cell and format it with `=IMAGE("URL")`. The logo should have a transparent background for aesthetic purposes.
3. Add the following code to your dashboard layout file. The arguments are:
    * `data-id` is the ID from the gsheet.
    * `data-logowidth` is optional and can be used to adjust the logo width.
    * `style="background-color:#00A4C0"` is optional and set the widget background to the desired value.
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
    <div data-id="account-id" data-view="AccountLoad" data-logowidth="250" style="background-color:#00A4C0"></div>
</li>
```

# Screenshot
![Sheet Example](screenshots/sheet_example.png)

![AccountLoad Preview](screenshots/account_load.png)
