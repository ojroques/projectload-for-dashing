# Description
Fetch and display the load and quality of one or multiple projects from a Google Spreadsheet. The background color is automatically adjusted according to the project load. It is assumed here that you already have Google Service credentials. For more information, check out these links:
* [Sheets API - Ruby Quickstart](https://developers.google.com/sheets/api/quickstart/ruby)
* [OAuth 2.0 for Server to Server Applications](https://developers.google.com/api-client-library/ruby/auth/service-accounts)
* [Google Application Default Credentials](https://developers.google.com/identity/protocols/application-default-credentials)

# Installation
* Install the Google API client: `gem install 'google-api-client'`.
* Create an environment variable called `GOOGLE_APPLICATION_CREDENTIALS` pointing to your Google credentials.
* Add `gem 'google-api-client', :require => 'google/apis'` to `Gemfile` located at the root of your dashing project and run `bundle update` if necessary.
* Move the files to the corresponding folders.

# Usage
Follow these steps to create a new project row in Google Sheet and its associated widget:
1. Make sure `SPREADSHEET_ID` in `project_load.rb` correspond to your [Google Sheet ID](https://developers.google.com/sheets/api/guides/concepts#spreadsheet_id).
2. Add a new row in your Google Sheet:
    * The project row must at least have these properties: _ID_, _Logo_, _Name_, _Load_ and _Quality_.
    * _ID_ is an unique string that will be used to identify the project's wigdet.
    * To add a logo, select the cell and format it with `=IMAGE("URL")`. The logo should be black and white, on a transparent background for aesthetic purposes.
3. Change `range` in `project_load.rb` to match your own Google Sheet columns, as well as the variables at the end of the file.
4. Add the following code to your dashboard layout file.
```
<li data-row="1" data-col="1" data-sizex="2" data-sizey="1">
    <div data-id="project-id" data-view="ProjectLoad" data-logowidth="330" data-loadmin="0" data-loadmax="5" data-qualitymin="0" data-qualitymax="5" data-light="1" data-heavy="4"></div>
</li>
```
The arguments are:
   * `data-id`, the project ID defined earlier.
   * `data-view`, this widget.
   * `data-logowidth` is optional and can be used to adjust the logo width.
   * `data-loadmin` is the load minimum value.
   * `data-loadmax` is the load maximum value.
   * `data-qualitymin` is the quality minimum value.
   * `data-qualitymax` is the quality maximum value.
   * `data-light` is the low threshold for the load.
   * `data-heavy` is the high threshold for the load.

You can also change the load meter height and width with the arguments `data-width` and `data-height`. To use the company's name instead of its logo, uncomment the indicated line in `project_load.html`.

# Screenshots
![Sheet Example](screenshots/sheet_example.png)

![ProjectLoad Preview](screenshots/project_load.png)
