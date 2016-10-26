class Stockproductfoto < ActiveRecord::Base
  belongs_to :stockproduct

  has_attached_file :foto,
                      :styles => { :medium => "600x600>",
                                   :thumb => "100x100>",
                                   :large => "1000x1000" },
                      :storage => :s3,
                      :s3_protocol => :https,
                      :s3_credentials => {
                        :bucket => ENV['S3_BUCKET'],
                        :access_key_id => ENV['AWS_KEY_ID'],
                        :secret_access_key => ENV['AWS_ACCESS_KEY']
                      }

  validates_attachment_content_type :foto, :content_type => /\Aimage\/.*\Z/
end
