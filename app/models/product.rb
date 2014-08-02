class Product < ActiveRecord::Base
  has_many    :product_assets, :dependent => :destroy
  has_many    :emails, :as => :mediator

  has_attached_file :avatar, :styles => {:xmedium => "450x450>", :thumb2 => "200x220>", :medium => "60x60>" }, :default_url => ActionController::Base.helpers.asset_path("/:style/missing.png")
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  acts_as_paranoid

  has_ransackable_associations %w(tags comments emails)

  serialize :subscribed_users, Set

  scope :my, -> { accessible_by(User.current_ability) }

  scope :created_by,  ->(user) { where(:user_id => user.id) }
  scope :assigned_to, ->(user) { where(:assigned_to => user.id) }

  scope :state, ->(filters) {
    where('stage IN (?)' + (filters.delete('other') ? ' OR stage IS NULL' : ''), filters)
  }
  scope :active,         -> { where("opportunities.stage = 'active'") }
  scope :deactivated,        -> { where("opportunities.stage = 'deactivated'") }

  # Search by name OR id
  scope :text_search, ->(query) {
    if query =~ /\A\d+\z/
      where('upper(name) LIKE upper(:name) OR productions.id = :id', :name => "%#{query}%", :id => query)
    else
      search('name_cont' => query).result
    end
  }


  #validates :stage, :inclusion => { :in => Proc.new { Setting.unroll(:product_stage).map{|s| s.last.to_s } } }

  def self.default_stage; Setting[:product_default_stage].try(:to_s) || 'active'; end

  acts_as_commentable
  uses_comment_extensions
  acts_as_taggable_on :tags
  has_paper_trail

  sortable :by => [ "name ASC", "created_at DESC", "updated_at DESC" ], :default => "created_at DESC"

  validates_presence_of :name

  def self.per_page ; 20                  ; end
  def self.first_name_position ; "before" ; end

end
