params = { :integration_types =>
  [
    {
      :name => 'Lightspeed Retail',
      :desc => 'Integration for Lightspeed Retail. Authentication is done with OAuth.',
      :status => true,
      :auth_method => 'OAuth',
      :always_authenticate => false,
    }
  ]
}

IntegrationType.create!(params[:integration_types])
