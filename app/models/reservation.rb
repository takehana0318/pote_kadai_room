class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # バリデーション
  validates :check_in, :check_out, :guests, presence: true
  validates :guests, numericality: { greater_than_or_equal_to: 1, message: "は1人以上である必要があります" }
  validate :check_in_date_must_be_in_the_future
  validate :check_out_date_after_check_in_date

  # 宿泊日数を計算
  def stay_duration
    (check_out - check_in).to_i
  end

  # 支払い金額を計算
  def total_price
    room.price_per_day * stay_duration * guests
  end

  private

  def check_in_date_must_be_in_the_future
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "は本日以降の日付である必要があります")
    end
  end

  def check_out_date_after_check_in_date
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付である必要があります")
    end
  end
end
