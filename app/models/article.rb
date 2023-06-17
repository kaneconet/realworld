class Article < ApplicationRecord
  # バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true

  # バリデーションの前にslugを生成する
  before_validation :generate_slug

  private

  def generate_slug
    # slugが未定義の場合、titleを元にslugを生成する
    self.slug ||= title.parameterize if title
  end
end
