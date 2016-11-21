class Admin::IntegrationsController < ApplicationController
  # Define the require elements
  require "net/http"
  require "net/https"
  require "uri"
  require "json"

  # Define the layout to be used
  layout "store_merchant_layout"

  # Define the before_action elements
  before_action :authenticate_user!
  before_action :verify_is_merchant

  def index
  end

  # Action that will make the oAuth authentication for Lightspeed POS API Integration.
  def lightspeed

    #=================================
    # DEV NOTES
    #=================================
    # Current dev steps to achieve oAuth authentication
    # Step 1: Navigate to http://localhost:3000/admin/integrations/lightspeed
    # Step 2: Navigate to the same URL, with the code added. Ex: http://localhost:3000/admin/integrations/lightspeed?code=0396dd0e885fd0ac1d9ca33d461997a8696629a8
    # --When this is live, we should not need to do step 2 as the oUath client should redirect to this automatically

    # On official launch, we will need to change the oUath from Lightspeed
    # Update the redirect uri to https://ski-lines.com/admin/integrations/Lightspeed
    # Update client_secret to something more meaningful

    # Check to see if the user is authenticated with Lightspeed. We can do this by checking the session value.
    @user_authenticated = false
    if !session[:lightspeed_access_token].blank?
      @user_authenticated = true
    end

    # If the user is not yet authenticated, we must make a request to get the proper access token required.
    if !@user_authenticated
      # Check to see if we were given a code. If so, the user has completed the oAuth and Lightspeed has returned the code to use.
      # With this code, we will be able to make the request to get the access token required.
      if !params[:code].blank?
        # We have a code. We can make the request to get the access token

        # Setup the request url and parameters.
        uri = URI('https://cloud.merchantos.com/oauth/access_token.php')
        req = Net::HTTP::Post.new(uri)
        req.set_form_data('client_id' => 'SkiLines', 'client_secret' => 'integration', 'grant_type' => 'authorization_code', 'redirect_uri' => 'https://ski-lines.com/admin/integration/lightspeed', 'code' => params[:code])

        # Make the https request to LightSpeed API for authentication.
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        response = https.request(req)

        # Parse the JSON response and get the access token.
        json_parsed_response = JSON.parse response.body
        session[:lightspeed_access_token] = json_parsed_response["access_token"]

        # Set the user as being authenticated.
        @user_authenticated = true
      end
    end

  end

  # Action that will list the inventory available for a merchant using their Lightspeed API Integration.
  def lightspeed_view_inventory

    # Setup the request url and parameters. We need to add the specific Authorization header for oAuth to work.
    # TODO must have custom ID for the account
    uri = URI.parse("https://api.merchantos.com/API/Account/139230/Item.json")
    req = Net::HTTP::Get.new(uri.path)
    req.add_field("Authorization", "OAuth " + session[:lightspeed_access_token])

    # Make the https get request.
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    response = https.request(req)

    # Set the parsed JSON response in a variable that is to be accessed from the view.
    @inventory_items = JSON.parse response.body

  end

  # Private functions
  private
    # Verify if the current user is logged in and is a merchant
    def verify_is_merchant
      (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.merchant?)
    end
end
