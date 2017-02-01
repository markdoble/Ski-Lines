class IntegrationsController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_action :verify_is_merchant

  # Define the require elemensts
  require "net/http"
  require "net/https"
  require "uri"
  require "json"

  # Gather the list of integrations to be displayed on the index
  def index
    @all_merchant_integrations = Integration.where(user_id: current_user.id).order(:id)
    @error = params[:error]
  end

  # Setup for the creation of a new integration
  def new
    # Retrieve all the active integration types
    @integration_types = IntegrationType.where(status: true).types_available_to_user(current_user.id)

    # Create the new integration object
    @integration = Integration.new
  end

  # Will retrieve a single integration to be displayed
  def show
    # Find the integration given the ID
    @integration = Integration.find(params[:id])
  end

  # Will retrieve a single integration to be edited
  def edit
    # Find the integration given the ID
    @integration = Integration.find(params[:id])
  end

  # Will update an existing integration record in the database given the parameters
  def update
    # Find the existing integration object by the ID
    @integration = Integration.find(params[:id])

    # Try and update to the database. If we have errors, we will redirect to the edit integration form
    if @integration.update(integration_params)
      # Redirect to the index
      redirect_to integrations_path
    else
      render 'edit'
    end
  end

  # Will remove an integration entry from the database given an ID
  def destroy
    # Find the existing integration objet by the ID
    @integration = Integration.find(params[:id])

    # Delete the integration and return to the index
    @integration.destroy
    redirect_to integrations_path
  end

  # Lightspeed Retail Integartion
  # Will accept a code parameter from the Lightspeed OAuth and retransmit that code to Lightspeed server
  # Once the code is retransmitted, the access_token will be provided which allows access to the merchant POS system
  def lightspeed
    # Check to see if we were given a code. If so, the user has completed the oAuth and Lightspeed has returned the code to use.
    # With this code, we will be able to make the request to get the access token required.
    if !params[:code].blank?
      # We have a code. We can make the request to get the access token
      begin
        # Setup the request url and parameters.
        uri = URI('https://cloud.merchantos.com/oauth/access_token.php')
        req = Net::HTTP::Post.new(uri)
        req.set_form_data('client_id' => 'SkiLines', 'client_secret' => 'integration', 'grant_type' => 'authorization_code', 'redirect_uri' => 'https://ski-lines.com/admin/integrations/lightspeed', 'code' => params[:code])

        # Make the https request to LightSpeed API for authentication.
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        response = https.request(req)

        # Parse the JSON response and get the access token and refresh_token.
        json_parsed_response = JSON.parse response.body
        access_token = json_parsed_response["access_token"]
        refresh_token = json_parsed_response["refresh_token"]

        # Retrieve the account ID. This ID is unique to every user of Lightspeed Retail and is required to query
        # Ex: https://api.merchantos.com/API/Account/[ACCOUNT ID]/Item.json will get products for a specific user
        uri = URI.parse("https://api.merchantos.com/API/Account.json")
        req = Net::HTTP::Get.new(uri.path)
        req.add_field("Authorization", "OAuth " + access_token)

        # Make the https get request.
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        response = https.request(req)

        # Parse the JSON response and get the Account ID.
        json_parsed_response = JSON.parse response.body
        account_id = json_parsed_response["Account"]["accountID"]

        # Create the new integration record for the current user
        # mtrottier:todo integration_type_id is currently hardcoded. Will eventually need to make this dynamic
        @integration = Integration.new(:user_id => current_user.id, :integration_type_id => 2, :account_external_id => account_id, :api_key => nil, :access_token => access_token, :refresh_token => refresh_token, :allow_auto_scrape => FALSE)
        @integration.save

        # Redirect to the integrations index after successul creation
        redirect_to integrations_path
      rescue
        # An error has occured. We will return to the integrations index
        redirect_to integrations_path(error: "lightspeed_retail")
      end

    else
      # The lightspeed controller action was initiated without a code parameter.
      # We will assume an error has occured and we will return to the integrations index
      redirect_to integrations_path(error: "lightspeed_retail")
    end

  end

  def sync_inventory
    puts "SYNC INVENTORY"

    redirect_to integrations_path
  end

  def lightspeed_view_inventory
    # Setup the request url and parameters. We need to add the specific Authorization header for oAuth to work.
    #uri = URI.parse("https://api.merchantos.com/API/Account/139230/Item.json")
    #req = Net::HTTP::Get.new(uri.path)
    #req.add_field("Authorization", "OAuth " + session[:lightspeed_access_token])

    # Make the https get request.
    #https = Net::HTTP.new(uri.host,uri.port)
    #https.use_ssl = true
    #response = https.request(req)
    # Set the parsed JSON response in a variable that is to be accessed from the view.
    #@inventory_items = JSON.parse response.body
 end

  # Private functions
  private

    # Define the required and permitted parameters for integration request variables
    def integration_params
      params.require(:integration).permit(:name, :allow_auto_scrape)
    end

    # Verifies if the current user is logged in and is a merchant
    # This will redirect them to the correct page
    def verify_is_merchant
        (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.merchant?)
    end

end
