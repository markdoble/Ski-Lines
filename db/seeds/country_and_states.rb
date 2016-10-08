params =  { :countries =>
    [{
    :alpha_2_code =>  'CA',
    :common_name => "Canada",
    :states_attributes => [
        {
        :common_name => 'Alberta',
        :abbreviation => 'AB'
        },
        {
          :common_name => 'British Columbia',
          :abbreviation => 'BC'
        },
        {
          :common_name => 'Manitoba',
          :abbreviation =>  'MB'
        },
        {
          :common_name =>   'New Brunswick',
          :abbreviation => 'NB'
        },
        {
          :common_name => 'Newfoundland and Labrador',
          :abbreviation =>  'NL'
        },
        {
          :common_name => 'Northwest Territories',
          :abbreviation => 'NT'
        },
        {
          :common_name => 'Nova Scotia',
          :abbreviation => 'NS'
        },
        {
          :common_name => 'Nunavut',
          :abbreviation => 'NU'
        },
        {
          :common_name => 'Ontario',
          :abbreviation =>  'ON'
        },
        {
          :common_name => 'Prince Edward Island',
          :abbreviation => 'PE'
        },
        {
          :common_name => 'Quebec',
          :abbreviation => 'QC'
        },
        {
          :common_name => 'Saskatchewan',
          :abbreviation => 'SK'
        },
        {
          :common_name => 'Yukon',
          :abbreviation => 'YT'
        }
      ]
    },
    {
    :alpha_2_code => 'US',
    :common_name => "United States of America",
    :states_attributes => [
      {
        :common_name => 'Alabama',
        :abbreviation => 'AL'
      },
      {
        :common_name => 'Alaska',
        :abbreviation => 'AK'
      },
      {
        :common_name => 'Arizona',
        :abbreviation => 'AZ'
      },
      {
        :common_name => 'Arkansas',
        :abbreviation => 'AR'
      },
      {
        :common_name => 'California',
        :abbreviation => 'CA'
      },
      {
        :common_name => 'Colorado',
        :abbreviation => 'CO'
      },
      {
        :common_name => 'Connecticut',
        :abbreviation =>'CT'
      },
      {
        :common_name => 'Delaware',
        :abbreviation => 'DE'
      },
      {
        :common_name => 'Florida',
        :abbreviation => 'FL'
      },
      {
        :common_name => 'Georgia',
        :abbreviation => 'GA'
      },
      {
        :common_name => 'Hawaii',
        :abbreviation => 'HI'
      },
      {
        :common_name => 'Idaho',
        :abbreviation => 'ID'
      },
      {
        :common_name => 'Illinois',
        :abbreviation => 'IL'
      },
      {
        :common_name => 'Indiana',
        :abbreviation => 'IN'
      },
      {
        :common_name => 'Iowa',
        :abbreviation => 'IA'
      },
      {
        :common_name => 'Kansas',
        :abbreviation => 'KS'
      },
      {
        :common_name => 'Kentucky',
        :abbreviation => 'KY'
      },
      {
        :common_name => 'Louisiana',
        :abbreviation => 'LA'
      },
      {
        :common_name =>  'Maine',
        :abbreviation =>  'ME'
      },
      {
        :common_name => 'Maryland',
        :abbreviation => 'MD'
      },
      {
        :common_name => 'Massachusetts',
        :abbreviation => 'MA'
      },
      {
        :common_name => 'Michigan',
        :abbreviation => 'MI'
      },
      {
        :common_name => 'Minnesota',
        :abbreviation => 'MN'
      },
      {
        :common_name => 'Mississippi',
        :abbreviation => 'MS'
      },
      {
        :common_name => 'Missouri',
        :abbreviation => 'MO'
      },
      {
        :common_name =>  'Montana',
        :abbreviation =>  'MT'
      },
      {
        :common_name => 'Nebraska',
        :abbreviation => 'NE'
      },
      {
        :common_name => 'Nevada',
        :abbreviation => 'NV'
      },
      {
        :common_name => 'New Hampshire',
        :abbreviation => 'NH'
      },
      {
        :common_name => 'New Jersey',
        :abbreviation => 'NJ'
      },
      {
        :common_name => 'New Mexico',
        :abbreviation => 'NM'
      },
      {
        :common_name => 'New York',
        :abbreviation => 'NY'
      },
      {
        :common_name => 'North Carolina',
        :abbreviation => 'NC'
      },
      {
        :common_name => 'North Dakota',
        :abbreviation => 'ND'
      },
      {
        :common_name => 'Ohio',
        :abbreviation => 'OH'
      },
      {
        :common_name => 'Oklahoma',
        :abbreviation => 'OK'
      },
      {
        :common_name => 'Oregon',
        :abbreviation => 'OR'
      },
      {
        :common_name => 'Pennsylvania',
        :abbreviation => 'PA'
      },
      {
        :common_name => 'Rhode Island',
        :abbreviation => 'RI'
      },
      {
        :common_name => 'South Carolina',
        :abbreviation => 'SC'
      },
      {
        :common_name => 'South Dakota',
        :abbreviation => 'SD'
      },
      {
        :common_name => 'Tennessee',
        :abbreviation => 'TN'
      },
      {
        :common_name => 'Texas',
        :abbreviation => 'TX'
      },
      {
        :common_name => 'Utah',
        :abbreviation => 'UT'
      },
      {
        :common_name => 'Vermont',
        :abbreviation => 'VT'
      },
      {
        :common_name => 'Virginia',
        :abbreviation => 'VA'
      },
      {
        :common_name => 'Washington',
        :abbreviation => 'WA'
      },
      {
        :common_name => 'Washington, D.C.',
        :abbreviation => 'DC'
      },
      {
        :common_name =>  'West Virginia',
        :abbreviation => 'WV'
      },
      {
        :common_name => 'Wisconsin',
        :abbreviation => 'WI'
      },
      {
        :common_name =>  'Wyoming',
        :abbreviation => 'WY'
      },
    ]
    }]
}
Country.create!(params[:countries])
