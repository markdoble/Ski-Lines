class Article < ActiveRecord::Base


  validates_presence_of :location
  validates_presence_of :title
  validates_presence_of :source
  validates_presence_of :date_published

  validates_presence_of :publish

  has_attached_file :orig_content_photo,
                      :styles => { :medium => "300x300>",
                                   :thumb => "100x100>",
                                   :large => "500x500" },
                      :storage => :s3,
                      :s3_protocol => :https,
                      :s3_credentials => {
                        :bucket => ENV['S3_BUCKET'],
                        :access_key_id => ENV['AWS_KEY_ID'],
                        :secret_access_key => ENV['AWS_ACCESS_KEY']

                      }

  validates_attachment_content_type :orig_content_photo, :content_type => /\Aimage\/.*\Z/

  scope :publish, -> { where(publish: "Yes") }

  def self.cross_country_all
  where(publish: 'Yes').order("date_published DESC", "created_at DESC", "description ASC")
  end

  def self.no_video
    where.not("image like ? OR image like ?", "%facebook%", "%youtube%")
  end

  def self.admin_cross_country_unpub
  where(publish: 'No').order("date_published DESC", "created_at DESC", "description ASC")
  end

  def self.article_featured
  where(notes: 'Featured').order("date_published DESC", "created_at DESC", "description ASC")
  end

  def self.admin_cross_country_all
  order("date_published DESC", "created_at DESC", "description ASC")
  end

  def self.admin_never_publish
  where(publish: 'Never').order("date_published DESC", "created_at DESC", "description ASC")
  end

  def self.admin_publish_pending
  where(publish: 'Pending').order("date_published DESC", "created_at DESC", "description ASC")
  end

  def self.search(query)
      where('title ilike :q or source ilike :q', q: "%#{query}%")
  end
  def self.video_filter
      where("image like ? OR image like ?", "%facebook%", "%youtube%")
  end

  def slug
      title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

  def to_param
    "#{id}-#{slug}"
  end



end
