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
        :abbreviation => 'Alabama',
        :common_name => 'AL'
      },
      {
        :abbreviation => 'Alaska',
        :common_name => 'AK'
      },
      {
        :abbreviation => 'Arizona',
        :common_name => 'AZ'
      },
      {
        :abbreviation => 'Arkansas',
        :common_name => 'AR'
      },
      {
        :abbreviation => 'California',
        :common_name => 'CA'
      },
      {
        :abbreviation => 'Colorado',
        :common_name => 'CO'
      },
      {
        :abbreviation => 'Connecticut',
        :common_name =>'CT'
      },
      {
        :abbreviation => 'Delaware',
        :common_name => 'DE'
      },
      {
        :abbreviation => 'Florida',
        :common_name => 'FL'
      },
      {
        :abbreviation => 'Georgia',
        :common_name => 'GA'
      },
      {
        :abbreviation => 'Hawaii',
        :common_name => 'HI'
      },
      {
        :abbreviation => 'Idaho',
        :common_name => 'ID'
      },
      {
        :abbreviation => 'Illinois',
        :common_name => 'IL'
      },
      {
        :abbreviation => 'Indiana',
        :common_name => 'IN'
      },
      {
        :abbreviation => 'Iowa',
        :common_name => 'IA'
      },
      {
        :abbreviation => 'Kansas',
        :common_name => 'KS'
      },
      {
        :abbreviation => 'Kentucky',
        :common_name => 'KY'
      },
      {
        :abbreviation => 'Louisiana',
        :common_name => 'LA'
      },
      {
        :abbreviation =>  'Maine',
        :common_name =>  'ME'
      },
      {
        :abbreviation => 'Maryland',
        :common_name => 'MD'
      },
      {
        :abbreviation => 'Massachusetts',
        :common_name => 'MA'
      },
      {
        :abbreviation => 'Michigan',
        :common_name => 'MI'
      },
      {
        :abbreviation => 'Minnesota',
        :common_name => 'MN'
      },
      {
        :abbreviation => 'Mississippi',
        :common_name => 'MS'
      },
      {
        :abbreviation => 'Missouri',
        :common_name => 'MO'
      },
      {
        :abbreviation =>  'Montana',
        :common_name =>  'MT'
      },
      {
        :abbreviation => 'Nebraska',
        :common_name => 'NE'
      },
      {
        :abbreviation => 'Nevada',
        :common_name => 'NV'
      },
      {
        :abbreviation => 'New Hampshire',
        :common_name => 'NH'
      },
      {
        :abbreviation => 'New Jersey',
        :common_name => 'NJ'
      },
      {
        :abbreviation => 'New Mexico',
        :common_name => 'NM'
      },
      {
        :abbreviation => 'New York',
        :common_name => 'NY'
      },
      {
        :abbreviation => 'North Carolina',
        :common_name => 'NC'
      },
      {
        :abbreviation => 'North Dakota',
        :common_name => 'ND'
      },
      {
        :abbreviation => 'Ohio',
        :common_name => 'OH'
      },
      {
        :abbreviation => 'Oklahoma',
        :common_name => 'OK'
      },
      {
        :abbreviation => 'Oregon',
        :common_name => 'OR'
      },
      {
        :abbreviation => 'Pennsylvania',
        :common_name => 'PA'
      },
      {
        :abbreviation => 'Rhode Island',
        :common_name => 'RI'
      },
      {
        :abbreviation => 'South Carolina',
        :common_name => 'SC'
      },
      {
        :abbreviation => 'South Dakota',
        :common_name => 'SD'
      },
      {
        :abbreviation => 'Tennessee',
        :common_name => 'TN'
      },
      {
        :abbreviation => 'Texas',
        :common_name => 'TX'
      },
      {
        :abbreviation => 'Utah',
        :common_name => 'UT'
      },
      {
        :abbreviation => 'Vermont',
        :common_name => 'VT'
      },
      {
        :abbreviation => 'Virginia',
        :common_name => 'VA'
      },
      {
        :abbreviation => 'Washington',
        :common_name => 'WA'
      },
      {
        :abbreviation => 'Washington, D.C.',
        :common_name => 'DC'
      },
      {
        :abbreviation =>  'West Virginia',
        :common_name => 'WV'
      },
      {
        :abbreviation => 'Wisconsin',
        :common_name => 'WI'
      },
      {
        :abbreviation =>  'Wyoming',
        :common_name => 'WY'
      },
    ]
    }]
}
Country.create!(params[:countries])
